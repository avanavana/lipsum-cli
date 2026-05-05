# lipsum-cli

A small zsh CLI for generating randomized placeholder text from a local word corpus.

Current output modes:
- `characters`
- `words`
- `lines`
- `sentences`
- `paragraphs`

Current utility features:
- subcommand-only generation modes
- exact counts and random count ranges
- compact one-token short forms like `10c`, `s2`, `2-3l`, `P1-3`
- named source corpora with `--source`
- internal range controls
- lowercase, uppercase, and title-case output
- bullets and ordered lists for line output
- config-backed defaults from `~/.lipsum/config`
- built-in clipboard copying

## Requirements

- `zsh`
- a clipboard command if you want copy support:
  - `pbcopy` on macOS
  - `wl-copy`
  - `xclip`
  - `xsel`
  - or a custom command via `LIPSUM_CLIPBOARD_COMMAND`

## Installation

The installer sets up:
- `~/.local/bin/lipsum`
- `~/.lipsum/config`
- `~/.lipsum/words`
- `~/.lipsum/sources/`
- `~/.lipsum/templates/`

Bundled sources currently include:
- `lorem`
- `hipster`
- `es`
- `fr`
- `de`

From this project directory, run:

```sh
./install.sh
```

When a TTY is available, the installer opens a menu:

```text
Install lipsum and configure with:

> defaults
  interactive mode
  custom config in $EDITOR
```

Installer modes:
- `defaults`
  - install immediately with the built-in defaults
- `interactive mode`
  - walk through the config one setting at a time with previews
- `custom config in $EDITOR`
  - create or open the config directly in your editor, then validate it when you exit

Non-interactive installer options:

```sh
./install.sh --yes
./install.sh --interactive
EDITOR=nano ./install.sh --editor-config
```

If you prefer not to install yet, you can still run the script directly from the repo:

```sh
./lipsum 5 words
```

Once this repo is hosted publicly, the same installer can also be piped from the raw `install.sh` URL for a one-command setup.

## Usage

```text
lipsum [ options ] [ count|min-max ] [ command ]
lipsum [ options ] [ command ] [ count|min-max ]
lipsum [ other-action ]
```

Modes are subcommands only. They are not available as flags.

## Commands

- `c`, `C`, `char`, `chars`, `character`, `characters`
- `w`, `W`, `word`, `words`
- `l`, `L`, `line`, `lines`
- `s`, `S`, `sent`, `sents`, `sentence`, `sentences`
- `p`, `P`, `para`, `paras`, `paragraph`, `paragraphs`

If you omit the command, the default mode is `words` unless changed in config.

## Other Actions

- `init`
  - Create a starter config file at `~/.lipsum/config`.
- `config`
- `settings`
- `prefs`
- `preferences`
  - Open the config file in `$VISUAL`, `$EDITOR`, or `vi`.
- `sources`
- `list-sources`
  - List the available named source corpora and mark the configured default.

Notes:
- `lipsum config` creates the config file first if it does not exist.
- After the editor exits, `lipsum config` validates the file immediately.
- There is no `reload` command because the utility reads config fresh on every run.

## Options

- `-n`, `-N`, `--no-full-stop`
  - Suppress the trailing full stop normally added to generated output.
- `-l`, `-L`, `--lowercase`
  - Force lowercase output.
- `-u`, `-U`, `--uppercase`
  - Force uppercase output.
- `-t`, `-T`, `--title-case`
  - Force title-case output.
- `-s`, `-S`, `--source name`
  - Choose a named source corpus such as `lorem`, `hipster`, `es`, `fr`, or `de`.
- `-b`, `-B`, `--bullets [char]`
  - Prefix each generated line with a bullet marker.
- `-o`, `-O`, `--ordered-list [fmt]`
  - Prefix each generated line with an ordered marker.
  - Only valid for `lines`.
  - Default format: `%d.`
- `-r`, `-R`, `--range n|min-max`
  - `words`: filter generated words by word length in characters
  - if omitted for `words`, the default word-length range comes from config
  - `lines`: words per line
  - `sentences`: words per sentence
  - `paragraphs`: sentences per paragraph
  - `characters`: ignored
- `-c`, `-C`, `--copy`
  - Copy generated output to the clipboard and still print it.
- `--no-copy`
  - Disable clipboard copying even if enabled in config.
- `-h`, `-H`, `--help`
- `-v`, `-V`, `--version`

## Count Semantics

Top-level counts control how many units get generated.

Examples:

```sh
./lipsum 12
./lipsum 2 words
./lipsum words 2
./lipsum 3-5 words
./lipsum 4-6 lines
./lipsum lines 4-6
```

`3-5 words` means the command randomly chooses a count between 3 and 5, then generates that many words.

## Compact Short Forms

Single-letter subcommands can be combined directly with counts.

Examples:

```sh
./lipsum 10c
./lipsum s2
./lipsum 2-3l
./lipsum P1-3
```

These are equivalent to:

```sh
./lipsum 10 characters
./lipsum 2 sentences
./lipsum 2-3 lines
./lipsum 1-3 paragraphs
```

## Range Semantics

`--range` means different things depending on the command.

## Sources

You can list installed sources with:

```sh
./lipsum sources
```

You can select a source for a single invocation with:

```sh
./lipsum --source hipster 8 words
./lipsum -s es 2 paragraphs
```

You can also set a default source in `~/.lipsum/config`:

```sh
default_source='hipster'
```

