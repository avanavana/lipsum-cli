# lipsum Test Plan And Results

Generated: 2026-05-05 11:55:10 EDT

Scripts under test:
- [/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum](/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum)
- [/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/install.sh](/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/install.sh)

## Test Plan

This plan covers the current CLI shape where generation modes are subcommands only, counts can appear before or after the subcommand, compact one-token short forms are supported, config editing/init are separate utility commands, output case can be controlled explicitly, ordered lists are available for line output, and clipboard copying can be enabled directly or via config.

Coverage areas:
- Syntax and basic CLI metadata.
- Subcommand-only mode selection.
- Count parsing in both orderings: `count mode` and `mode count`.
- Compact short forms such as `10c`, `s2`, `2-3l`, and `P1-3`.
- Top-level count ranges such as `3-5 words`.
- Internal range handling for words, lines, sentences, paragraphs, and characters.
- Named source selection and source discovery.
- Case formatting: lowercase, uppercase, and title case.
- Bullets and ordered lists.
- Config commands and config-driven defaults.
- Clipboard behaviors including explicit copy, config-driven copy, and explicit no-copy override.
- Installer flows for defaults, guided setup, and editor-config mode.
- Error handling for invalid combinations, removed mode flags, invalid ranges, incompatible options, and size caps.
- Shell integration patterns users are likely to rely on: loops, `xargs`, command substitution, stdin-driven wrappers, and output pipelines.

### Planned Cases

- TC01 Smoke: Syntax check parses cleanly.
- TC02 Metadata: Short help flag renders the updated usage screen and examples.
- TC03 Metadata: Long version flag returns the version string.
- TC04 Defaults: Bare invocation uses the default words mode.
- TC05 Defaults: A bare numeric argument is treated as a default word count.
- TC06 Words: Count before mode works for exact word counts.
- TC07 Words: Mode before count still works for exact word counts.
- TC08 Words: A top-level count range works for default words mode.
- TC09 Words: A top-level count range works with an explicit word subcommand.
- TC10 Words: Word ranges filter word length in characters.
- TC11 Characters: Count before the characters subcommand works.
- TC12 Characters: Character count ranges resolve to a random exact count.
- TC13 Characters: Internal range is ignored for characters.
- TC14 Lines: Typical website bullet use case uses shorter default line lengths.
- TC15 Lines: Random top-level line counts and internal line lengths both work together.
- TC16 Lines: Mode-first ordering works with an exact internal line length.
- TC17 Sentences: Default sentences mode generates the requested number of sentences.
- TC18 Sentences: Sentence count ranges and exact internal sentence lengths work together.
- TC19 Paragraphs: Default paragraphs mode emits multiple paragraphs with blank-line separation.
- TC20 Paragraphs: Exact paragraph sentence counts can be forced.
- TC21 Compact Forms: Compact count+command suffix form works.
- TC22 Compact Forms: Compact command+count prefix form works.
- TC23 Compact Forms: Compact range+command suffix form works.
- TC24 Compact Forms: Compact command+range prefix form works.
- TC25 Case: Lowercase output works with the new lowercase option.
- TC26 Case: Uppercase output works.
- TC27 Case: Title case output works.
- TC28 Ordered Lists: Default ordered lists use numeric markers.
- TC29 Ordered Lists: Ordered list formulas support alphabetic markers.
- TC30 Ordered Lists: Ordered list formulas support zero-padded zero-indexed digits.
- TC31 Config Actions: Init creates a starter config file at an override path.
- TC32 Config Actions: Config opens an existing config file in the configured editor and validates it.
- TC33 Config Actions: Config creates a missing config file before opening it.
- TC34 Config: Config can change the default mode, default count, default range, and default bullet character.
- TC35 Config: Config can change the default command for bare invocation.
- TC36 Config: Default word-length range applies to words output when no explicit range is provided.
- TC37 Copy: Explicit copy writes the same content to the clipboard target and stdout.
- TC38 Copy: Config can enable copy by default.
- TC39 Copy: Explicit no-copy overrides config-driven clipboard copying.
- TC40 Errors: Unknown long options fail with a usage error.
- TC41 Errors: Removed long mode flags are rejected.
- TC42 Errors: Removed short mode flags are rejected.
- TC43 Errors: Invalid internal range syntax is rejected.
- TC44 Errors: A reversed internal range is rejected.
- TC45 Errors: Zero counts are rejected.
- TC46 Errors: Multiple counts are rejected.
- TC47 Errors: Multiple commands are rejected.
- TC48 Errors: Ordered lists are rejected for non-line modes.
- TC49 Errors: Bullets and ordered lists cannot be combined.
- TC50 Errors: Unknown command names fail cleanly.
- TC51 Errors: Oversized character requests hit the configured safety cap.
- TC52 Errors: Invalid config values fail cleanly on the next run.
- TC53 Shell Integration: A for-loop can generate progressively longer exact bullet lines.
- TC54 Shell Integration: Piped numeric input can drive sentence generation through a while-read loop.
- TC55 Shell Integration: Piped numeric input can drive line generation through xargs.
- TC56 Shell Integration: Command substitution can inline generated text inside another command.
- TC57 Shell Integration: Direct stdin piping into lipsum is harmless and the command still produces stdout.
- TC58 Shell Integration: Paragraph output can be piped into fold for visual wrapping.
- TC59 Shell Integration: Bullet output can be piped into line numbering for visual review.
- TC60 Shell Integration: Word output can be piped into newline transforms for tokenized display.
- TC61 Sources: The sources action lists the available bundled and configured source corpora.
- TC62 Sources: The long source option selects a named source corpus for one invocation.
- TC63 Sources: The short source option selects another named source corpus.
- TC64 Sources: Config can change the default source for bare and explicit generation.
- TC65 Installer: Installer syntax checks cleanly.
- TC66 Installer: Defaults mode installs the executable, config, corpus, bundled sources, and support directories into a temp HOME.
- TC67 Installer: Interactive mode accepts step-by-step input and can change the default mode before installation.
- TC68 Installer: Editor-config mode creates a config file, validates it, and leaves a working installed executable.

## Execution Results

### TC01 Smoke
Syntax check parses cleanly.

```sh
zsh -n '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum'
```

Exit status: 0

```text
```

### TC02 Metadata
Short help flag renders the updated usage screen and examples.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' -h
```

Exit status: 0

```text

