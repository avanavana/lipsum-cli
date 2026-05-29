#!/usr/bin/env python3

from __future__ import annotations

import argparse
import shutil
import subprocess
import tempfile
from pathlib import Path

from PIL import Image
from PIL import ImageChops
from PIL import ImageColor
from PIL import ImageDraw
from PIL import ImageFilter
from PIL import ImageSequence


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description='Convert an animated VHS GIF into an animated WebP with rounded transparency and a soft shadow.'
    )
    parser.add_argument('input', type=Path, help='Input animated GIF path.')
    parser.add_argument('output', type=Path, help='Output animated WebP path.')
    parser.add_argument('--margin', type=int, default=40, help='Outer margin around the terminal window.')
    parser.add_argument('--radius', type=int, default=10, help='Rounded-corner radius for the terminal window.')
    parser.add_argument('--key-color', default=None, help='Optional background key color to knock out before masking.')
    parser.add_argument('--key-fuzz', type=float, default=0.01, help='Key-color tolerance as a 0.0-1.0 fraction.')
    parser.add_argument('--shadow-blur', type=int, default=18, help='Gaussian blur radius for the shadow.')
    parser.add_argument('--shadow-offset-x', type=int, default=0, help='Horizontal shadow offset.')
    parser.add_argument('--shadow-offset-y', type=int, default=14, help='Vertical shadow offset.')
    parser.add_argument('--shadow-opacity', type=int, default=90, help='Shadow alpha, 0-255.')
    parser.add_argument('--quality', type=float, default=90.0, help='Animated WebP quality, 0-100.')
    parser.add_argument('--lossless', action='store_true', help='Write a lossless animated WebP.')
    parser.add_argument('--method', type=int, default=6, help='Animated WebP encoding method, 0-6.')
    return parser.parse_args()


def build_window_mask(size: tuple[int, int], margin: int, radius: int) -> Image.Image:
    width, height = size
    mask = Image.new('L', ( width, height ), 0)
    draw = ImageDraw.Draw(mask)
    draw.rounded_rectangle(
        ( margin, margin, width - margin, height - margin - 1 ),
        radius=radius,
        fill=255
    )
    return mask


def build_shadow(
    size: tuple[int, int],
    margin: int,
    radius: int,
    blur: int,
    offset_x: int,
    offset_y: int,
    opacity: int
) -> Image.Image:
    width, height = size
    shadow_mask = Image.new('L', ( width, height ), 0)
    draw = ImageDraw.Draw(shadow_mask)
    draw.rounded_rectangle(
        (
            margin + offset_x,
            margin + offset_y,
            width - margin + offset_x,
            height - margin - 1 + offset_y
        ),
        radius=radius,
        fill=max(0, min(255, opacity))
    )
    blurred_shadow_mask = shadow_mask.filter(ImageFilter.GaussianBlur(blur))
    shadow = Image.new('RGBA', ( width, height ), ( 0, 0, 0, 0 ))
    shadow.putalpha(blurred_shadow_mask)
    return shadow


def key_background(image: Image.Image, key_color: str, fuzz: float) -> Image.Image:
    rgba = image.convert('RGBA')
    key_rgb = ImageColor.getrgb(key_color)
    threshold = max(0.0, min(1.0, fuzz)) * 255.0
    threshold_sq = threshold * threshold * 3.0

    pixels = []
    for red, green, blue, alpha in list(rgba.getdata()):
        delta_red = red - key_rgb[0]
        delta_green = green - key_rgb[1]
        delta_blue = blue - key_rgb[2]
        distance_sq = (
            delta_red * delta_red
            + delta_green * delta_green
            + delta_blue * delta_blue
        )

        if distance_sq <= threshold_sq:
            pixels.append(( red, green, blue, 0 ))
        else:
            pixels.append(( red, green, blue, alpha ))

    rgba.putdata(pixels)
    return rgba


def apply_window_alpha(image: Image.Image, mask: Image.Image) -> Image.Image:
    rgba = image.convert('RGBA')
    existing_alpha = rgba.getchannel('A')
    combined_alpha = ImageChops.multiply(existing_alpha, mask)
    rgba.putalpha(combined_alpha)
    return rgba


def build_encoder_command(
    frame_paths: list[Path],
    durations: list[int],
    output_path: Path,
    loop: int,
    options: argparse.Namespace
) -> list[str]:
    command = ['img2webp', '-loop', str(loop)]

    for frame_path, duration in zip(frame_paths, durations):
        command.extend(['-d', str(duration)])
        if options.lossless:
            command.append('-lossless')
        else:
            command.extend(['-lossy', '-q', str(options.quality)])
        command.extend(['-m', str(options.method), '-exact', str(frame_path)])

    command.extend(['-o', str(output_path)])
    return command


def convert(input_path: Path, output_path: Path, options: argparse.Namespace) -> None:
    if shutil.which('img2webp') is None:
        raise SystemExit('img2webp is required but was not found on PATH.')

    image = Image.open(input_path)
    width, height = image.size

    window_mask = build_window_mask(( width, height ), options.margin, options.radius)
    shadow = build_shadow(
        ( width, height ),
        options.margin,
        options.radius,
        options.shadow_blur,
        options.shadow_offset_x,
        options.shadow_offset_y,
        options.shadow_opacity
    )

    default_duration = int(image.info.get('duration', 80))
    loop = int(image.info.get('loop', 0))

    output_path.parent.mkdir(parents=True, exist_ok=True)

    with tempfile.TemporaryDirectory(prefix='lipsum-shadow-frames-') as temp_dir_name:
        temp_dir = Path(temp_dir_name)
        frame_paths: list[Path] = []
        durations: list[int] = []

        for index, frame in enumerate(ImageSequence.Iterator(image), start=1):
            keyed_frame = frame.copy().convert('RGBA')
            if options.key_color:
                keyed_frame = key_background(keyed_frame, options.key_color, options.key_fuzz)

            terminal_frame = apply_window_alpha(keyed_frame, window_mask)
            canvas = Image.new('RGBA', ( width, height ), ( 0, 0, 0, 0 ))
            canvas.alpha_composite(shadow)
            canvas.alpha_composite(terminal_frame)

            frame_path = temp_dir / f'frame-{index:04d}.png'
            canvas.save(frame_path, format='PNG')
            frame_paths.append(frame_path)
            durations.append(int(frame.info.get('duration', default_duration)))

        command = build_encoder_command(frame_paths, durations, output_path, loop, options)
        subprocess.run(command, check=True)


def main() -> None:
    options = parse_args()

    if not options.input.is_file():
        raise SystemExit(f'Input file not found: {options.input}')

    convert(options.input, options.output, options)


if __name__ == '__main__':
    main()