Source lookup works like this:
- for `lorem`, the CLI first uses `LIPSUM_DICT` when set, then `~/.lipsum/sources/lorem.words`, then the legacy `~/.lipsum/words`
- for other source names, the CLI loads `~/.lipsum/sources/<name>.words`

### Words

For `words`, `--range` filters generated words by character length.

Examples:

```sh
./lipsum 5 words -r 3-4
./lipsum words 8 -r 6
```

### Lines

For `lines`, `--range` controls words per line.

Examples:

```sh
./lipsum 4-6 lines -r 6-10
./lipsum lines 5 -r 4
```

### Sentences

For `sentences`, `--range` controls words per sentence.

Examples:

```sh
./lipsum 2-4 sentences -r 5
./lipsum s3 -r 8-12
```

### Paragraphs

For `paragraphs`, `--range` controls sentences per paragraph.

Examples:

```sh
./lipsum 2 paragraphs -r 3
./lipsum P1-3 -r 2-4
```

### Characters

For `characters`, `--range` is ignored.

## Ordered List Formats

Markers support exactly one placeholder token:

- `%d` = digit (1-indexed)
- `%z` = digit (0-indexed)
- `%i` = lowercase roman
- `%I` = uppercase roman
- `%a` = lowercase alphabetical
- `%A` = uppercase alphabetical

Numeric placeholders can be zero-padded:

```sh
./lipsum 3 lines -o '%00z)'
```

Example outputs:

- `%d.` -> `1.`, `2.`, `3.`
- `(%A)` -> `(A)`, `(B)`, `(C)`
- `%00z)` -> `000)`, `001)`, `002)`

## Examples

Basic usage:

```sh
./lipsum
./lipsum 8
./lipsum --source fr 8 words
./lipsum 100 characters
./lipsum 3 paragraphs
```

Website-style bullets:

```sh
./lipsum 5 lines -b
./lipsum 5 lines -b '*'
./lipsum 4-6 lines -r 4-8 -b
```

Ordered lists:

```sh
./lipsum 4 lines -o
./lipsum 4 lines -o '(%A)'
./lipsum 4 lines -o '%00z)'
```

Case formatting:

```sh
./lipsum 6 words -n -l
./lipsum 6 words -n -u
./lipsum 6 words -n -t
```

Word-length filtering:

```sh
./lipsum 5 words -r 3-4
./lipsum 8 words -r 6
```

Clipboard:

```sh
./lipsum 5 lines -b -c
./lipsum 3 sentences --copy
./lipsum 4 words --no-copy
```

Pipelines and shell usage:

```sh
./lipsum 4 lines -b | nl -ba
./lipsum 1 paragraph | fold -s -w 40
printf '[%s]\n' "$('./lipsum' 4 words -n -l)"
printf '3\n5\n' | xargs -I{} zsh -c "'./lipsum' 1 lines -r \"\$1\" -b" _ {}
for n in 3 4 5; do ./lipsum 1 line -r "$n" -b; done
```

Config actions:

```sh
./lipsum init
./lipsum config
```

## Configuration

Initialize a starter config:

```sh
./lipsum init
```

Then edit it with:

```sh
./lipsum config
```

Current supported config keys:

```sh
default_mode='words'

default_word_count=10
default_character_count=32
default_line_count=5
default_sentence_count=4
default_paragraph_count=3

default_line_range='4-8'
default_sentence_range='6-14'
default_paragraph_range='3-5'
default_word_length_range='1-12'
default_paragraph_sentence_word_range='6-14'

default_bullet_char='–'
default_ordered_list_format='%d.'
copy_on_generate=0

default_source='lorem'
```

Notes:

- The config file is sourced by zsh, so values should stay shell-friendly.
- `copy_on_generate=1` makes clipboard copying the default.
- If you edit the config externally and introduce an error, that error appears the next time you run `lipsum`.
- If you edit via `lipsum config`, the command validates the config immediately after the editor exits.

## Environment Variables

- `LIPSUM_CONFIG`
  - Override the config file path.
- `LIPSUM_DICT`
  - Override the default corpus file path.
- `LIPSUM_CLIPBOARD_COMMAND`
  - Override clipboard handling with a custom shell command.
- `LIPSUM_MAX_CHARACTERS`
- `LIPSUM_MAX_WORDS`
- `LIPSUM_MAX_LINES`
- `LIPSUM_MAX_SENTENCES`
- `LIPSUM_MAX_PARAGRAPHS`
  - Override safety caps for large output requests.

## Notes

- `LIPSUM_MAX_CHARACTERS` can be larger than the source corpus length because character mode repeats the source text internally until it has enough material to sample from cleanly.
- Range filtering for `words` and range sizing for `lines`, `sentences`, and `paragraphs` are intentionally different behaviors.
- Range is ignored for `characters`.

## Testing

Run the suite from the project root:

```sh
./tests/run_lipsum_tests.zsh
```

Artifacts:

- Test runner: [tests/run_lipsum_tests.zsh](./tests/run_lipsum_tests.zsh)
- Latest report: [tests/lipsum-test-plan-and-results.md](./tests/lipsum-test-plan-and-results.md)

## Current Scope

Implemented:

- subcommand-only generation modes
- exact counts and random count ranges
- compact short forms
- case formatting controls
- word-length filters and per-unit ranges
- bullets and ordered lists
- config-backed defaults
- built-in clipboard copying

Planned next:

- alternate named sources
- importable custom corpora
- structured formats and templates
