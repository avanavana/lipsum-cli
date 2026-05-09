<!-- markdownlint-disable MD041 -->
<!-- markdownlint-disable MD014 -->
<!-- markdownlint-disable MD033 -->
<p align="center">
  <img src=".github/logo.svg" alt="lipsum-cli logo" width="280">
</p>

<p align="center">
  Generator textus locorum reservatorum pro linea mandatorum est.
</p>
<!-- markdownlint-enable MD033 -->

## Features

**Flexible generation modes**
Generate words, characters, lines, sentences, paragraphs, and reusable templates from one CLI. Counts can be exact or randomized over a range, with natural variation inside each unit.

**Source-driven styles**
Switch between classic lorem, hipster, tech, pirate, food, corporate, and i18n variants. You can also save your own source text from files, stdin, or inline input and reuse it by name.

**Companion source importer**
Use `lipsumize` to turn local text, HTML, EPUBs, stdin, or URLs into reusable corpora under `~/.lipsum/sources/`. It keeps ingestion separate from generation while sharing the same source library.

**Design-friendly controls**
Shape the output with bullets, ordered lists, punctuation modes, casing, emoji, and word-length filters. It works well for mockups, prototypes, demos, sample payloads, and content skeletons.

**Structured output formats**
Render as plain text, HTML, Markdown, JSON, or NDJSON. That makes it easy to pipe into other shell tools or drop directly into product and content workflows.

**Configurable defaults**
Keep your preferred source, format, ranges, and behavior in `~/.lipsum/config`. Clipboard support and shell-friendly defaults make it comfortable to use as a daily utility.

**Templates for speed-dial content**
Create and reuse your own structured placeholder formats for things like commits, citations, blog posts, and more. Seed templates from repo examples or start from a blank scaffold. And more. View full documentation below.

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

- `/usr/local/bin/lipsum`
- `/usr/local/bin/lipsumize`
- `~/.lipsum/config`
- `~/.lipsum/words`
- `~/.lipsum/sources/`
- `~/.lipsum/templates/`

By default the installer targets `/usr/local/bin/lipsum` and `/usr/local/bin/lipsumize`. If that path needs elevated permissions, it uses `sudo` for the executable install step while keeping config and support files in your home directory.

Bundled sources currently include:

- `lorem`
- `hipster`
- `tech`
- `pirate`
- `food`
- `corporate`
- `es`
- `fr`
- `de`

Example corpora and template seeds live in:

- `examples/alice.txt`
- `examples/templates/`

From this project directory, run:

```sh
$ ./install.sh
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
$ ./install.sh --yes
$ ./install.sh --interactive
$ EDITOR=nano ./install.sh --editor-config
```

Once this repo is hosted publicly, the same installer can also be piped from the raw `install.sh` URL for a one-command setup.

## Usage

```text
$ lipsum [ options ] [ count|min-max ] [ command ]
$ lipsum [ options ] [ command ] [ count|min-max ]
$ lipsum [ options ] [ count|min-max ] template name
$ lipsum [ options ] template name [ count|min-max ]
$ lipsum [ other-action ]
```

Modes are subcommands only. They are not available as flags.

`lipsumize` uses this companion syntax:

```text
$ lipsumize [ options ] name input
```

where `input` can be a local text file, local HTML file, local EPUB, `-` for stdin, or an `http://` / `https://` URL.

## Commands

- `c`, `C`, `char`, `chars`, `character`, `characters`
- `w`, `W`, `word`, `words`
- `l`, `L`, `line`, `lines`
- `s`, `S`, `sent`, `sents`, `sentence`, `sentences`
- `p`, `P`, `para`, `paras`, `paragraph`, `paragraphs`
- `template`, `tpl`, `tmpl`

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
  - List built-in and imported named source corpora, show the configured default, and print a sample paragraph for each source.
- `templates`
- `list-templates`
  - List saved templates and print a sample render for each one.

Notes:

- `lipsum config` creates the config file first if it does not exist.
- After the editor exits, `lipsum config` validates the file immediately.
- There is no `reload` command because the utility reads config fresh on every run.

## Options

- `-l`, `-L`, `--lowercase`
  - Force lowercase output.
- `-u`, `-U`, `--uppercase`
  - Force uppercase output.
- `-t`, `-T`, `--title-case`
  - Force title-case output.
- `-s`, `-S`, `--source name`
  - Choose a named source corpus such as `lorem`, `hipster`, `tech`, `pirate`, `food`, `corporate`, `es`, `fr`, or `de`.