Usage: [1mlipsum[0m [ options ] [ [1mcount|min-max[0m ] [ [1mcommand[0m ]
       [1mlipsum[0m [ options ] [ [1mcommand[0m ] [ [1mcount|min-max[0m ]
       [1mlipsum[0m [ [1mother-action[0m ]
       [1mlipsum[0m [ [1m-v/-V/--version[0m ]
       [1mlipsum[0m [ [1m-h/-H/--help[0m ]

Generate a custom amount of placeholder text (lipsum) in the form of words,
characters, lines, sentences, or paragraphs. Modes are subcommands only.

Commands:
  [1mc, C, char, chars, character, characters[0m
  [1mw, W, word, words[0m
  [1ml, L, line, lines[0m
  [1ms, S, sent, sents, sentence, sentences[0m
  [1mp, P, para, paras, paragraph, paragraphs[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List the available named source corpora.

Options:
  [1m-n, -N, --no-full-stop[0m       Disable the full stop appended to output by default.
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-r, -R, --range[0m [1mn|min-max[0m
                               [1mwords[0m: word length filter in characters
                                      (defaults to config range when omitted)
                               [1mlines[0m: words per line
                               [1msentences[0m: words per sentence
                               [1mparagraphs[0m: sentences per paragraph
                               [1mcharacters[0m: ignored
  [1m-c, -C, --copy[0m               Copy generated output to the clipboard and still print it.
  [1m--no-copy[0m                    Disable clipboard copying even if enabled in config.
  [1m-v, -V, --version[0m            Display the current version of this program.
  [1m-h, -H, --help[0m               Display this help text.

Compact Short Forms:
  [1m10c[0m   [1ms2[0m   [1m2-3l[0m   [1mP1-3[0m

Ordered List Marker Symbols:
  [1m%d[0m = digit (1-indexed)
  [1m%z[0m = digit (0-indexed)
  [1m%i[0m = lowercase roman
  [1m%I[0m = uppercase roman
  [1m%a[0m = lowercase alphabetical
  [1m%A[0m = uppercase alphabetical
  Numeric markers may be zero-padded, e.g. [1m%00z)[0m

Examples:
  [1mlipsum[0m 12
  [1mlipsum[0m 2 words
  [1mlipsum[0m words 2
  [1mlipsum[0m 3-5 words
  [1mlipsum[0m 5 words -r 3-4
  [1mlipsum[0m 4-6 lines -r 6-10 -b
  [1mlipsum[0m 4 lines -o
  [1mlipsum[0m 4 lines -o '(%A)'
  [1mlipsum[0m --source hipster 8 words
  [1mlipsum[0m sources
  [1mlipsum[0m 3 sentences -c
  [1mlipsum[0m config
```

### TC03 Metadata
Long version flag returns the version string.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' --version
```

Exit status: 0

```text
1.7.0
```

### TC04 Defaults
Bare invocation uses the default words mode.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum'
```

Exit status: 0

```text
Fermentum sed rhoncus odio neque cursus suscipit mi orci at.
```

### TC05 Defaults
A bare numeric argument is treated as a default word count.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 6
```

Exit status: 0

```text
Et dui morbi ac posuere libero.
```

### TC06 Words
Count before mode works for exact word counts.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 2 words
```

Exit status: 0

```text
Rhoncus convallis.
```

### TC07 Words
Mode before count still works for exact word counts.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' words 2
```

Exit status: 0

```text
Ultrices curabitur.
```

### TC08 Words
A top-level count range works for default words mode.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 3-5 -n -l | awk '{ print NF; if (NF < 3 || NF > 5) exit 1 }'
```

Exit status: 0

```text
3
```

### TC09 Words
A top-level count range works with an explicit word subcommand.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 3-5 w -n -l | awk '{ print NF; if (NF < 3 || NF > 5) exit 1 }'
```

Exit status: 0

```text
4
```

### TC10 Words
Word ranges filter word length in characters.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 5 words -r 3-4 -n -l | awk '{ for (i = 1; i <= NF; i++) { if (length($i) < 3 || length($i) > 4) bad=1 } } END { print NF; if (bad) exit 1 }'
```

Exit status: 0

```text
5
```

### TC11 Characters
Count before the characters subcommand works.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 100 c
```

Exit status: 0

```text
Que non justo lobortis mattis in vel metus sed porta nunc eget commodo lobortis mauris libero effici.
```

### TC12 Characters
Character count ranges resolve to a random exact count.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 24-30 characters -n -l | tr -d '\n' | wc -m | awk '{ print $1; if ($1 < 24 || $1 > 30) exit 1 }'
```

Exit status: 0

```text
27
```

### TC13 Characters
Internal range is ignored for characters.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 20 characters -r 3-4 -n | tr -d '\n' | wc -m | awk '{ print $1; if ($1 != 20) exit 1 }'
```

Exit status: 0

```text
20
```

### TC14 Lines
Typical website bullet use case uses shorter default line lengths.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 5 lines -b
```

Exit status: 0

```text
– Justo mi vestibulum blandit nisl non nulla auctor.
– Vel maximus quis ligula.
– Cursus ante finibus proin eu blandit libero.
– Fermentum lacinia tristique phasellus dui.
– Pulvinar duis porttitor lacus nisl sed.
```

### TC15 Lines
Random top-level line counts and internal line lengths both work together.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 4-6 lines -r 6-10 | awk '{ print NF; if (NF < 6 || NF > 10) bad=1 } END { if (NR < 4 || NR > 6 || bad) exit 1 }'
```

Exit status: 0

```text
8
10
6
9
```

### TC16 Lines
Mode-first ordering works with an exact internal line length.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' lines 4-6 -r 3 | awk '{ print NF; if (NF != 3) bad=1 } END { print NR; if (NR < 4 || NR > 6 || bad) exit 1 }'
```

Exit status: 0

```text
3
3
3
3
3
3
6
```

### TC17 Sentences
Default sentences mode generates the requested number of sentences.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 2 sentences
```

Exit status: 0

```text
Quis faucibus sed vulputate sed nisi. A urna non varius commodo odio sed varius.
```

### TC18 Sentences
Sentence count ranges and exact internal sentence lengths work together.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 2-4 s -r 5 -l | tr '.' '\n' | awk 'NF > 0 { print NF; count++; if (NF != 5) bad=1 } END { if (count < 2 || count > 4 || bad) exit 1 }'
```

Exit status: 0

```text
5
5
5
5
```

### TC19 Paragraphs
Default paragraphs mode emits multiple paragraphs with blank-line separation.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 2 paragraphs
```

Exit status: 0

```text
Ut ex pretium tristique vestibulum ullamcorper suscipit ligula vitae feugiat. Nunc a velit lectus interdum et. Libero neque lobortis nec nisl finibus semper posuere justo sed in pharetra orci eu.

Vel faucibus dui mi at ante nulla maximus sed diam nec. Libero vel risus pellentesque ultrices ipsum eget justo. Maecenas ante arcu ornare eu felis ac elementum. Euismod id volutpat diam efficitur aenean imperdiet tincidunt nulla non efficitur phasellus dignissim cursus. Vivamus ex tortor varius ut elit ut sodales volutpat sapien mauris non semper.
```

### TC20 Paragraphs
Exact paragraph sentence counts can be forced.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 2 paragraphs -r 2 | awk 'BEGIN { RS="" } { count=gsub(/\./, "&"); print count; if (count != 2) bad=1 } END { if (NR != 2 || bad) exit 1 }'
```

Exit status: 0

```text
2
2
```

### TC21 Compact Forms
Compact count+command suffix form works.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 10c -n | tr -d '\n' | wc -m | awk '{ print $1; if ($1 != 10) exit 1 }'
```

Exit status: 0

```text
10
```

### TC22 Compact Forms
Compact command+count prefix form works.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' s2 | tr '.' '\n' | awk 'NF > 0 { count++ } END { print count; if (count != 2) exit 1 }'
```

Exit status: 0

```text
2
```

### TC23 Compact Forms
Compact range+command suffix form works.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 2-3l | awk 'END { print NR; if (NR < 2 || NR > 3) exit 1 }'
```

Exit status: 0

```text
2
```

### TC24 Compact Forms
Compact command+range prefix form works.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' P1-3 | awk 'BEGIN { RS="" } END { print NR; if (NR < 1 || NR > 3) exit 1 }'
```

Exit status: 0

```text
1
```

### TC25 Case
Lowercase output works with the new lowercase option.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 4 words -n -l
```

Exit status: 0

```text
gravida congue nulla sodales
```

### TC26 Case
Uppercase output works.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 4 words -n -u
```

Exit status: 0

```text
UT MORBI ODIO MAGNA
```

### TC27 Case
Title case output works.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 4 words -n -t
```

Exit status: 0

```text
Dictum Placerat Condimentum Malesuada
```

### TC28 Ordered Lists
Default ordered lists use numeric markers.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 3 lines -o
```

Exit status: 0

```text
1. In hac habitasse platea dictumst etiam vitae nibh.
2. Augue et nibh dignissim.
3. Fermentum molestie cras sed commodo quam donec sit.
```

### TC29 Ordered Lists
Ordered list formulas support alphabetic markers.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 4 lines -o '(%A)'
```

Exit status: 0

```text
(A) Tristique suscipit lorem a lacinia.
(B) Faucibus orci luctus et ultrices posuere.
(C) Enim maecenas a tempor felis in in.
(D) Elit eget tempus accumsan.
```

### TC30 Ordered Lists
Ordered list formulas support zero-padded zero-indexed digits.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 3 lines -o '%00z)'
```

Exit status: 0

```text
000) Enim sed ipsum tristique imperdiet.
001) Ut metus curabitur vel ante in neque.
002) Non mi suspendisse tincidunt aliquet augue a.
```

### TC31 Config Actions
Init creates a starter config file at an override path.

```sh
mkdir -p '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts'; rm -f '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts/init-config.zsh'; LIPSUM_CONFIG='/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts/init-config.zsh' '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' init; sed -n '1,20p' '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts/init-config.zsh'
```

Exit status: 0

```text
Created config file at /Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts/init-config.zsh
# lipsum config
# This file is sourced by the lipsum zsh script. Keep values shell-friendly.

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
```

### TC32 Config Actions
Config opens an existing config file in the configured editor and validates it.

```sh
mkdir -p '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts'; printf "default_mode='words'\n" > '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts/edit-config.zsh'; EDITOR='true' LIPSUM_CONFIG='/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts/edit-config.zsh' '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' config
```

Exit status: 0

```text
Config is valid: /Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts/edit-config.zsh
```

### TC33 Config Actions
Config creates a missing config file before opening it.

```sh
mkdir -p '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts'; rm -f '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts/config-create.zsh'; EDITOR='true' LIPSUM_CONFIG='/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts/config-create.zsh' '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' config; test -f '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts/config-create.zsh' && echo created
```

Exit status: 0

```text
Config is valid: /Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts/config-create.zsh
created
```

### TC34 Config
Config can change the default mode, default count, default range, and default bullet character.

```sh
mkdir -p '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts'; printf "default_mode='lines'\ndefault_line_count=3\ndefault_line_range='2-2'\ndefault_bullet_char='*'\n" > '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts/defaults-config.zsh'; LIPSUM_CONFIG='/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts/defaults-config.zsh' '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' -b -n -l | awk '/^\*/ { print NF - 1; if (NF - 1 != 2) bad=1; count++ } END { if (count != 3 || bad) exit 1 }'
```

Exit status: 0

```text
2
2
2
```

### TC35 Config
Config can change the default command for bare invocation.

```sh
mkdir -p '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts'; printf "default_mode='characters'\ndefault_character_count=20\n" > '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts/mode-config.zsh'; LIPSUM_CONFIG='/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts/mode-config.zsh' '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' -n -l | tr -d '\n' | wc -m | awk '{ print $1; if ($1 != 20) exit 1 }'
```

Exit status: 0

```text
20
```

### TC36 Config
Default word-length range applies to words output when no explicit range is provided.

```sh
mkdir -p '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts'; printf "default_word_length_range='3-4'\n" > '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts/word-range-config.zsh'; LIPSUM_CONFIG='/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts/word-range-config.zsh' '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 5 words -n -l | awk '{ for (i = 1; i <= NF; i++) { if (length($i) < 3 || length($i) > 4) bad=1 } } END { print NF; if (bad) exit 1 }'
```

Exit status: 0

```text
5
```

### TC37 Copy
Explicit copy writes the same content to the clipboard target and stdout.

```sh
mkdir -p '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts'; rm -f '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts/clipboard-explicit.txt'; out="$(LIPSUM_CLIPBOARD_COMMAND="sh -c 'cat > \"\$1\"' _ '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts/clipboard-explicit.txt'" '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 4 w -c -n -l)"; clip="$(cat '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts/clipboard-explicit.txt')"; printf 'stdout=%s\nclipboard=%s\n' "$out" "$clip"; [[ "$out" == "$clip" ]]
```

Exit status: 0

```text
stdout=cras mi semper orci
clipboard=cras mi semper orci
```

### TC38 Copy
Config can enable copy by default.

```sh
mkdir -p '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts'; printf "copy_on_generate=1\n" > '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts/copy-config.zsh'; rm -f '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts/clipboard-config.txt'; out="$(LIPSUM_CONFIG='/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts/copy-config.zsh' LIPSUM_CLIPBOARD_COMMAND="sh -c 'cat > \"\$1\"' _ '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts/clipboard-config.txt'" '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 4 w -n -l)"; clip="$(cat '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts/clipboard-config.txt')"; printf 'stdout=%s\nclipboard=%s\n' "$out" "$clip"; [[ "$out" == "$clip" ]]
```

Exit status: 0

```text
stdout=lectus auctor mauris lorem
clipboard=lectus auctor mauris lorem
```

### TC39 Copy
Explicit no-copy overrides config-driven clipboard copying.

```sh
mkdir -p '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts'; printf "copy_on_generate=1\n" > '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts/no-copy-config.zsh'; rm -f '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts/clipboard-no-copy.txt'; out="$(LIPSUM_CONFIG='/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts/no-copy-config.zsh' LIPSUM_CLIPBOARD_COMMAND="sh -c 'cat > \"\$1\"' _ '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts/clipboard-no-copy.txt'" '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 4 w --no-copy -n -l)"; printf 'stdout=%s\nclipboard_exists=%s\n' "$out" "$(test -e '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts/clipboard-no-copy.txt'; echo $?)"; [[ ! -e '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts/clipboard-no-copy.txt' ]]
```

Exit status: 0

```text
stdout=sit maecenas et ac
clipboard_exists=1
```

### TC40 Errors
Unknown long options fail with a usage error.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' --wat
```

Exit status: 1

```text
Error: Illegal option --wat


Usage: [1mlipsum[0m [ options ] [ [1mcount|min-max[0m ] [ [1mcommand[0m ]
       [1mlipsum[0m [ options ] [ [1mcommand[0m ] [ [1mcount|min-max[0m ]
       [1mlipsum[0m [ [1mother-action[0m ]
       [1mlipsum[0m [ [1m-v/-V/--version[0m ]
       [1mlipsum[0m [ [1m-h/-H/--help[0m ]

Generate a custom amount of placeholder text (lipsum) in the form of words,
characters, lines, sentences, or paragraphs. Modes are subcommands only.

Commands:
  [1mc, C, char, chars, character, characters[0m
  [1mw, W, word, words[0m
  [1ml, L, line, lines[0m
  [1ms, S, sent, sents, sentence, sentences[0m
  [1mp, P, para, paras, paragraph, paragraphs[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List the available named source corpora.

Options:
  [1m-n, -N, --no-full-stop[0m       Disable the full stop appended to output by default.
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-r, -R, --range[0m [1mn|min-max[0m
                               [1mwords[0m: word length filter in characters
                                      (defaults to config range when omitted)
                               [1mlines[0m: words per line
                               [1msentences[0m: words per sentence
                               [1mparagraphs[0m: sentences per paragraph
                               [1mcharacters[0m: ignored
  [1m-c, -C, --copy[0m               Copy generated output to the clipboard and still print it.
  [1m--no-copy[0m                    Disable clipboard copying even if enabled in config.
  [1m-v, -V, --version[0m            Display the current version of this program.
  [1m-h, -H, --help[0m               Display this help text.

Compact Short Forms:
  [1m10c[0m   [1ms2[0m   [1m2-3l[0m   [1mP1-3[0m

Ordered List Marker Symbols:
  [1m%d[0m = digit (1-indexed)
  [1m%z[0m = digit (0-indexed)
  [1m%i[0m = lowercase roman
  [1m%I[0m = uppercase roman
  [1m%a[0m = lowercase alphabetical
  [1m%A[0m = uppercase alphabetical
  Numeric markers may be zero-padded, e.g. [1m%00z)[0m

Examples:
  [1mlipsum[0m 12
  [1mlipsum[0m 2 words
  [1mlipsum[0m words 2
  [1mlipsum[0m 3-5 words
  [1mlipsum[0m 5 words -r 3-4
  [1mlipsum[0m 4-6 lines -r 6-10 -b
  [1mlipsum[0m 4 lines -o
  [1mlipsum[0m 4 lines -o '(%A)'
  [1mlipsum[0m --source hipster 8 words
  [1mlipsum[0m sources
  [1mlipsum[0m 3 sentences -c
  [1mlipsum[0m config
```

### TC41 Errors
Removed long mode flags are rejected.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' --words=7
```

Exit status: 1

```text
Error: Illegal option --words=7


Usage: [1mlipsum[0m [ options ] [ [1mcount|min-max[0m ] [ [1mcommand[0m ]
       [1mlipsum[0m [ options ] [ [1mcommand[0m ] [ [1mcount|min-max[0m ]
       [1mlipsum[0m [ [1mother-action[0m ]
       [1mlipsum[0m [ [1m-v/-V/--version[0m ]
       [1mlipsum[0m [ [1m-h/-H/--help[0m ]

Generate a custom amount of placeholder text (lipsum) in the form of words,
characters, lines, sentences, or paragraphs. Modes are subcommands only.

Commands:
  [1mc, C, char, chars, character, characters[0m
  [1mw, W, word, words[0m
  [1ml, L, line, lines[0m
  [1ms, S, sent, sents, sentence, sentences[0m
  [1mp, P, para, paras, paragraph, paragraphs[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List the available named source corpora.

Options:
  [1m-n, -N, --no-full-stop[0m       Disable the full stop appended to output by default.
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-r, -R, --range[0m [1mn|min-max[0m
                               [1mwords[0m: word length filter in characters
                                      (defaults to config range when omitted)
                               [1mlines[0m: words per line
                               [1msentences[0m: words per sentence
                               [1mparagraphs[0m: sentences per paragraph
                               [1mcharacters[0m: ignored
  [1m-c, -C, --copy[0m               Copy generated output to the clipboard and still print it.
  [1m--no-copy[0m                    Disable clipboard copying even if enabled in config.
  [1m-v, -V, --version[0m            Display the current version of this program.
  [1m-h, -H, --help[0m               Display this help text.

Compact Short Forms:
  [1m10c[0m   [1ms2[0m   [1m2-3l[0m   [1mP1-3[0m

Ordered List Marker Symbols:
  [1m%d[0m = digit (1-indexed)
  [1m%z[0m = digit (0-indexed)
  [1m%i[0m = lowercase roman
  [1m%I[0m = uppercase roman
  [1m%a[0m = lowercase alphabetical
  [1m%A[0m = uppercase alphabetical
  Numeric markers may be zero-padded, e.g. [1m%00z)[0m

Examples:
  [1mlipsum[0m 12
  [1mlipsum[0m 2 words
  [1mlipsum[0m words 2
  [1mlipsum[0m 3-5 words
  [1mlipsum[0m 5 words -r 3-4
  [1mlipsum[0m 4-6 lines -r 6-10 -b
  [1mlipsum[0m 4 lines -o
  [1mlipsum[0m 4 lines -o '(%A)'
  [1mlipsum[0m --source hipster 8 words
  [1mlipsum[0m sources
  [1mlipsum[0m 3 sentences -c
  [1mlipsum[0m config
```

### TC42 Errors
Removed short mode flags are rejected.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' -w 7
```

Exit status: 1

```text
Error: Illegal option -w


Usage: [1mlipsum[0m [ options ] [ [1mcount|min-max[0m ] [ [1mcommand[0m ]
       [1mlipsum[0m [ options ] [ [1mcommand[0m ] [ [1mcount|min-max[0m ]
       [1mlipsum[0m [ [1mother-action[0m ]
       [1mlipsum[0m [ [1m-v/-V/--version[0m ]
       [1mlipsum[0m [ [1m-h/-H/--help[0m ]

Generate a custom amount of placeholder text (lipsum) in the form of words,
characters, lines, sentences, or paragraphs. Modes are subcommands only.

Commands:
  [1mc, C, char, chars, character, characters[0m
  [1mw, W, word, words[0m
  [1ml, L, line, lines[0m
  [1ms, S, sent, sents, sentence, sentences[0m
  [1mp, P, para, paras, paragraph, paragraphs[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List the available named source corpora.

Options:
  [1m-n, -N, --no-full-stop[0m       Disable the full stop appended to output by default.
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-r, -R, --range[0m [1mn|min-max[0m
                               [1mwords[0m: word length filter in characters
                                      (defaults to config range when omitted)
                               [1mlines[0m: words per line
                               [1msentences[0m: words per sentence
                               [1mparagraphs[0m: sentences per paragraph
                               [1mcharacters[0m: ignored
  [1m-c, -C, --copy[0m               Copy generated output to the clipboard and still print it.
  [1m--no-copy[0m                    Disable clipboard copying even if enabled in config.
  [1m-v, -V, --version[0m            Display the current version of this program.
  [1m-h, -H, --help[0m               Display this help text.

Compact Short Forms:
  [1m10c[0m   [1ms2[0m   [1m2-3l[0m   [1mP1-3[0m

Ordered List Marker Symbols:
  [1m%d[0m = digit (1-indexed)
  [1m%z[0m = digit (0-indexed)
  [1m%i[0m = lowercase roman
  [1m%I[0m = uppercase roman
  [1m%a[0m = lowercase alphabetical
  [1m%A[0m = uppercase alphabetical
  Numeric markers may be zero-padded, e.g. [1m%00z)[0m

Examples:
  [1mlipsum[0m 12
  [1mlipsum[0m 2 words
  [1mlipsum[0m words 2
  [1mlipsum[0m 3-5 words
  [1mlipsum[0m 5 words -r 3-4
  [1mlipsum[0m 4-6 lines -r 6-10 -b
  [1mlipsum[0m 4 lines -o
  [1mlipsum[0m 4 lines -o '(%A)'
  [1mlipsum[0m --source hipster 8 words
  [1mlipsum[0m sources
  [1mlipsum[0m 3 sentences -c
  [1mlipsum[0m config
```

### TC43 Errors
Invalid internal range syntax is rejected.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 2 lines -r abc
```

Exit status: 1

```text
Error: Invalid length range: abc


Usage: [1mlipsum[0m [ options ] [ [1mcount|min-max[0m ] [ [1mcommand[0m ]
       [1mlipsum[0m [ options ] [ [1mcommand[0m ] [ [1mcount|min-max[0m ]
       [1mlipsum[0m [ [1mother-action[0m ]
       [1mlipsum[0m [ [1m-v/-V/--version[0m ]
       [1mlipsum[0m [ [1m-h/-H/--help[0m ]

Generate a custom amount of placeholder text (lipsum) in the form of words,
characters, lines, sentences, or paragraphs. Modes are subcommands only.

Commands:
  [1mc, C, char, chars, character, characters[0m
  [1mw, W, word, words[0m
  [1ml, L, line, lines[0m
  [1ms, S, sent, sents, sentence, sentences[0m
  [1mp, P, para, paras, paragraph, paragraphs[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List the available named source corpora.

Options:
  [1m-n, -N, --no-full-stop[0m       Disable the full stop appended to output by default.
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-r, -R, --range[0m [1mn|min-max[0m
                               [1mwords[0m: word length filter in characters
                                      (defaults to config range when omitted)
                               [1mlines[0m: words per line
                               [1msentences[0m: words per sentence
                               [1mparagraphs[0m: sentences per paragraph
                               [1mcharacters[0m: ignored
  [1m-c, -C, --copy[0m               Copy generated output to the clipboard and still print it.
  [1m--no-copy[0m                    Disable clipboard copying even if enabled in config.
  [1m-v, -V, --version[0m            Display the current version of this program.
  [1m-h, -H, --help[0m               Display this help text.

Compact Short Forms:
  [1m10c[0m   [1ms2[0m   [1m2-3l[0m   [1mP1-3[0m

Ordered List Marker Symbols:
  [1m%d[0m = digit (1-indexed)
  [1m%z[0m = digit (0-indexed)
  [1m%i[0m = lowercase roman
  [1m%I[0m = uppercase roman
  [1m%a[0m = lowercase alphabetical
  [1m%A[0m = uppercase alphabetical
  Numeric markers may be zero-padded, e.g. [1m%00z)[0m

Examples:
  [1mlipsum[0m 12
  [1mlipsum[0m 2 words
  [1mlipsum[0m words 2
  [1mlipsum[0m 3-5 words
  [1mlipsum[0m 5 words -r 3-4
  [1mlipsum[0m 4-6 lines -r 6-10 -b
  [1mlipsum[0m 4 lines -o
  [1mlipsum[0m 4 lines -o '(%A)'
  [1mlipsum[0m --source hipster 8 words
  [1mlipsum[0m sources
  [1mlipsum[0m 3 sentences -c
  [1mlipsum[0m config
```

### TC44 Errors
A reversed internal range is rejected.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 1 s --range 10-5
```

Exit status: 1

```text
Error: length range minimum cannot be greater than maximum


Usage: [1mlipsum[0m [ options ] [ [1mcount|min-max[0m ] [ [1mcommand[0m ]
       [1mlipsum[0m [ options ] [ [1mcommand[0m ] [ [1mcount|min-max[0m ]
       [1mlipsum[0m [ [1mother-action[0m ]
       [1mlipsum[0m [ [1m-v/-V/--version[0m ]
       [1mlipsum[0m [ [1m-h/-H/--help[0m ]

Generate a custom amount of placeholder text (lipsum) in the form of words,
characters, lines, sentences, or paragraphs. Modes are subcommands only.

Commands:
  [1mc, C, char, chars, character, characters[0m
  [1mw, W, word, words[0m
  [1ml, L, line, lines[0m
  [1ms, S, sent, sents, sentence, sentences[0m
  [1mp, P, para, paras, paragraph, paragraphs[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List the available named source corpora.

Options:
  [1m-n, -N, --no-full-stop[0m       Disable the full stop appended to output by default.
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-r, -R, --range[0m [1mn|min-max[0m
                               [1mwords[0m: word length filter in characters
                                      (defaults to config range when omitted)
                               [1mlines[0m: words per line
                               [1msentences[0m: words per sentence
                               [1mparagraphs[0m: sentences per paragraph
                               [1mcharacters[0m: ignored
  [1m-c, -C, --copy[0m               Copy generated output to the clipboard and still print it.
  [1m--no-copy[0m                    Disable clipboard copying even if enabled in config.
  [1m-v, -V, --version[0m            Display the current version of this program.
  [1m-h, -H, --help[0m               Display this help text.

Compact Short Forms:
  [1m10c[0m   [1ms2[0m   [1m2-3l[0m   [1mP1-3[0m

Ordered List Marker Symbols:
  [1m%d[0m = digit (1-indexed)
  [1m%z[0m = digit (0-indexed)
  [1m%i[0m = lowercase roman
  [1m%I[0m = uppercase roman
  [1m%a[0m = lowercase alphabetical
  [1m%A[0m = uppercase alphabetical
  Numeric markers may be zero-padded, e.g. [1m%00z)[0m

Examples:
  [1mlipsum[0m 12
  [1mlipsum[0m 2 words
  [1mlipsum[0m words 2
  [1mlipsum[0m 3-5 words
  [1mlipsum[0m 5 words -r 3-4
  [1mlipsum[0m 4-6 lines -r 6-10 -b
  [1mlipsum[0m 4 lines -o
  [1mlipsum[0m 4 lines -o '(%A)'
  [1mlipsum[0m --source hipster 8 words
  [1mlipsum[0m sources
  [1mlipsum[0m 3 sentences -c
  [1mlipsum[0m config
```

### TC45 Errors
Zero counts are rejected.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 0 words
```

Exit status: 1

```text
Error: count values must be greater than zero


Usage: [1mlipsum[0m [ options ] [ [1mcount|min-max[0m ] [ [1mcommand[0m ]
       [1mlipsum[0m [ options ] [ [1mcommand[0m ] [ [1mcount|min-max[0m ]
       [1mlipsum[0m [ [1mother-action[0m ]
       [1mlipsum[0m [ [1m-v/-V/--version[0m ]
       [1mlipsum[0m [ [1m-h/-H/--help[0m ]

Generate a custom amount of placeholder text (lipsum) in the form of words,
characters, lines, sentences, or paragraphs. Modes are subcommands only.

Commands:
  [1mc, C, char, chars, character, characters[0m
  [1mw, W, word, words[0m
  [1ml, L, line, lines[0m
  [1ms, S, sent, sents, sentence, sentences[0m
  [1mp, P, para, paras, paragraph, paragraphs[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List the available named source corpora.

Options:
  [1m-n, -N, --no-full-stop[0m       Disable the full stop appended to output by default.
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-r, -R, --range[0m [1mn|min-max[0m
                               [1mwords[0m: word length filter in characters
                                      (defaults to config range when omitted)
                               [1mlines[0m: words per line
                               [1msentences[0m: words per sentence
                               [1mparagraphs[0m: sentences per paragraph
                               [1mcharacters[0m: ignored
  [1m-c, -C, --copy[0m               Copy generated output to the clipboard and still print it.
  [1m--no-copy[0m                    Disable clipboard copying even if enabled in config.
  [1m-v, -V, --version[0m            Display the current version of this program.
  [1m-h, -H, --help[0m               Display this help text.

Compact Short Forms:
  [1m10c[0m   [1ms2[0m   [1m2-3l[0m   [1mP1-3[0m

Ordered List Marker Symbols:
  [1m%d[0m = digit (1-indexed)
  [1m%z[0m = digit (0-indexed)
  [1m%i[0m = lowercase roman
  [1m%I[0m = uppercase roman
  [1m%a[0m = lowercase alphabetical
  [1m%A[0m = uppercase alphabetical
  Numeric markers may be zero-padded, e.g. [1m%00z)[0m

Examples:
  [1mlipsum[0m 12
  [1mlipsum[0m 2 words
  [1mlipsum[0m words 2
  [1mlipsum[0m 3-5 words
  [1mlipsum[0m 5 words -r 3-4
  [1mlipsum[0m 4-6 lines -r 6-10 -b
  [1mlipsum[0m 4 lines -o
  [1mlipsum[0m 4 lines -o '(%A)'
  [1mlipsum[0m --source hipster 8 words
  [1mlipsum[0m sources
  [1mlipsum[0m 3 sentences -c
  [1mlipsum[0m config
```

### TC46 Errors
Multiple counts are rejected.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 2 3 words
```

Exit status: 1

```text
Error: Multiple counts specified


Usage: [1mlipsum[0m [ options ] [ [1mcount|min-max[0m ] [ [1mcommand[0m ]
       [1mlipsum[0m [ options ] [ [1mcommand[0m ] [ [1mcount|min-max[0m ]
       [1mlipsum[0m [ [1mother-action[0m ]
       [1mlipsum[0m [ [1m-v/-V/--version[0m ]
       [1mlipsum[0m [ [1m-h/-H/--help[0m ]

Generate a custom amount of placeholder text (lipsum) in the form of words,
characters, lines, sentences, or paragraphs. Modes are subcommands only.

Commands:
  [1mc, C, char, chars, character, characters[0m
  [1mw, W, word, words[0m
  [1ml, L, line, lines[0m
  [1ms, S, sent, sents, sentence, sentences[0m
  [1mp, P, para, paras, paragraph, paragraphs[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List the available named source corpora.

Options:
  [1m-n, -N, --no-full-stop[0m       Disable the full stop appended to output by default.
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-r, -R, --range[0m [1mn|min-max[0m
                               [1mwords[0m: word length filter in characters
                                      (defaults to config range when omitted)
                               [1mlines[0m: words per line
                               [1msentences[0m: words per sentence
                               [1mparagraphs[0m: sentences per paragraph
                               [1mcharacters[0m: ignored
  [1m-c, -C, --copy[0m               Copy generated output to the clipboard and still print it.
  [1m--no-copy[0m                    Disable clipboard copying even if enabled in config.
  [1m-v, -V, --version[0m            Display the current version of this program.
  [1m-h, -H, --help[0m               Display this help text.

Compact Short Forms:
  [1m10c[0m   [1ms2[0m   [1m2-3l[0m   [1mP1-3[0m

Ordered List Marker Symbols:
  [1m%d[0m = digit (1-indexed)
  [1m%z[0m = digit (0-indexed)
  [1m%i[0m = lowercase roman
  [1m%I[0m = uppercase roman
  [1m%a[0m = lowercase alphabetical
  [1m%A[0m = uppercase alphabetical
  Numeric markers may be zero-padded, e.g. [1m%00z)[0m

Examples:
  [1mlipsum[0m 12
  [1mlipsum[0m 2 words
  [1mlipsum[0m words 2
  [1mlipsum[0m 3-5 words
  [1mlipsum[0m 5 words -r 3-4
  [1mlipsum[0m 4-6 lines -r 6-10 -b
  [1mlipsum[0m 4 lines -o
  [1mlipsum[0m 4 lines -o '(%A)'
  [1mlipsum[0m --source hipster 8 words
  [1mlipsum[0m sources
  [1mlipsum[0m 3 sentences -c
  [1mlipsum[0m config
```

### TC47 Errors
Multiple commands are rejected.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' words lines
```

Exit status: 1

```text
Error: Multiple commands specified


Usage: [1mlipsum[0m [ options ] [ [1mcount|min-max[0m ] [ [1mcommand[0m ]
       [1mlipsum[0m [ options ] [ [1mcommand[0m ] [ [1mcount|min-max[0m ]
       [1mlipsum[0m [ [1mother-action[0m ]
       [1mlipsum[0m [ [1m-v/-V/--version[0m ]
       [1mlipsum[0m [ [1m-h/-H/--help[0m ]

Generate a custom amount of placeholder text (lipsum) in the form of words,
characters, lines, sentences, or paragraphs. Modes are subcommands only.

Commands:
  [1mc, C, char, chars, character, characters[0m
  [1mw, W, word, words[0m
  [1ml, L, line, lines[0m
  [1ms, S, sent, sents, sentence, sentences[0m
  [1mp, P, para, paras, paragraph, paragraphs[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List the available named source corpora.

Options:
  [1m-n, -N, --no-full-stop[0m       Disable the full stop appended to output by default.
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-r, -R, --range[0m [1mn|min-max[0m
                               [1mwords[0m: word length filter in characters
                                      (defaults to config range when omitted)
                               [1mlines[0m: words per line
                               [1msentences[0m: words per sentence
                               [1mparagraphs[0m: sentences per paragraph
                               [1mcharacters[0m: ignored
  [1m-c, -C, --copy[0m               Copy generated output to the clipboard and still print it.
  [1m--no-copy[0m                    Disable clipboard copying even if enabled in config.
  [1m-v, -V, --version[0m            Display the current version of this program.
  [1m-h, -H, --help[0m               Display this help text.

Compact Short Forms:
  [1m10c[0m   [1ms2[0m   [1m2-3l[0m   [1mP1-3[0m

Ordered List Marker Symbols:
  [1m%d[0m = digit (1-indexed)
  [1m%z[0m = digit (0-indexed)
  [1m%i[0m = lowercase roman
  [1m%I[0m = uppercase roman
  [1m%a[0m = lowercase alphabetical
  [1m%A[0m = uppercase alphabetical
  Numeric markers may be zero-padded, e.g. [1m%00z)[0m

Examples:
  [1mlipsum[0m 12
  [1mlipsum[0m 2 words
  [1mlipsum[0m words 2
  [1mlipsum[0m 3-5 words
  [1mlipsum[0m 5 words -r 3-4
  [1mlipsum[0m 4-6 lines -r 6-10 -b
  [1mlipsum[0m 4 lines -o
  [1mlipsum[0m 4 lines -o '(%A)'
  [1mlipsum[0m --source hipster 8 words
  [1mlipsum[0m sources
  [1mlipsum[0m 3 sentences -c
  [1mlipsum[0m config
```

### TC48 Errors
Ordered lists are rejected for non-line modes.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 5 words -o
```

Exit status: 1

```text
Error: --ordered-list is only valid with lines


Usage: [1mlipsum[0m [ options ] [ [1mcount|min-max[0m ] [ [1mcommand[0m ]
       [1mlipsum[0m [ options ] [ [1mcommand[0m ] [ [1mcount|min-max[0m ]
       [1mlipsum[0m [ [1mother-action[0m ]
       [1mlipsum[0m [ [1m-v/-V/--version[0m ]
       [1mlipsum[0m [ [1m-h/-H/--help[0m ]

Generate a custom amount of placeholder text (lipsum) in the form of words,
characters, lines, sentences, or paragraphs. Modes are subcommands only.

Commands:
  [1mc, C, char, chars, character, characters[0m
  [1mw, W, word, words[0m
  [1ml, L, line, lines[0m
  [1ms, S, sent, sents, sentence, sentences[0m
  [1mp, P, para, paras, paragraph, paragraphs[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List the available named source corpora.

Options:
  [1m-n, -N, --no-full-stop[0m       Disable the full stop appended to output by default.
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-r, -R, --range[0m [1mn|min-max[0m
                               [1mwords[0m: word length filter in characters
                                      (defaults to config range when omitted)
                               [1mlines[0m: words per line
                               [1msentences[0m: words per sentence
                               [1mparagraphs[0m: sentences per paragraph
                               [1mcharacters[0m: ignored
  [1m-c, -C, --copy[0m               Copy generated output to the clipboard and still print it.
  [1m--no-copy[0m                    Disable clipboard copying even if enabled in config.
  [1m-v, -V, --version[0m            Display the current version of this program.
  [1m-h, -H, --help[0m               Display this help text.

Compact Short Forms:
  [1m10c[0m   [1ms2[0m   [1m2-3l[0m   [1mP1-3[0m

Ordered List Marker Symbols:
  [1m%d[0m = digit (1-indexed)
  [1m%z[0m = digit (0-indexed)
  [1m%i[0m = lowercase roman
  [1m%I[0m = uppercase roman
  [1m%a[0m = lowercase alphabetical
  [1m%A[0m = uppercase alphabetical
  Numeric markers may be zero-padded, e.g. [1m%00z)[0m

Examples:
  [1mlipsum[0m 12
  [1mlipsum[0m 2 words
  [1mlipsum[0m words 2
  [1mlipsum[0m 3-5 words
  [1mlipsum[0m 5 words -r 3-4
  [1mlipsum[0m 4-6 lines -r 6-10 -b
  [1mlipsum[0m 4 lines -o
  [1mlipsum[0m 4 lines -o '(%A)'
  [1mlipsum[0m --source hipster 8 words
  [1mlipsum[0m sources
  [1mlipsum[0m 3 sentences -c
  [1mlipsum[0m config
```

### TC49 Errors
Bullets and ordered lists cannot be combined.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 3 lines -b -o
```

Exit status: 1

```text
Error: Use either bullets or ordered-list, not both


Usage: [1mlipsum[0m [ options ] [ [1mcount|min-max[0m ] [ [1mcommand[0m ]
       [1mlipsum[0m [ options ] [ [1mcommand[0m ] [ [1mcount|min-max[0m ]
       [1mlipsum[0m [ [1mother-action[0m ]
       [1mlipsum[0m [ [1m-v/-V/--version[0m ]
       [1mlipsum[0m [ [1m-h/-H/--help[0m ]

Generate a custom amount of placeholder text (lipsum) in the form of words,
characters, lines, sentences, or paragraphs. Modes are subcommands only.

Commands:
  [1mc, C, char, chars, character, characters[0m
  [1mw, W, word, words[0m
  [1ml, L, line, lines[0m
  [1ms, S, sent, sents, sentence, sentences[0m
  [1mp, P, para, paras, paragraph, paragraphs[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List the available named source corpora.

Options:
  [1m-n, -N, --no-full-stop[0m       Disable the full stop appended to output by default.
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-r, -R, --range[0m [1mn|min-max[0m
                               [1mwords[0m: word length filter in characters
                                      (defaults to config range when omitted)
                               [1mlines[0m: words per line
                               [1msentences[0m: words per sentence
                               [1mparagraphs[0m: sentences per paragraph
                               [1mcharacters[0m: ignored
  [1m-c, -C, --copy[0m               Copy generated output to the clipboard and still print it.
  [1m--no-copy[0m                    Disable clipboard copying even if enabled in config.
  [1m-v, -V, --version[0m            Display the current version of this program.
  [1m-h, -H, --help[0m               Display this help text.

Compact Short Forms:
  [1m10c[0m   [1ms2[0m   [1m2-3l[0m   [1mP1-3[0m

Ordered List Marker Symbols:
  [1m%d[0m = digit (1-indexed)
  [1m%z[0m = digit (0-indexed)
  [1m%i[0m = lowercase roman
  [1m%I[0m = uppercase roman
  [1m%a[0m = lowercase alphabetical
  [1m%A[0m = uppercase alphabetical
  Numeric markers may be zero-padded, e.g. [1m%00z)[0m

Examples:
  [1mlipsum[0m 12
  [1mlipsum[0m 2 words
  [1mlipsum[0m words 2
  [1mlipsum[0m 3-5 words
  [1mlipsum[0m 5 words -r 3-4
  [1mlipsum[0m 4-6 lines -r 6-10 -b
  [1mlipsum[0m 4 lines -o
  [1mlipsum[0m 4 lines -o '(%A)'
  [1mlipsum[0m --source hipster 8 words
  [1mlipsum[0m sources
  [1mlipsum[0m 3 sentences -c
  [1mlipsum[0m config
```

### TC50 Errors
Unknown command names fail cleanly.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' banana
```

Exit status: 1

```text
Error: Unknown argument: banana


Usage: [1mlipsum[0m [ options ] [ [1mcount|min-max[0m ] [ [1mcommand[0m ]
       [1mlipsum[0m [ options ] [ [1mcommand[0m ] [ [1mcount|min-max[0m ]
       [1mlipsum[0m [ [1mother-action[0m ]
       [1mlipsum[0m [ [1m-v/-V/--version[0m ]
       [1mlipsum[0m [ [1m-h/-H/--help[0m ]

Generate a custom amount of placeholder text (lipsum) in the form of words,
characters, lines, sentences, or paragraphs. Modes are subcommands only.

Commands:
  [1mc, C, char, chars, character, characters[0m
  [1mw, W, word, words[0m
  [1ml, L, line, lines[0m
  [1ms, S, sent, sents, sentence, sentences[0m
  [1mp, P, para, paras, paragraph, paragraphs[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List the available named source corpora.

Options:
  [1m-n, -N, --no-full-stop[0m       Disable the full stop appended to output by default.
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-r, -R, --range[0m [1mn|min-max[0m
                               [1mwords[0m: word length filter in characters
                                      (defaults to config range when omitted)
                               [1mlines[0m: words per line
                               [1msentences[0m: words per sentence
                               [1mparagraphs[0m: sentences per paragraph
                               [1mcharacters[0m: ignored
  [1m-c, -C, --copy[0m               Copy generated output to the clipboard and still print it.
  [1m--no-copy[0m                    Disable clipboard copying even if enabled in config.
  [1m-v, -V, --version[0m            Display the current version of this program.
  [1m-h, -H, --help[0m               Display this help text.

Compact Short Forms:
  [1m10c[0m   [1ms2[0m   [1m2-3l[0m   [1mP1-3[0m

Ordered List Marker Symbols:
  [1m%d[0m = digit (1-indexed)
  [1m%z[0m = digit (0-indexed)
  [1m%i[0m = lowercase roman
  [1m%I[0m = uppercase roman
  [1m%a[0m = lowercase alphabetical
  [1m%A[0m = uppercase alphabetical
  Numeric markers may be zero-padded, e.g. [1m%00z)[0m

Examples:
  [1mlipsum[0m 12
  [1mlipsum[0m 2 words
  [1mlipsum[0m words 2
  [1mlipsum[0m 3-5 words
  [1mlipsum[0m 5 words -r 3-4
  [1mlipsum[0m 4-6 lines -r 6-10 -b
  [1mlipsum[0m 4 lines -o
  [1mlipsum[0m 4 lines -o '(%A)'
  [1mlipsum[0m --source hipster 8 words
  [1mlipsum[0m sources
  [1mlipsum[0m 3 sentences -c
  [1mlipsum[0m config
```

### TC51 Errors
Oversized character requests hit the configured safety cap.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 250000 c
```

Exit status: 1

```text
Error: Character count capped at 200000. Set LIPSUM_MAX_CHARACTERS to raise it.


Usage: [1mlipsum[0m [ options ] [ [1mcount|min-max[0m ] [ [1mcommand[0m ]
       [1mlipsum[0m [ options ] [ [1mcommand[0m ] [ [1mcount|min-max[0m ]
       [1mlipsum[0m [ [1mother-action[0m ]
       [1mlipsum[0m [ [1m-v/-V/--version[0m ]
       [1mlipsum[0m [ [1m-h/-H/--help[0m ]

Generate a custom amount of placeholder text (lipsum) in the form of words,
characters, lines, sentences, or paragraphs. Modes are subcommands only.

Commands:
  [1mc, C, char, chars, character, characters[0m
  [1mw, W, word, words[0m
  [1ml, L, line, lines[0m
  [1ms, S, sent, sents, sentence, sentences[0m
  [1mp, P, para, paras, paragraph, paragraphs[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List the available named source corpora.

Options:
  [1m-n, -N, --no-full-stop[0m       Disable the full stop appended to output by default.
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-r, -R, --range[0m [1mn|min-max[0m
                               [1mwords[0m: word length filter in characters
                                      (defaults to config range when omitted)
                               [1mlines[0m: words per line
                               [1msentences[0m: words per sentence
                               [1mparagraphs[0m: sentences per paragraph
                               [1mcharacters[0m: ignored
  [1m-c, -C, --copy[0m               Copy generated output to the clipboard and still print it.
  [1m--no-copy[0m                    Disable clipboard copying even if enabled in config.
  [1m-v, -V, --version[0m            Display the current version of this program.
  [1m-h, -H, --help[0m               Display this help text.

Compact Short Forms:
  [1m10c[0m   [1ms2[0m   [1m2-3l[0m   [1mP1-3[0m

Ordered List Marker Symbols:
  [1m%d[0m = digit (1-indexed)
  [1m%z[0m = digit (0-indexed)
  [1m%i[0m = lowercase roman
  [1m%I[0m = uppercase roman
  [1m%a[0m = lowercase alphabetical
  [1m%A[0m = uppercase alphabetical
  Numeric markers may be zero-padded, e.g. [1m%00z)[0m

Examples:
  [1mlipsum[0m 12
  [1mlipsum[0m 2 words
  [1mlipsum[0m words 2
  [1mlipsum[0m 3-5 words
  [1mlipsum[0m 5 words -r 3-4
  [1mlipsum[0m 4-6 lines -r 6-10 -b
  [1mlipsum[0m 4 lines -o
  [1mlipsum[0m 4 lines -o '(%A)'
  [1mlipsum[0m --source hipster 8 words
  [1mlipsum[0m sources
  [1mlipsum[0m 3 sentences -c
  [1mlipsum[0m config
```

### TC52 Errors
Invalid config values fail cleanly on the next run.

```sh
mkdir -p '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts'; printf "default_line_range='9-2'\n" > '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts/bad-config.zsh'; LIPSUM_CONFIG='/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts/bad-config.zsh' '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 1 lines
```

Exit status: 1

```text
Error: default_line_range range minimum cannot be greater than maximum


Usage: [1mlipsum[0m [ options ] [ [1mcount|min-max[0m ] [ [1mcommand[0m ]
       [1mlipsum[0m [ options ] [ [1mcommand[0m ] [ [1mcount|min-max[0m ]
       [1mlipsum[0m [ [1mother-action[0m ]
       [1mlipsum[0m [ [1m-v/-V/--version[0m ]
       [1mlipsum[0m [ [1m-h/-H/--help[0m ]

Generate a custom amount of placeholder text (lipsum) in the form of words,
characters, lines, sentences, or paragraphs. Modes are subcommands only.

Commands:
  [1mc, C, char, chars, character, characters[0m
  [1mw, W, word, words[0m
  [1ml, L, line, lines[0m
  [1ms, S, sent, sents, sentence, sentences[0m
  [1mp, P, para, paras, paragraph, paragraphs[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts/bad-config.zsh[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List the available named source corpora.

Options:
  [1m-n, -N, --no-full-stop[0m       Disable the full stop appended to output by default.
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-r, -R, --range[0m [1mn|min-max[0m
                               [1mwords[0m: word length filter in characters
                                      (defaults to config range when omitted)
                               [1mlines[0m: words per line
                               [1msentences[0m: words per sentence
                               [1mparagraphs[0m: sentences per paragraph
                               [1mcharacters[0m: ignored
  [1m-c, -C, --copy[0m               Copy generated output to the clipboard and still print it.
  [1m--no-copy[0m                    Disable clipboard copying even if enabled in config.
  [1m-v, -V, --version[0m            Display the current version of this program.
  [1m-h, -H, --help[0m               Display this help text.

Compact Short Forms:
  [1m10c[0m   [1ms2[0m   [1m2-3l[0m   [1mP1-3[0m

Ordered List Marker Symbols:
  [1m%d[0m = digit (1-indexed)
  [1m%z[0m = digit (0-indexed)
  [1m%i[0m = lowercase roman
  [1m%I[0m = uppercase roman
  [1m%a[0m = lowercase alphabetical
  [1m%A[0m = uppercase alphabetical
  Numeric markers may be zero-padded, e.g. [1m%00z)[0m

Examples:
  [1mlipsum[0m 12
  [1mlipsum[0m 2 words
  [1mlipsum[0m words 2
  [1mlipsum[0m 3-5 words
  [1mlipsum[0m 5 words -r 3-4
  [1mlipsum[0m 4-6 lines -r 6-10 -b
  [1mlipsum[0m 4 lines -o
  [1mlipsum[0m 4 lines -o '(%A)'
  [1mlipsum[0m --source hipster 8 words
  [1mlipsum[0m sources
  [1mlipsum[0m 3 sentences -c
  [1mlipsum[0m config
```

### TC53 Shell Integration
A for-loop can generate progressively longer exact bullet lines.

```sh
for n in 3 4 5; do '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 1 l -r "$n" -b; done
```

Exit status: 0

```text
– Urna proin malesuada.
– Varius dui aliquam a.
– Consectetur nulla purus vitae orci.
```

### TC54 Shell Integration
Piped numeric input can drive sentence generation through a while-read loop.

```sh
printf '4\n6\n' | while read -r n; do '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 1 s -r "$n" -l; done
```

Exit status: 0

```text
diam nec fringilla condimentum.
sit amet mi eget enim porta.
```

### TC55 Shell Integration
Piped numeric input can drive line generation through xargs.

```sh
printf '3\n5\n' | xargs -I{} zsh -c "'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 1 lines -r \"\$1\" -b" _ {}
```

Exit status: 0

```text
– Bibendum ac erat.
– Eu consectetur leo sed accumsan.
```

### TC56 Shell Integration
Command substitution can inline generated text inside another command.

```sh
printf '[%s]\n' "$('/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 4 w -n -l)"
```

Exit status: 0

```text
[eu sagittis sodales malesuada]
```

### TC57 Shell Integration
Direct stdin piping into lipsum is harmless and the command still produces stdout.

```sh
printf 'stdin is ignored here\n' | '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 5 w
```

Exit status: 0

```text
Elit mi dapibus tincidunt elit.
```

### TC58 Shell Integration
Paragraph output can be piped into fold for visual wrapping.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 1 p | fold -s -w 40
```

Exit status: 0

```text
Ipsum primis in faucibus aliquam erat 
volutpat duis. Nec rutrum pellentesque 
et nulla id eros posuere interdum 
phasellus id sodales dui sed. Fermentum 
odio viverra donec fermentum imperdiet. 
Enim eros at nulla aliquam quis aliquam 
dui nec hendrerit nunc. Quis in in 
porttitor est duis vel cursus diam sed.
```

### TC59 Shell Integration
Bullet output can be piped into line numbering for visual review.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 4 l -b | nl -ba
```

Exit status: 0

```text
     1	– Fermentum justo sed aliquam non felis at.
     2	– Fermentum molestie cras sed commodo quam donec.
     3	– Volutpat proin tempus velit.
     4	– Sit amet risus sed viverra.
```

### TC60 Shell Integration
Word output can be piped into newline transforms for tokenized display.

```sh
'/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 8 w -n -l | tr ' ' '\n'
```

Exit status: 0

```text
per
in
ligula
a
auctor
curabitur
blandit
tempus
```

### TC61 Sources
The sources action lists the available bundled and configured source corpora.

```sh
HOME="$(mktemp -d)" LIPSUM_SOURCE_DIR='/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/share/sources' LIPSUM_DICT='/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/share/lorem.words' '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' sources
```

Exit status: 0

```text
Available sources:
* lorem (default)
- de
- es
- fr
- hipster
```

### TC62 Sources
The long source option selects a named source corpus for one invocation.

```sh
HOME="$(mktemp -d)" LIPSUM_SOURCE_DIR='/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/share/sources' LIPSUM_DICT='/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/share/lorem.words' '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' --source hipster 6 words -n -l | tr ' ' '\n' | awk 'NR==FNR { for (i = 1; i <= NF; i++) seen[$i]=1; next } NF { if (!seen[$1]) bad=1 } END { exit bad }' '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/share/sources/hipster.words' -
```

Exit status: 0

```text
```

### TC63 Sources
The short source option selects another named source corpus.

```sh
HOME="$(mktemp -d)" LIPSUM_SOURCE_DIR='/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/share/sources' LIPSUM_DICT='/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/share/lorem.words' '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' -s de 6 words -n -l | tr ' ' '\n' | awk 'NR==FNR { for (i = 1; i <= NF; i++) seen[$i]=1; next } NF { if (!seen[$1]) bad=1 } END { exit bad }' '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/share/sources/de.words' -
```

Exit status: 0

```text
```

### TC64 Sources
Config can change the default source for bare and explicit generation.

```sh
mkdir -p '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts'; printf "default_source='hipster'\n" > '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts/source-config.zsh'; LIPSUM_CONFIG='/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/tests/test-artifacts/source-config.zsh' LIPSUM_SOURCE_DIR='/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/share/sources' LIPSUM_DICT='/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/share/lorem.words' '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/lipsum' 6 words -n -l | tr ' ' '\n' | awk 'NR==FNR { for (i = 1; i <= NF; i++) seen[$i]=1; next } NF { if (!seen[$1]) bad=1 } END { exit bad }' '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/share/sources/hipster.words' -
```

Exit status: 0

```text
```

### TC65 Installer
Installer syntax checks cleanly.

```sh
zsh -n '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/install.sh'
```

Exit status: 0

```text
```

### TC66 Installer
Defaults mode installs the executable, config, corpus, bundled sources, and support directories into a temp HOME.

```sh
tmp_home="$(mktemp -d)"; HOME="$tmp_home" zsh '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/install.sh' --yes >/tmp/lipsum-installer-defaults.out; rc=$?; cat /tmp/lipsum-installer-defaults.out; test -x "$tmp_home/.local/bin/lipsum" && test -f "$tmp_home/.lipsum/config" && test -f "$tmp_home/.lipsum/words" && test -f "$tmp_home/.lipsum/sources/lorem.words" && test -f "$tmp_home/.lipsum/sources/hipster.words" && test -f "$tmp_home/.lipsum/sources/de.words" && test -d "$tmp_home/.lipsum/templates" && HOME="$tmp_home" "$tmp_home/.local/bin/lipsum" 4 words -n -l; verify_rc=$?; rm -rf "$tmp_home" /tmp/lipsum-installer-defaults.out; exit $(( rc || verify_rc ))
```

Exit status: 0

```text

Installed lipsum-cli.
Executable: /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.IDJlOlaHr8/.local/bin/lipsum
Config:     /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.IDJlOlaHr8/.lipsum/config
Corpus:     /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.IDJlOlaHr8/.lipsum/words
Sources:    /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.IDJlOlaHr8/.lipsum/sources
Templates:  /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.IDJlOlaHr8/.lipsum/templates

Add /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.IDJlOlaHr8/.local/bin to your PATH to run lipsum directly.
interdum duis aptent et
```

### TC67 Installer
Interactive mode accepts step-by-step input and can change the default mode before installation.

```sh
tmp_home="$(mktemp -d)"; answers=$(printf 'lines\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n'); out="$(printf '%s' "$answers" | HOME="$tmp_home" zsh '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/install.sh' --interactive 2>&1)"; rc=$?; printf '%s\n' "$out"; HOME="$tmp_home" "$tmp_home/.local/bin/lipsum" -b -n -l | awk '/^./ { count++ } END { print count; if (count != 5) exit 1 }'; verify_rc=$?; rm -rf "$tmp_home"; exit $(( rc || verify_rc ))
```

Exit status: 0

```text

Default mode
This controls what a bare `lipsum` command generates.

Preview:
Luctus nunc congue vivamus mauris curabitur in molestie sapien et.

Default mode [words] (words/characters/lines/sentences/paragraphs): 
Default source
Choose the source corpus used by default. Available: lorem hipster es fr de.

Preview:
ac eros egestas scelerisque justo quis

Default source [lorem]: 
Default word count
Used when your default mode is words and you run `lipsum` with no count.

Preview:
Egestas quam curabitur volutpat et mollis ligula augue et arcu.

Default word count [10]: 
Default character count
Used when your default mode is characters and you run `lipsum` with no count.

Preview:
Lit facilisis at magna sed ullam

Default character count [32]: 
Default line count
Used when your default mode is lines and you run `lipsum` with no count.

Preview:
– Sed convallis a ex aliquam non.
– Justo id leo gravida pretium.
– Suscipit sagittis felis mauris quis magna elementum.
– Scelerisque malesuada proin ante mi.
– Non blandit eros curabitur convallis dapibus quam et.

Default line count [5]: 
Default sentence count
Used when your default mode is sentences and you run `lipsum` with no count.

Preview:
In posuere nulla sit amet finibus euismod suspendisse dignissim dignissim tempor donec. Arcu id neque rhoncus pulvinar a eget odio cras gravida tellus. Lectus purus eget accumsan odio malesuada at ut consectetur malesuada eleifend vivamus. Mollis ullamcorper curabitur iaculis molestie nisi a ullamcorper.

Default sentence count [4]: 
Default paragraph count
Used when your default mode is paragraphs and you run `lipsum` with no count.

Preview:
Id elementum tortor consectetur nunc imperdiet elementum tempus nulla ante nulla. Curabitur vel ante in neque lacinia pharetra quisque urna. Eu turpis ac nibh scelerisque ultrices vitae in ipsum aliquam faucibus pretium augue in. Leo cras non ligula elementum commodo lacus a molestie risus in quis.

Nunc morbi quis ex at lacus rutrum sagittis quis id sem phasellus id ligula. Faucibus vestibulum ante ipsum primis in faucibus orci luctus et. Rutrum lacus cras ac nisl dictum. Quis ultrices enim orci varius natoque penatibus et.

Ut elit ut sodales volutpat sapien mauris non semper. Dignissim mi molestie nam enim arcu venenatis sed finibus vel malesuada vitae dolor mauris. Imperdiet odio ut consectetur nulla purus.

Default paragraph count [3]: 
Default word length range
Controls the character length of generated words when no explicit range is provided.

Preview:
pharetra nisl tempus in tortor vivamus

Default word length range [1-12]: 
Default line range
Controls the number of words in each generated line.

Preview:
– augue sed convallis augue et nibh dignissim
– varius purus congue in
– vel maximus quis ligula quisque mi magna

Default line range [4-8]: 
Default sentence range
Controls the number of words in each generated sentence.

Preview:
porttitor suspendisse luctus nibh vitae lectus pellentesque in pharetra. in nunc vehicula tincidunt sed sit amet mi nulla eget vulputate.

Default sentence range [6-14]: 
Default paragraph range
Controls the number of sentences in each generated paragraph.

Preview:
Fringilla nulla id augue euismod tristique nibh ut rutrum ex aenean sed dictum. Mollis fringilla aenean consectetur leo et. Magna orci malesuada nibh eget elementum purus orci. Et massa mauris orci varius natoque penatibus et magnis dis parturient montes nascetur ridiculus. Pulvinar enim phasellus molestie et orci sit amet tincidunt praesent purus eros fermentum.

Dictum sed etiam in nunc sapien interdum. Enim ultricies condimentum lorem sed aliquet arcu morbi. Etiam vitae dolor tincidunt elit tristique feugiat sit amet vel turpis nam. Lacinia ullamcorper dapibus sed ac turpis non nisl egestas scelerisque vestibulum justo nisi.

Default paragraph range [3-5]: 
Default paragraph sentence word range
Controls the number of words in each sentence inside paragraph output.

Preview:
Vehicula tincidunt etiam massa turpis porttitor quis ullamcorper. Leo consectetur semper donec quis sodales magna sit amet eleifend nulla morbi efficitur vitae. Maecenas dictum rhoncus mauris quis consequat. Vitae nulla ornare tortor in est convallis et aliquam. Etiam eleifend bibendum suscipit fusce mi turpis volutpat nec ultricies volutpat pellentesque.

Default paragraph sentence word range [6-14]: 
Default bullet character
Used by `lipsum lines -b` when no explicit bullet character is provided.

Preview:
– eu malesuada enim nulla facilisi sed at
– primis in faucibus orci luctus
– felis id aliquam urna aenean sapien

Default bullet character [–]: 
Default ordered list format
Used by `lipsum lines -o` when no explicit ordered marker format is provided.

Preview:
1. Ultricies venenatis nisi ligula aliquam.
2. Feugiat ligula id tellus suscipit nec.
3. Montes nascetur ridiculus mus nam eget est.

Default ordered list format [%d.]: 
Copy on generate
When enabled, lipsum copies output to the clipboard and still prints it.

Current default: no

Copy on generate [no] (yes/no): 
Installed lipsum-cli.
Executable: /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.Qh0COG9pim/.local/bin/lipsum
Config:     /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.Qh0COG9pim/.lipsum/config
Corpus:     /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.Qh0COG9pim/.lipsum/words
Sources:    /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.Qh0COG9pim/.lipsum/sources
Templates:  /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.Qh0COG9pim/.lipsum/templates

Add /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.Qh0COG9pim/.local/bin to your PATH to run lipsum directly.
5
```

### TC68 Installer
Editor-config mode creates a config file, validates it, and leaves a working installed executable.

```sh
tmp_home="$(mktemp -d)"; EDITOR='true' HOME="$tmp_home" zsh '/Users/avanavana/Documents/Projects/Code/shell/lipsum-cli/install.sh' --editor-config >/tmp/lipsum-installer-editor.out 2>&1; rc=$?; cat /tmp/lipsum-installer-editor.out; test -f "$tmp_home/.lipsum/config" && HOME="$tmp_home" "$tmp_home/.local/bin/lipsum" 3 words -n -l; verify_rc=$?; rm -rf "$tmp_home" /tmp/lipsum-installer-editor.out; exit $(( rc || verify_rc ))
```

Exit status: 0

```text

Installed lipsum-cli.
Executable: /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.ZXiU12MuRP/.local/bin/lipsum
Config:     /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.ZXiU12MuRP/.lipsum/config
Corpus:     /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.ZXiU12MuRP/.lipsum/words
Sources:    /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.ZXiU12MuRP/.lipsum/sources
Templates:  /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.ZXiU12MuRP/.lipsum/templates

Add /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.ZXiU12MuRP/.local/bin to your PATH to run lipsum directly.
viverra nec purus
```