- `--text text|-`
  - Use inline text as the source corpus for this invocation.
  - `--text -` reads the source corpus from stdin.
- `--file path`
  - Use a file's contents as the source corpus for this invocation.
- `--save-source name`
  - Save custom text or file input as a reusable named source under `~/.lipsum/sources/`.
- `--from path`
  - Seed `lipsum template new ...` or `lipsum template edit ...` from an example template file.
- `-f`, `-F`, `--format name`
  - Render generated output as `plain`, `html`, `markdown`, `json`, or `ndjson`.
- `-b`, `-B`, `--bullets [char]`
  - Prefix each generated line with a bullet marker.
- `-o`, `-O`, `--ordered-list [fmt]`
  - Prefix each generated line with an ordered marker.
  - Only valid for `lines`.
  - Default format: `%d.`
- `-p`, `-P`, `--punctuation [mode]`
  - Set punctuation handling to `period`, `end`, `all`, or `none`.
  - Bare `-p` defaults to `all`.
  - `period` preserves the old behavior of sentence-ending periods.
  - `end` allows `.`, `!`, and `?` as ending punctuation.
  - `all` also sprinkles punctuation such as commas, parentheses, hyphens, and em dashes among words.
- `-e`, `-E`, `--emoji`
  - Mix emoji into generated output.
  - Emoji are sparse and biased toward the ends of the generated text.
  - For `words`, emoji count toward the requested word total.
  - For `characters`, output length becomes approximate when emoji are enabled.
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
- `--no-emoji`
  - Disable emoji even if enabled in config.
- `-h`, `-H`, `--help`
- `-v`, `-V`, `--version`

## Count Semantics

Top-level counts control how many units get generated.

Examples:

```sh
$ lipsum 12
$ lipsum 2 words
$ lipsum words 2
$ lipsum 3-5 words
$ lipsum 4-6 lines
$ lipsum lines 4-6
```

`3-5 words` means the command randomly chooses a count between 3 and 5, then generates that many words.

## Compact Short Forms

Single-letter subcommands can be combined directly with counts.

Examples:

```sh
$ lipsum 10c
$ lipsum s2
$ lipsum 2-3l
$ lipsum P1-3
```

These are equivalent to:

```sh
$ lipsum 10 characters
$ lipsum 2 sentences
$ lipsum 2-3 lines
$ lipsum 1-3 paragraphs
```

## Range Semantics

`--range` means different things depending on the command.

## Sources

You can list installed sources with:

```sh
$ lipsum sources
```

That screen separates built-in sources from imported custom sources, labels the current default, and shows a sample paragraph for each source.

You can select a source for a single invocation with:

```sh
$ lipsum --source hipster 8 words
$ lipsum --source tech 2 paragraphs
$ lipsum --source corporate 5 lines
$ lipsum -s es 2 paragraphs
$ lipsum 140 characters -e -p none
$ lipsum 18 words -e -s tech
$ lipsum 12 words -p all
```

You can also set a default source in `~/.lipsum/config`:

```sh
default_source='hipster'
```

Source lookup works like this:

- for `lorem`, the CLI first uses `LIPSUM_DICT` when set, then `~/.lipsum/sources/lorem.words`, then the legacy `~/.lipsum/words`
- for other source names, the CLI loads `~/.lipsum/sources/<name>.words`

You can also generate from one-off input without installing a source first:

```sh
$ lipsum --text 'alpha beta gamma delta epsilon' 3 words
$ lipsum --file ./notes.txt 2 paragraphs
$ printf 'violet cedar ember meadow signal' | lipsum --text - 4 words
```

To save custom input for reuse:

```sh
$ printf 'atlas ember harbor signal twilight' | lipsum --text - --save-source customdemo 4 words
$ lipsum --source customdemo 6 words
```

Or create a reusable source corpus with `lipsumize`:

```sh
$ lipsumize bookish ~/Documents/book.txt
$ lipsumize startup-copy ./landing-page.html
$ lipsumize example-site https://www.example.com
$ curl -fsSL https://example.com | lipsumize example-site -
$ lipsum --source example-site 8 words
```

### Words

For `words`, `--range` filters generated words by character length.

Examples:

```sh
$ lipsum 5 words -r 3-4
$ lipsum words 8 -r 6
```

### Lines

For `lines`, `--range` controls words per line.

Examples:

```sh
$ lipsum 4-6 lines -r 6-10
$ lipsum lines 5 -r 4
```

### Sentences

For `sentences`, `--range` controls words per sentence.

Examples:

```sh
$ lipsum 2-4 sentences -r 5
$ lipsum s3 -r 8-12
```

### Paragraphs

For `paragraphs`, `--range` controls sentences per paragraph.

Examples:

```sh
$ lipsum 2 paragraphs -r 3
$ lipsum P1-3 -r 2-4
```

### Characters

For `characters`, `--range` is ignored.

### Templates

For `template`, the top-level count controls how many rendered template items are produced.

Template management commands:

```sh
$ lipsum template new conventional-commit
$ lipsum template edit conventional-commit
$ lipsum template new blog-post --from examples/templates/blog-post.tpl
```

Examples:

```sh
$ lipsum template new conventional-commit --from examples/templates/conventional-commit.tpl
$ lipsum 3 template conventional-commit -p none
$ lipsum template new blog-post --from examples/templates/blog-post.tpl
$ lipsum template blog-post 2
```

If you also pass `--range` with `template`, it acts like `words` mode and filters the word lengths used inside template placeholders such as `{{words(2-5)}}`.

## Output Formats

The default output format is `plain`. You can override it per invocation:

```sh
$ lipsum 4 lines -f html
$ lipsum 3 paragraphs -f json
$ lipsum 6 words -f ndjson -p none -l
```

Current renderer behavior:

- `plain`
  - The existing CLI output.
- `html`
  - Wraps `lines` in `<ul>` or `<ol>`, wraps paragraphs in `<p>` tags, and wraps single-block output in `<p>`.
- `markdown`
  - Leaves most output unchanged, but turns unprefixed `lines` into markdown bullet lists.
- `json`
  - Emits a JSON string for `characters` and JSON arrays for multi-item output such as words, lines, sentences, paragraphs, and templates.
- `ndjson`
  - Emits one JSON string per generated item.

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
$ lipsum 3 lines -o '%00z)'
```

Example outputs:

- `%d.` -> `1.`, `2.`, `3.`
- `(%A)` -> `(A)`, `(B)`, `(C)`
- `%00z)` -> `000)`, `001)`, `002)`

## Examples

Basic usage:

```sh
$ lipsum
$ lipsum 8
$ lipsum --source fr 8 words
$ lipsum --text 'alpha beta gamma delta epsilon' 3 words
$ lipsum 100 characters
$ lipsum 3 paragraphs
$ lipsum template new conventional-commit --from examples/templates/conventional-commit.tpl
$ lipsum 3 template conventional-commit -p none
```

Website-style bullets:

```sh
$ lipsum 5 lines -b
$ lipsum 5 lines -b '*'
$ lipsum 4-6 lines -r 4-8 -b
```

Ordered lists:

```sh
$ lipsum 4 lines -o
$ lipsum 4 lines -o '(%A)'
$ lipsum 4 lines -o '%00z)'
```

Case formatting:

```sh
$ lipsum 6 words -p none -l
$ lipsum 6 words -p none -u
$ lipsum 6 words -p none -t
```

Punctuation modes:

```sh
$ lipsum 8 words -p period
$ lipsum 8 words -p end
$ lipsum 12 words -p all
$ lipsum 8 words -p none
```

Word-length filtering:

```sh
$ lipsum 5 words -r 3-4
$ lipsum 8 words -r 6
```

Clipboard:

```sh
$ lipsum 5 lines -b -c
$ lipsum 3 sentences --copy
$ lipsum 4 words --no-copy
```

Renderer formats:

```sh
$ lipsum 4 lines -f html
$ lipsum 3 paragraphs -f json
$ lipsum 5 words -f ndjson -p none -l
$ lipsum 3 lines -f markdown -p none
```

Templates:

```sh
$ lipsum templates
$ lipsum template new conventional-commit --from examples/templates/conventional-commit.tpl
$ lipsum 3 template conventional-commit -p none
$ lipsum template new blog-post --from examples/templates/blog-post.tpl
$ lipsum 2 template blog-post -f json
```

Pipelines and shell usage:

```sh
$ lipsum 4 lines -b | nl -ba
$ lipsum 1 paragraph | fold -s -w 40
$ printf '[%s]\n' "$(lipsum 4 words -p none -l)"
$ printf '3\n5\n' | xargs -I{} zsh -c "lipsum 1 lines -r \"\$1\" -b" _ {}
$ for n in 3 4 5; do lipsum 1 line -r "$n" -b; done
```

Config actions:

```sh
$ lipsum init
$ lipsum config
```

## Configuration

Initialize a starter config:

```sh
$ lipsum init
```

Then edit it with:

```sh
$ lipsum config
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
default_format='plain'
punctuation_mode='period'
copy_on_generate=0
emoji_enabled=0
emoji_charset='😀 😅 😂 🤣 🥲 🙂 😍 😛 🤓 😎 🤩 🥳 😕 🙁 😭 😡 🤔 🫡 😬 🙄 😮 💩 💀 🤖 🫶 🙌 👏 👍 👎 🤌 💪 🦾 🙏 👀 🧠 🧌 🤦 💅 👯‍♀️ 🧵 🌹 🌙 ✨ 🔥 💦 🍑 🍆 🍺 🍻 🏆 ✈️ 🚀 💡 💸 💎 🎉 🩷 ❤️ 💜 🖤 💔 ❌ 💯 ✅ 😀 😅 😂 🙂 😍 👏 👍 🙏 🤦 💅 ✨ 🔥 🚀 💡 🎉 ❤️ 💯 ✅ 😀 😅 😂 🙂 😍 👏 👍 🙏 🤦 💅 ✨ 🔥 🚀 💡 🎉 ❤️ 💯 ✅ 😀 😅 😂 🙂 😍 👏 👍 🙏 🤦 💅 ✨ 🔥 🚀 💡 🎉 ❤️ 💯 ✅ 😀 😅 😂 🙂 😍 👏 👍 🙏 🤦 💅 ✨ 🔥 🚀 💡 🎉 ❤️ 💯 ✅ 😀 😅 😂 🙂 😍 👏 👍 🙏 🤦 💅 ✨ 🔥 🚀 💡 🎉 ❤️ 💯 ✅ 😀 😅 😂 🙂 😍 👏 👍 🙏 🤦 💅 ✨ 🔥 🚀 💡 🎉 ❤️ 💯 ✅ 😀 😅 😂 🙂 😍 👏 👍 🙏 🤦 💅 ✨ 🔥 🚀 💡 🎉 ❤️ 💯 ✅'

default_source='lorem'
```

Notes:

- The config file is sourced by zsh, so values should stay shell-friendly.
- `punctuation_mode='period'` is the old default behavior, while `end`, `all`, and `none` broaden or remove punctuation.
- `default_format='plain'` keeps the existing CLI behavior, while `html`, `markdown`, `json`, and `ndjson` change the renderer used when you do not pass `--format`.
- `copy_on_generate=1` makes clipboard copying the default.
- `emoji_enabled=1` makes emoji mixing the default.
- `emoji_charset` is a space-separated weighted pool, so repeating an emoji makes it more likely to appear.
- The bundled default is heavily weighted toward the common subset, so those emoji account for a bit over three-quarters of default picks.
- If you edit the config externally and introduce an error, that error appears the next time you run `lipsum`.
- If you edit via `lipsum config`, the command validates the config immediately after the editor exits.

## Environment Variables

- `LIPSUM_CONFIG`
  - Override the config file path.
- `LIPSUM_DICT`
  - Override the default corpus file path.
- `LIPSUM_SOURCE_DIR`
  - Override the directory used for named source corpora.
- `LIPSUM_TEMPLATE_DIR`
  - Override the directory used for user templates.
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
- Templates are stored as `.tpl` files under `~/.lipsum/templates/`. Repo examples live under `examples/templates/` and can be used with `lipsum template new ... --from ...`.
- Template placeholders currently support `{{words(...)}}`, `{{sentence(...)}}`, `{{number(...)}}`, `{{choice(...)}}`, and `{{emoji(...)}}`.
- Range is ignored for `characters`.
- Emoji are sparse by design and biased toward the ends of words, lines, sentences, and paragraphs.

## Testing

Run the suite from the project root:

```sh
$ ./tests/run_lipsum_tests.zsh
```

Artifacts:

- Test runner: [tests/run_lipsum_tests.zsh](./tests/run_lipsum_tests.zsh)
- Latest report: [tests/lipsum-test-plan-and-results.md](./tests/lipsum-test-plan-and-results.md)

## Current Scope

Implemented:

- subcommand-only generation modes
- exact counts and random count ranges
- compact short forms
- named sources and custom source input
- built-in alternate source styles
- output renderers
- user-defined templates with example seeds
- configurable emoji mixing
- case formatting controls
- word-length filters and per-unit ranges
- bullets and ordered lists
- config-backed defaults
- built-in clipboard copying
- companion `lipsumize` corpus importing
- conventional branch validation in CI
- semantic-release based GitHub release automation

Planned next:

- richer template tokens and structure controls
