# lipsum Test Plan And Results

Generated: 2026-05-05 20:38:03 EDT

Scripts under test:
- [/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum](/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum)
- [/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./install.sh](/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./install.sh)

## Test Plan

This plan covers the current CLI shape where generation modes are subcommands only, counts can appear before or after the subcommand, compact one-token short forms are supported, config editing/init are separate utility commands, output case can be controlled explicitly, ordered lists are available for line output, emoji mixing can be enabled explicitly or via config, and clipboard copying can be enabled directly or via config.

Coverage areas:
- Syntax and basic CLI metadata.
- Subcommand-only mode selection.
- Count parsing in both orderings: `count mode` and `mode count`.
- Compact short forms such as `10c`, `s2`, `2-3l`, and `P1-3`.
- Top-level count ranges such as `3-5 words`.
- Internal range handling for words, lines, sentences, paragraphs, and characters.
- Named source selection and source discovery.
- Ad hoc source input from text, files, stdin, and saved custom sources.
- Case formatting: lowercase, uppercase, and title case.
- Emoji mixing in explicit, config-driven, and override flows.
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
- TC61 Sources: The sources action separates built-in and imported sources and includes sample paragraphs.
- TC62 Sources: The long source option selects a named source corpus for one invocation.
- TC63 Sources: The short source option selects another named source corpus.
- TC64 Sources: Config can change the default source for bare and explicit generation.
- TC65 Installer: Installer syntax checks cleanly.
- TC66 Installer: Defaults mode installs the executable, config, corpus, bundled sources, and support directories into a temp HOME.
- TC67 Installer: Interactive mode accepts step-by-step input and can change the default mode before installation.
- TC68 Installer: Editor-config mode creates a config file, validates it, and leaves a working installed executable.
- TC69 Custom Sources: Inline text can be used as a one-off source corpus.
- TC70 Custom Sources: A file can provide a one-off source corpus.
- TC71 Custom Sources: Stdin can provide a one-off source corpus via --text -.
- TC72 Custom Sources: Custom input can be saved as a reusable named source.
- TC73 Errors: Custom source input and named source selection cannot be combined.
- TC74 Errors: Saving a source without custom input fails cleanly.
- TC75 Emoji: Explicit emoji mode mixes weighted emoji into word output without changing the requested word count.
- TC76 Emoji: Config-driven emoji defaults can be disabled for one invocation with --no-emoji.
- TC77 Emoji: Character mode can append sparse emoji while keeping output visually message-like.

## Execution Results

### TC01 Smoke
Syntax check parses cleanly.

```sh
zsh -n '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum'
```

Exit status: 0

```text
```

### TC02 Metadata
Short help flag renders the updated usage screen and examples.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' -h
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
  [1msources, list-sources[0m       List built-in and saved source corpora with samples.

Options:
  [1m-n, -N, --no-full-stop[0m       Disable the full stop appended to output by default.
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-e, -E, --emoji[0m              Mix emoji into generated output.
  [1m-r, -R, --range[0m [1mn|min-max[0m
                               [1mwords[0m: word length filter in characters
                                      (defaults to config range when omitted)
                               [1mlines[0m: words per line
                               [1msentences[0m: words per sentence
                               [1mparagraphs[0m: sentences per paragraph
                               [1mcharacters[0m: ignored
  [1m-c, -C, --copy[0m               Copy generated output to the clipboard and still print it.
  [1m--no-copy[0m                    Disable clipboard copying even if enabled in config.
  [1m--no-emoji[0m                   Disable emoji even if enabled in config.
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
  [1mlipsum[0m --text 'alpha beta gamma delta' 3 words
  [1mlipsum[0m --file ./notes.txt 2 paragraphs
  [1mcurl -fsSL https://example.com | lipsum[0m --text - --save-source example-site 5 lines
  [1mlipsum[0m 140 characters -e -n
  [1mlipsum[0m 18 words -e -s tech
  [1mlipsum[0m sources
  [1mlipsum[0m 3 sentences -c
  [1mlipsum[0m config
```

### TC03 Metadata
Long version flag returns the version string.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' --version
```

Exit status: 0

```text
1.10.0
```

### TC04 Defaults
Bare invocation uses the default words mode.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum'
```

Exit status: 0

```text
Ultricies morbi sem ante vitae luctus vitae amet suscipit habitasse.
```

### TC05 Defaults
A bare numeric argument is treated as a default word count.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 6
```

Exit status: 0

```text
Nisl quam a et magna et.
```

### TC06 Words
Count before mode works for exact word counts.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 2 words
```

Exit status: 0

```text
Luctus condimentum.
```

### TC07 Words
Mode before count still works for exact word counts.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' words 2
```

Exit status: 0

```text
Ipsum imperdiet.
```

### TC08 Words
A top-level count range works for default words mode.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 3-5 -n -l | awk '{ print NF; if (NF < 3 || NF > 5) exit 1 }'
```

Exit status: 0

```text
5
```

### TC09 Words
A top-level count range works with an explicit word subcommand.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 3-5 w -n -l | awk '{ print NF; if (NF < 3 || NF > 5) exit 1 }'
```

Exit status: 0

```text
5
```

### TC10 Words
Word ranges filter word length in characters.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 5 words -r 3-4 -n -l | awk '{ for (i = 1; i <= NF; i++) { if (length($i) < 3 || length($i) > 4) bad=1 } } END { print NF; if (bad) exit 1 }'
```

Exit status: 0

```text
5
```

### TC11 Characters
Count before the characters subcommand works.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 100 c
```

Exit status: 0

```text
T tristique nunc a velit lectus interdum et malesuada fames ac ante ipsum primis in faucibus vestibu.
```

### TC12 Characters
Character count ranges resolve to a random exact count.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 24-30 characters -n -l | tr -d '\n' | wc -m | awk '{ print $1; if ($1 < 24 || $1 > 30) exit 1 }'
```

Exit status: 0

```text
30
```

### TC13 Characters
Internal range is ignored for characters.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 20 characters -r 3-4 -n | tr -d '\n' | wc -m | awk '{ print $1; if ($1 != 20) exit 1 }'
```

Exit status: 0

```text
20
```

### TC14 Lines
Typical website bullet use case uses shorter default line lengths.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 5 lines -b
```

Exit status: 0

```text
– Nulla a malesuada felis congue at.
– Cursus lobortis maecenas eleifend bibendum lacus eget.
– Vitae commodo interdum sapien neque consectetur.
– Efficitur elit eget tempus accumsan magna.
– Nullam eleifend accumsan felis.
```

### TC15 Lines
Random top-level line counts and internal line lengths both work together.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4-6 lines -r 6-10 | awk '{ print NF; if (NF < 6 || NF > 10) bad=1 } END { if (NR < 4 || NR > 6 || bad) exit 1 }'
```

Exit status: 0

```text
9
7
7
10
10
```

### TC16 Lines
Mode-first ordering works with an exact internal line length.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' lines 4-6 -r 3 | awk '{ print NF; if (NF != 3) bad=1 } END { print NR; if (NR < 4 || NR > 6 || bad) exit 1 }'
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
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 2 sentences
```

Exit status: 0

```text
Viverra sed pulvinar a massa tristique tristique morbi luctus lectus. Lacus ut aliquam lacus dictum et in sit amet.
```

### TC18 Sentences
Sentence count ranges and exact internal sentence lengths work together.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 2-4 s -r 5 -l | tr '.' '\n' | awk 'NF > 0 { print NF; count++; if (NF != 5) bad=1 } END { if (count < 2 || count > 4 || bad) exit 1 }'
```

Exit status: 0

```text
5
5
```

### TC19 Paragraphs
Default paragraphs mode emits multiple paragraphs with blank-line separation.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 2 paragraphs
```

Exit status: 0

```text
Non faucibus est consequat eu mauris eget velit urna morbi viverra. Eu ex tempor ullamcorper fusce eleifend metus ut lacus cursus dapibus nam eleifend. Leo nec egestas purus sapien et nisi interdum et malesuada fames ac. Egestas velit pharetra eu feugiat magna accumsan vestibulum semper dolor ut venenatis. Mauris iaculis suscipit curabitur iaculis vel metus at ullamcorper quisque accumsan nisl vitae porttitor.

Sed dui rutrum consectetur diam a. Vehicula ex vel scelerisque elementum ligula massa tincidunt neque ut sagittis quam. Blandit sed phasellus quis bibendum velit non. Ullamcorper suscipit ligula vitae feugiat etiam fringilla sapien vitae auctor convallis.
```

### TC20 Paragraphs
Exact paragraph sentence counts can be forced.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 2 paragraphs -r 2 | awk 'BEGIN { RS="" } { count=gsub(/\./, "&"); print count; if (count != 2) bad=1 } END { if (NR != 2 || bad) exit 1 }'
```

Exit status: 0

```text
2
2
```

### TC21 Compact Forms
Compact count+command suffix form works.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 10c -n | tr -d '\n' | wc -m | awk '{ print $1; if ($1 != 10) exit 1 }'
```

Exit status: 0

```text
10
```

### TC22 Compact Forms
Compact command+count prefix form works.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' s2 | tr '.' '\n' | awk 'NF > 0 { count++ } END { print count; if (count != 2) exit 1 }'
```

Exit status: 0

```text
2
```

### TC23 Compact Forms
Compact range+command suffix form works.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 2-3l | awk 'END { print NR; if (NR < 2 || NR > 3) exit 1 }'
```

Exit status: 0

```text
3
```

### TC24 Compact Forms
Compact command+range prefix form works.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' P1-3 | awk 'BEGIN { RS="" } END { print NR; if (NR < 1 || NR > 3) exit 1 }'
```

Exit status: 0

```text
3
```

### TC25 Case
Lowercase output works with the new lowercase option.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4 words -n -l
```

Exit status: 0

```text
mauris morbi ligula rutrum
```

### TC26 Case
Uppercase output works.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4 words -n -u
```

Exit status: 0

```text
PHARETRA NULLAM NEC DUI
```

### TC27 Case
Title case output works.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4 words -n -t
```

Exit status: 0

```text
Gravida Ac Integer Sed
```

### TC28 Ordered Lists
Default ordered lists use numeric markers.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 3 lines -o
```

Exit status: 0

```text
1. Malesuada vitae egestas magna tempor.
2. Nunc ac porta praesent vitae auctor.
3. Est viverra lacinia eget ut leo nam.
```

### TC29 Ordered Lists
Ordered list formulas support alphabetic markers.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4 lines -o '(%A)'
```

Exit status: 0

```text
(A) Risus a rutrum sem in a ipsum.
(B) Volutpat fermentum metus at vehicula nunc.
(C) Cursus sed congue quam non mauris.
(D) Metus eu maximus eleifend.
```

### TC30 Ordered Lists
Ordered list formulas support zero-padded zero-indexed digits.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 3 lines -o '%00z)'
```

Exit status: 0

```text
000) Sollicitudin diam quis sapien pretium vel.
001) Commodo donec pretium quam nec consequat.
002) Ac ante ipsum primis.
```

### TC31 Config Actions
Init creates a starter config file at an override path.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; rm -f '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/init-config.zsh'; LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/init-config.zsh' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' init; sed -n '1,20p' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/init-config.zsh'
```

Exit status: 0

```text
Created config file at /Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/init-config.zsh
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
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "default_mode='words'\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/edit-config.zsh'; EDITOR='true' LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/edit-config.zsh' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' config
```

Exit status: 0

```text
Config is valid: /Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/edit-config.zsh
```

### TC33 Config Actions
Config creates a missing config file before opening it.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; rm -f '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/config-create.zsh'; EDITOR='true' LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/config-create.zsh' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' config; test -f '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/config-create.zsh' && echo created
```

Exit status: 0

```text
Config is valid: /Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/config-create.zsh
created
```

### TC34 Config
Config can change the default mode, default count, default range, and default bullet character.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "default_mode='lines'\ndefault_line_count=3\ndefault_line_range='2-2'\ndefault_bullet_char='*'\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/defaults-config.zsh'; LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/defaults-config.zsh' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' -b -n -l | awk '/^\*/ { print NF - 1; if (NF - 1 != 2) bad=1; count++ } END { if (count != 3 || bad) exit 1 }'
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
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "default_mode='characters'\ndefault_character_count=20\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/mode-config.zsh'; LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/mode-config.zsh' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' -n -l | tr -d '\n' | wc -m | awk '{ print $1; if ($1 != 20) exit 1 }'
```

Exit status: 0

```text
20
```

### TC36 Config
Default word-length range applies to words output when no explicit range is provided.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "default_word_length_range='3-4'\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/word-range-config.zsh'; LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/word-range-config.zsh' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 5 words -n -l | awk '{ for (i = 1; i <= NF; i++) { if (length($i) < 3 || length($i) > 4) bad=1 } } END { print NF; if (bad) exit 1 }'
```

Exit status: 0

```text
5
```

### TC37 Copy
Explicit copy writes the same content to the clipboard target and stdout.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; rm -f '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/clipboard-explicit.txt'; out="$(LIPSUM_CLIPBOARD_COMMAND="sh -c 'cat > \"\$1\"' _ '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/clipboard-explicit.txt'" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4 w -c -n -l)"; clip="$(cat '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/clipboard-explicit.txt')"; printf 'stdout=%s\nclipboard=%s\n' "$out" "$clip"; [[ "$out" == "$clip" ]]
```

Exit status: 0

```text
stdout=libero est ante dapibus
clipboard=libero est ante dapibus
```

### TC38 Copy
Config can enable copy by default.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "copy_on_generate=1\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/copy-config.zsh'; rm -f '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/clipboard-config.txt'; out="$(LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/copy-config.zsh' LIPSUM_CLIPBOARD_COMMAND="sh -c 'cat > \"\$1\"' _ '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/clipboard-config.txt'" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4 w -n -l)"; clip="$(cat '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/clipboard-config.txt')"; printf 'stdout=%s\nclipboard=%s\n' "$out" "$clip"; [[ "$out" == "$clip" ]]
```

Exit status: 0

```text
stdout=congue in nunc tincidunt
clipboard=congue in nunc tincidunt
```

### TC39 Copy
Explicit no-copy overrides config-driven clipboard copying.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "copy_on_generate=1\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/no-copy-config.zsh'; rm -f '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/clipboard-no-copy.txt'; out="$(LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/no-copy-config.zsh' LIPSUM_CLIPBOARD_COMMAND="sh -c 'cat > \"\$1\"' _ '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/clipboard-no-copy.txt'" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4 w --no-copy -n -l)"; printf 'stdout=%s\nclipboard_exists=%s\n' "$out" "$(test -e '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/clipboard-no-copy.txt'; echo $?)"; [[ ! -e '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/clipboard-no-copy.txt' ]]
```

Exit status: 0

```text
stdout=suscipit aliquam porta lorem
clipboard_exists=1
```

### TC40 Errors
Unknown long options fail with a usage error.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' --wat
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
  [1msources, list-sources[0m       List built-in and saved source corpora with samples.

Options:
  [1m-n, -N, --no-full-stop[0m       Disable the full stop appended to output by default.
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-e, -E, --emoji[0m              Mix emoji into generated output.
  [1m-r, -R, --range[0m [1mn|min-max[0m
                               [1mwords[0m: word length filter in characters
                                      (defaults to config range when omitted)
                               [1mlines[0m: words per line
                               [1msentences[0m: words per sentence
                               [1mparagraphs[0m: sentences per paragraph
                               [1mcharacters[0m: ignored
  [1m-c, -C, --copy[0m               Copy generated output to the clipboard and still print it.
  [1m--no-copy[0m                    Disable clipboard copying even if enabled in config.
  [1m--no-emoji[0m                   Disable emoji even if enabled in config.
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
  [1mlipsum[0m --text 'alpha beta gamma delta' 3 words
  [1mlipsum[0m --file ./notes.txt 2 paragraphs
  [1mcurl -fsSL https://example.com | lipsum[0m --text - --save-source example-site 5 lines
  [1mlipsum[0m 140 characters -e -n
  [1mlipsum[0m 18 words -e -s tech
  [1mlipsum[0m sources
  [1mlipsum[0m 3 sentences -c
  [1mlipsum[0m config
```

### TC41 Errors
Removed long mode flags are rejected.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' --words=7
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
  [1msources, list-sources[0m       List built-in and saved source corpora with samples.

Options:
  [1m-n, -N, --no-full-stop[0m       Disable the full stop appended to output by default.
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-e, -E, --emoji[0m              Mix emoji into generated output.
  [1m-r, -R, --range[0m [1mn|min-max[0m
                               [1mwords[0m: word length filter in characters
                                      (defaults to config range when omitted)
                               [1mlines[0m: words per line
                               [1msentences[0m: words per sentence
                               [1mparagraphs[0m: sentences per paragraph
                               [1mcharacters[0m: ignored
  [1m-c, -C, --copy[0m               Copy generated output to the clipboard and still print it.
  [1m--no-copy[0m                    Disable clipboard copying even if enabled in config.
  [1m--no-emoji[0m                   Disable emoji even if enabled in config.
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
  [1mlipsum[0m --text 'alpha beta gamma delta' 3 words
  [1mlipsum[0m --file ./notes.txt 2 paragraphs
  [1mcurl -fsSL https://example.com | lipsum[0m --text - --save-source example-site 5 lines
  [1mlipsum[0m 140 characters -e -n
  [1mlipsum[0m 18 words -e -s tech
  [1mlipsum[0m sources
  [1mlipsum[0m 3 sentences -c
  [1mlipsum[0m config
```

### TC42 Errors
Removed short mode flags are rejected.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' -w 7
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
  [1msources, list-sources[0m       List built-in and saved source corpora with samples.

Options:
  [1m-n, -N, --no-full-stop[0m       Disable the full stop appended to output by default.
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-e, -E, --emoji[0m              Mix emoji into generated output.
  [1m-r, -R, --range[0m [1mn|min-max[0m
                               [1mwords[0m: word length filter in characters
                                      (defaults to config range when omitted)
                               [1mlines[0m: words per line
                               [1msentences[0m: words per sentence
                               [1mparagraphs[0m: sentences per paragraph
                               [1mcharacters[0m: ignored
  [1m-c, -C, --copy[0m               Copy generated output to the clipboard and still print it.
  [1m--no-copy[0m                    Disable clipboard copying even if enabled in config.
  [1m--no-emoji[0m                   Disable emoji even if enabled in config.
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
  [1mlipsum[0m --text 'alpha beta gamma delta' 3 words
  [1mlipsum[0m --file ./notes.txt 2 paragraphs
  [1mcurl -fsSL https://example.com | lipsum[0m --text - --save-source example-site 5 lines
  [1mlipsum[0m 140 characters -e -n
  [1mlipsum[0m 18 words -e -s tech
  [1mlipsum[0m sources
  [1mlipsum[0m 3 sentences -c
  [1mlipsum[0m config
```

### TC43 Errors
Invalid internal range syntax is rejected.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 2 lines -r abc
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
  [1msources, list-sources[0m       List built-in and saved source corpora with samples.

Options:
  [1m-n, -N, --no-full-stop[0m       Disable the full stop appended to output by default.
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-e, -E, --emoji[0m              Mix emoji into generated output.
  [1m-r, -R, --range[0m [1mn|min-max[0m
                               [1mwords[0m: word length filter in characters
                                      (defaults to config range when omitted)
                               [1mlines[0m: words per line
                               [1msentences[0m: words per sentence
                               [1mparagraphs[0m: sentences per paragraph
                               [1mcharacters[0m: ignored
  [1m-c, -C, --copy[0m               Copy generated output to the clipboard and still print it.
  [1m--no-copy[0m                    Disable clipboard copying even if enabled in config.
  [1m--no-emoji[0m                   Disable emoji even if enabled in config.
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
  [1mlipsum[0m --text 'alpha beta gamma delta' 3 words
  [1mlipsum[0m --file ./notes.txt 2 paragraphs
  [1mcurl -fsSL https://example.com | lipsum[0m --text - --save-source example-site 5 lines
  [1mlipsum[0m 140 characters -e -n
  [1mlipsum[0m 18 words -e -s tech
  [1mlipsum[0m sources
  [1mlipsum[0m 3 sentences -c
  [1mlipsum[0m config
```

### TC44 Errors
A reversed internal range is rejected.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 1 s --range 10-5
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
  [1msources, list-sources[0m       List built-in and saved source corpora with samples.

Options:
  [1m-n, -N, --no-full-stop[0m       Disable the full stop appended to output by default.
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-e, -E, --emoji[0m              Mix emoji into generated output.
  [1m-r, -R, --range[0m [1mn|min-max[0m
                               [1mwords[0m: word length filter in characters
                                      (defaults to config range when omitted)
                               [1mlines[0m: words per line
                               [1msentences[0m: words per sentence
                               [1mparagraphs[0m: sentences per paragraph
                               [1mcharacters[0m: ignored
  [1m-c, -C, --copy[0m               Copy generated output to the clipboard and still print it.
  [1m--no-copy[0m                    Disable clipboard copying even if enabled in config.
  [1m--no-emoji[0m                   Disable emoji even if enabled in config.
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
  [1mlipsum[0m --text 'alpha beta gamma delta' 3 words
  [1mlipsum[0m --file ./notes.txt 2 paragraphs
  [1mcurl -fsSL https://example.com | lipsum[0m --text - --save-source example-site 5 lines
  [1mlipsum[0m 140 characters -e -n
  [1mlipsum[0m 18 words -e -s tech
  [1mlipsum[0m sources
  [1mlipsum[0m 3 sentences -c
  [1mlipsum[0m config
```

### TC45 Errors
Zero counts are rejected.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 0 words
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
  [1msources, list-sources[0m       List built-in and saved source corpora with samples.

Options:
  [1m-n, -N, --no-full-stop[0m       Disable the full stop appended to output by default.
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-e, -E, --emoji[0m              Mix emoji into generated output.
  [1m-r, -R, --range[0m [1mn|min-max[0m
                               [1mwords[0m: word length filter in characters
                                      (defaults to config range when omitted)
                               [1mlines[0m: words per line
                               [1msentences[0m: words per sentence
                               [1mparagraphs[0m: sentences per paragraph
                               [1mcharacters[0m: ignored
  [1m-c, -C, --copy[0m               Copy generated output to the clipboard and still print it.
  [1m--no-copy[0m                    Disable clipboard copying even if enabled in config.
  [1m--no-emoji[0m                   Disable emoji even if enabled in config.
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
  [1mlipsum[0m --text 'alpha beta gamma delta' 3 words
  [1mlipsum[0m --file ./notes.txt 2 paragraphs
  [1mcurl -fsSL https://example.com | lipsum[0m --text - --save-source example-site 5 lines
  [1mlipsum[0m 140 characters -e -n
  [1mlipsum[0m 18 words -e -s tech
  [1mlipsum[0m sources
  [1mlipsum[0m 3 sentences -c
  [1mlipsum[0m config
```

### TC46 Errors
Multiple counts are rejected.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 2 3 words
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
  [1msources, list-sources[0m       List built-in and saved source corpora with samples.

Options:
  [1m-n, -N, --no-full-stop[0m       Disable the full stop appended to output by default.
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-e, -E, --emoji[0m              Mix emoji into generated output.
  [1m-r, -R, --range[0m [1mn|min-max[0m
                               [1mwords[0m: word length filter in characters
                                      (defaults to config range when omitted)
                               [1mlines[0m: words per line
                               [1msentences[0m: words per sentence
                               [1mparagraphs[0m: sentences per paragraph
                               [1mcharacters[0m: ignored
  [1m-c, -C, --copy[0m               Copy generated output to the clipboard and still print it.
  [1m--no-copy[0m                    Disable clipboard copying even if enabled in config.
  [1m--no-emoji[0m                   Disable emoji even if enabled in config.
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
  [1mlipsum[0m --text 'alpha beta gamma delta' 3 words
  [1mlipsum[0m --file ./notes.txt 2 paragraphs
  [1mcurl -fsSL https://example.com | lipsum[0m --text - --save-source example-site 5 lines
  [1mlipsum[0m 140 characters -e -n
  [1mlipsum[0m 18 words -e -s tech
  [1mlipsum[0m sources
  [1mlipsum[0m 3 sentences -c
  [1mlipsum[0m config
```

### TC47 Errors
Multiple commands are rejected.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' words lines
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
  [1msources, list-sources[0m       List built-in and saved source corpora with samples.

Options:
  [1m-n, -N, --no-full-stop[0m       Disable the full stop appended to output by default.
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-e, -E, --emoji[0m              Mix emoji into generated output.
  [1m-r, -R, --range[0m [1mn|min-max[0m
                               [1mwords[0m: word length filter in characters
                                      (defaults to config range when omitted)
                               [1mlines[0m: words per line
                               [1msentences[0m: words per sentence
                               [1mparagraphs[0m: sentences per paragraph
                               [1mcharacters[0m: ignored
  [1m-c, -C, --copy[0m               Copy generated output to the clipboard and still print it.
  [1m--no-copy[0m                    Disable clipboard copying even if enabled in config.
  [1m--no-emoji[0m                   Disable emoji even if enabled in config.
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
  [1mlipsum[0m --text 'alpha beta gamma delta' 3 words
  [1mlipsum[0m --file ./notes.txt 2 paragraphs
  [1mcurl -fsSL https://example.com | lipsum[0m --text - --save-source example-site 5 lines
  [1mlipsum[0m 140 characters -e -n
  [1mlipsum[0m 18 words -e -s tech
  [1mlipsum[0m sources
  [1mlipsum[0m 3 sentences -c
  [1mlipsum[0m config
```

### TC48 Errors
Ordered lists are rejected for non-line modes.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 5 words -o
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
  [1msources, list-sources[0m       List built-in and saved source corpora with samples.

Options:
  [1m-n, -N, --no-full-stop[0m       Disable the full stop appended to output by default.
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-e, -E, --emoji[0m              Mix emoji into generated output.
  [1m-r, -R, --range[0m [1mn|min-max[0m
                               [1mwords[0m: word length filter in characters
                                      (defaults to config range when omitted)
                               [1mlines[0m: words per line
                               [1msentences[0m: words per sentence
                               [1mparagraphs[0m: sentences per paragraph
                               [1mcharacters[0m: ignored
  [1m-c, -C, --copy[0m               Copy generated output to the clipboard and still print it.
  [1m--no-copy[0m                    Disable clipboard copying even if enabled in config.
  [1m--no-emoji[0m                   Disable emoji even if enabled in config.
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
  [1mlipsum[0m --text 'alpha beta gamma delta' 3 words
  [1mlipsum[0m --file ./notes.txt 2 paragraphs
  [1mcurl -fsSL https://example.com | lipsum[0m --text - --save-source example-site 5 lines
  [1mlipsum[0m 140 characters -e -n
  [1mlipsum[0m 18 words -e -s tech
  [1mlipsum[0m sources
  [1mlipsum[0m 3 sentences -c
  [1mlipsum[0m config
```

### TC49 Errors
Bullets and ordered lists cannot be combined.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 3 lines -b -o
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
  [1msources, list-sources[0m       List built-in and saved source corpora with samples.

Options:
  [1m-n, -N, --no-full-stop[0m       Disable the full stop appended to output by default.
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-e, -E, --emoji[0m              Mix emoji into generated output.
  [1m-r, -R, --range[0m [1mn|min-max[0m
                               [1mwords[0m: word length filter in characters
                                      (defaults to config range when omitted)
                               [1mlines[0m: words per line
                               [1msentences[0m: words per sentence
                               [1mparagraphs[0m: sentences per paragraph
                               [1mcharacters[0m: ignored
  [1m-c, -C, --copy[0m               Copy generated output to the clipboard and still print it.
  [1m--no-copy[0m                    Disable clipboard copying even if enabled in config.
  [1m--no-emoji[0m                   Disable emoji even if enabled in config.
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
  [1mlipsum[0m --text 'alpha beta gamma delta' 3 words
  [1mlipsum[0m --file ./notes.txt 2 paragraphs
  [1mcurl -fsSL https://example.com | lipsum[0m --text - --save-source example-site 5 lines
  [1mlipsum[0m 140 characters -e -n
  [1mlipsum[0m 18 words -e -s tech
  [1mlipsum[0m sources
  [1mlipsum[0m 3 sentences -c
  [1mlipsum[0m config
```

### TC50 Errors
Unknown command names fail cleanly.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' banana
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
  [1msources, list-sources[0m       List built-in and saved source corpora with samples.

Options:
  [1m-n, -N, --no-full-stop[0m       Disable the full stop appended to output by default.
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-e, -E, --emoji[0m              Mix emoji into generated output.
  [1m-r, -R, --range[0m [1mn|min-max[0m
                               [1mwords[0m: word length filter in characters
                                      (defaults to config range when omitted)
                               [1mlines[0m: words per line
                               [1msentences[0m: words per sentence
                               [1mparagraphs[0m: sentences per paragraph
                               [1mcharacters[0m: ignored
  [1m-c, -C, --copy[0m               Copy generated output to the clipboard and still print it.
  [1m--no-copy[0m                    Disable clipboard copying even if enabled in config.
  [1m--no-emoji[0m                   Disable emoji even if enabled in config.
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
  [1mlipsum[0m --text 'alpha beta gamma delta' 3 words
  [1mlipsum[0m --file ./notes.txt 2 paragraphs
  [1mcurl -fsSL https://example.com | lipsum[0m --text - --save-source example-site 5 lines
  [1mlipsum[0m 140 characters -e -n
  [1mlipsum[0m 18 words -e -s tech
  [1mlipsum[0m sources
  [1mlipsum[0m 3 sentences -c
  [1mlipsum[0m config
```

### TC51 Errors
Oversized character requests hit the configured safety cap.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 250000 c
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
  [1msources, list-sources[0m       List built-in and saved source corpora with samples.

Options:
  [1m-n, -N, --no-full-stop[0m       Disable the full stop appended to output by default.
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-e, -E, --emoji[0m              Mix emoji into generated output.
  [1m-r, -R, --range[0m [1mn|min-max[0m
                               [1mwords[0m: word length filter in characters
                                      (defaults to config range when omitted)
                               [1mlines[0m: words per line
                               [1msentences[0m: words per sentence
                               [1mparagraphs[0m: sentences per paragraph
                               [1mcharacters[0m: ignored
  [1m-c, -C, --copy[0m               Copy generated output to the clipboard and still print it.
  [1m--no-copy[0m                    Disable clipboard copying even if enabled in config.
  [1m--no-emoji[0m                   Disable emoji even if enabled in config.
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
  [1mlipsum[0m --text 'alpha beta gamma delta' 3 words
  [1mlipsum[0m --file ./notes.txt 2 paragraphs
  [1mcurl -fsSL https://example.com | lipsum[0m --text - --save-source example-site 5 lines
  [1mlipsum[0m 140 characters -e -n
  [1mlipsum[0m 18 words -e -s tech
  [1mlipsum[0m sources
  [1mlipsum[0m 3 sentences -c
  [1mlipsum[0m config
```

### TC52 Errors
Invalid config values fail cleanly on the next run.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "default_line_range='9-2'\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/bad-config.zsh'; LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/bad-config.zsh' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 1 lines
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
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/bad-config.zsh[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List built-in and saved source corpora with samples.

Options:
  [1m-n, -N, --no-full-stop[0m       Disable the full stop appended to output by default.
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-e, -E, --emoji[0m              Mix emoji into generated output.
  [1m-r, -R, --range[0m [1mn|min-max[0m
                               [1mwords[0m: word length filter in characters
                                      (defaults to config range when omitted)
                               [1mlines[0m: words per line
                               [1msentences[0m: words per sentence
                               [1mparagraphs[0m: sentences per paragraph
                               [1mcharacters[0m: ignored
  [1m-c, -C, --copy[0m               Copy generated output to the clipboard and still print it.
  [1m--no-copy[0m                    Disable clipboard copying even if enabled in config.
  [1m--no-emoji[0m                   Disable emoji even if enabled in config.
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
  [1mlipsum[0m --text 'alpha beta gamma delta' 3 words
  [1mlipsum[0m --file ./notes.txt 2 paragraphs
  [1mcurl -fsSL https://example.com | lipsum[0m --text - --save-source example-site 5 lines
  [1mlipsum[0m 140 characters -e -n
  [1mlipsum[0m 18 words -e -s tech
  [1mlipsum[0m sources
  [1mlipsum[0m 3 sentences -c
  [1mlipsum[0m config
```

### TC53 Shell Integration
A for-loop can generate progressively longer exact bullet lines.

```sh
for n in 3 4 5; do '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 1 l -r "$n" -b; done
```

Exit status: 0

```text
– Imperdiet in mi.
– Sem quisque sagittis at.
– Ac ante ipsum primis in.
```

### TC54 Shell Integration
Piped numeric input can drive sentence generation through a while-read loop.

```sh
printf '4\n6\n' | while read -r n; do '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 1 s -r "$n" -l; done
```

Exit status: 0

```text
commodo arcu in luctus.
volutpat maecenas eu nulla at risus.
```

### TC55 Shell Integration
Piped numeric input can drive line generation through xargs.

```sh
printf '3\n5\n' | xargs -I{} zsh -c "'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 1 lines -r \"\$1\" -b" _ {}
```

Exit status: 0

```text
– In est convallis.
– Eget vitae urna integer vel.
```

### TC56 Shell Integration
Command substitution can inline generated text inside another command.

```sh
printf '[%s]\n' "$('/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4 w -n -l)"
```

Exit status: 0

```text
[amet pretium amet aliquet]
```

### TC57 Shell Integration
Direct stdin piping into lipsum is harmless and the command still produces stdout.

```sh
printf 'stdin is ignored here\n' | '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 5 w
```

Exit status: 0

```text
Tincidunt commodo arcu commodo justo.
```

### TC58 Shell Integration
Paragraph output can be piped into fold for visual wrapping.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 1 p | fold -s -w 40
```

Exit status: 0

```text
Ut finibus enim sed vestibulum euismod 
turpis et efficitur curabitur sed 
ipsum. Sed nunc morbi quis ex at. Eu 
nulla ut nunc malesuada fringilla. 
Lectus ut varius libero placerat non 
suspendisse mollis id purus vel auctor 
vivamus. Ac turpis egestas sed velit 
urna gravida sit amet risus eget 
malesuada.
```

### TC59 Shell Integration
Bullet output can be piped into line numbering for visual review.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4 l -b | nl -ba
```

Exit status: 0

```text
     1	– A viverra urna morbi ligula ante.
     2	– Nec volutpat mi molestie donec eleifend ornare.
     3	– Etiam consequat bibendum dolor quisque.
     4	– Amet ornare sit amet porttitor et.
```

### TC60 Shell Integration
Word output can be piped into newline transforms for tokenized display.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 8 w -n -l | tr ' ' '\n'
```

Exit status: 0

```text
ac
dictum
pellentesque
dictumst
sit
dictum
pulvinar
proin
```

### TC61 Sources
The sources action separates built-in and imported sources and includes sample paragraphs.

```sh
tmp_home="$(mktemp -d)"; mkdir -p "$tmp_home/.lipsum/sources"; cp '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./share/sources/'*.words "$tmp_home/.lipsum/sources/"; printf 'atlas ember harbor signal twilight\n' > "$tmp_home/.lipsum/sources/custom-demo.words"; out="$(HOME="$tmp_home" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' sources)"; printf '%s\n' "$out"; printf '%s\n' "$out" | grep -F 'Built-In Sources:' >/dev/null && printf '%s\n' "$out" | grep -F 'Imported Sources:' >/dev/null && printf '%s\n' "$out" | grep -F 'Lorem Ipsum (lorem) [default]' >/dev/null && printf '%s\n' "$out" | grep -F 'Tech Ipsum (tech)' >/dev/null && printf '%s\n' "$out" | grep -F 'Corporate Ipsum (corporate)' >/dev/null && printf '%s\n' "$out" | grep -F 'Custom Demo (custom-demo)' >/dev/null; rc=$?; rm -rf "$tmp_home"; exit $rc
```

Exit status: 0

```text
Available Sources

Built-In Sources:
- Lorem Ipsum (lorem) [default]
  Vitae gravida tellus pellentesque quis fusce in lacus risus. Odio quis dui vulputate pulvinar vel id ex donec.

- Hipster Ipsum (hipster)
  Readymade succulents brunch kinfolk cardigan pickled microbatch cloud. Health goth crucifix dreamcatcher truffaut occupy banjo.

- Tech Ipsum (tech)
  Issue milestone spec onboarding docs preview staging production canary. Platform release pipeline service gateway interface latency uptime roadmap sprint backlog.

- Pirate Ipsum (pirate)
  Map harbor bell stern bow helm skipper. Black flag storm cloud port call harbor fire tavern song captain's.

- Food Ipsum (food)
  Citrus peel honey maple sea salt cracked pepper. Menu supper brunch picnic platter skillet saucepan ladle spice rack pantry.

- Corporate Ipsum (corporate)
  Office hours feedback loop pilot cohort readiness checklist launch note. Enablement benchmark baseline scenario planning service model portfolio resourcing capacity.

- Spanish Ipsum (es)
  Fuente sendero colina puerto costa valle espejo ropa. Campo jardin casa ventana puerta abrazo mirada sueno tiempo ritmo.

- French Ipsum (fr)
  Pluie hiver printemps ete automne voyage carte village colline. Lumiere chemin nuage pierre riviere maison parfum.

- German Ipsum (de)
  Gitarre runde wiese muhle horizont kuche terrasse allee notiz heiterkeit. Orange zimt zitrone mehl hof balkon lampe geschichte zuflucht stoff gitarre.

Imported Sources:
- Custom Demo (custom-demo)
  Atlas ember harbor signal twilight atlas ember. Atlas ember harbor signal twilight harbor signal twilight.

Default source: lorem
```

### TC62 Sources
The long source option selects a named source corpus for one invocation.

```sh
HOME="$(mktemp -d)" LIPSUM_SOURCE_DIR='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./share/sources' LIPSUM_DICT='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./share/lorem.words' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' --source hipster 6 words -n -l | tr ' ' '\n' | awk 'NR==FNR { for (i = 1; i <= NF; i++) seen[$i]=1; next } NF { if (!seen[$1]) bad=1 } END { exit bad }' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./share/sources/hipster.words' -
```

Exit status: 0

```text
```

### TC63 Sources
The short source option selects another named source corpus.

```sh
HOME="$(mktemp -d)" LIPSUM_SOURCE_DIR='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./share/sources' LIPSUM_DICT='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./share/lorem.words' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' -s tech 6 words -n -l | tr ' ' '\n' | awk 'NR==FNR { for (i = 1; i <= NF; i++) seen[$i]=1; next } NF { if (!seen[$1]) bad=1 } END { exit bad }' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./share/sources/tech.words' -
```

Exit status: 0

```text
```

### TC64 Sources
Config can change the default source for bare and explicit generation.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "default_source='corporate'\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/source-config.zsh'; LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/source-config.zsh' LIPSUM_SOURCE_DIR='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./share/sources' LIPSUM_DICT='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./share/lorem.words' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 6 words -n -l | tr ' ' '\n' | awk 'NR==FNR { for (i = 1; i <= NF; i++) seen[$i]=1; next } NF { if (!seen[$1]) bad=1 } END { exit bad }' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./share/sources/corporate.words' -
```

Exit status: 0

```text
```

### TC65 Installer
Installer syntax checks cleanly.

```sh
zsh -n '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./install.sh'
```

Exit status: 0

```text
```

### TC66 Installer
Defaults mode installs the executable, config, corpus, bundled sources, and support directories into a temp HOME.

```sh
tmp_home="$(mktemp -d)"; HOME="$tmp_home" zsh '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./install.sh' --yes >/tmp/lipsum-installer-defaults.out; rc=$?; cat /tmp/lipsum-installer-defaults.out; test -x "$tmp_home/.local/bin/lipsum" && test -f "$tmp_home/.lipsum/config" && grep -F 'emoji_charset=' "$tmp_home/.lipsum/config" >/dev/null && test -f "$tmp_home/.lipsum/words" && test -f "$tmp_home/.lipsum/sources/lorem.words" && test -f "$tmp_home/.lipsum/sources/hipster.words" && test -f "$tmp_home/.lipsum/sources/tech.words" && test -f "$tmp_home/.lipsum/sources/pirate.words" && test -f "$tmp_home/.lipsum/sources/food.words" && test -f "$tmp_home/.lipsum/sources/corporate.words" && test -f "$tmp_home/.lipsum/sources/de.words" && test -d "$tmp_home/.lipsum/templates" && HOME="$tmp_home" "$tmp_home/.local/bin/lipsum" 4 words -n -l; verify_rc=$?; rm -rf "$tmp_home" /tmp/lipsum-installer-defaults.out; exit $(( rc || verify_rc ))
```

Exit status: 0

```text

Installed lipsum-cli.
Executable: /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.TkBHVRkWuj/.local/bin/lipsum
Config:     /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.TkBHVRkWuj/.lipsum/config
Corpus:     /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.TkBHVRkWuj/.lipsum/words
Sources:    /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.TkBHVRkWuj/.lipsum/sources
Templates:  /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.TkBHVRkWuj/.lipsum/templates

Add /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.TkBHVRkWuj/.local/bin to your PATH to run lipsum directly.
ut condimentum nunc donec
```

### TC67 Installer
Interactive mode accepts step-by-step input and can change the default mode before installation.

```sh
tmp_home="$(mktemp -d)"; answers=$(printf 'lines\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n'); out="$(printf '%s' "$answers" | HOME="$tmp_home" zsh '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./install.sh' --interactive 2>&1)"; rc=$?; printf '%s\n' "$out"; HOME="$tmp_home" "$tmp_home/.local/bin/lipsum" -b -n -l | awk '/^./ { count++ } END { print count; if (count != 5) exit 1 }'; verify_rc=$?; rm -rf "$tmp_home"; exit $(( rc || verify_rc ))
```

Exit status: 0

```text

Default mode
This controls what a bare `lipsum` command generates.

Preview:
Aliquam ultricies feugiat sed risus imperdiet sed malesuada rutrum tincidunt.

Default mode [words] (words/characters/lines/sentences/paragraphs): 
Default source
Choose the source corpus used by default. Available: lorem hipster tech pirate food corporate es fr de.

Preview:
vitae ligula platea nibh malesuada ultrices

Default source [lorem]: 
Default word count
Used when your default mode is words and you run `lipsum` with no count.

Preview:
Id fusce etiam bibendum in blandit suspendisse felis nascetur quis.

Default word count [10]: 
Default character count
Used when your default mode is characters and you run `lipsum` with no count.

Preview:
Naeos sed dapibus vel arcu conse

Default character count [32]: 
Default line count
Used when your default mode is lines and you run `lipsum` with no count.

Preview:
– Turpis semper et suspendisse.
– Efficitur donec sed dui a.
– Suscipit sed lobortis at aliquet eu purus vestibulum.
– Taciti sociosqu ad litora torquent per conubia nostra.
– Hendrerit pellentesque et justo eleifend tincidunt dui et.

Default line count [5]: 
Default sentence count
Used when your default mode is sentences and you run `lipsum` with no count.

Preview:
Pharetra vivamus vestibulum tempus tempus aliquam feugiat. Pretium tincidunt integer tincidunt purus ut nibh placerat vehicula et ac sem duis. Velit ac semper dictum enim donec laoreet. Morbi faucibus ultricies scelerisque etiam vitae.

Default sentence count [4]: 
Default paragraph count
Used when your default mode is paragraphs and you run `lipsum` with no count.

Preview:
A rutrum sem vivamus eget risus at elit iaculis tristique. Eu fringilla libero etiam feugiat luctus mi et mollis sapien dapibus nec nunc. Vitae mollis pellentesque bibendum sagittis sollicitudin nullam hendrerit purus ut malesuada porttitor duis.

Et pellentesque bibendum mauris phasellus consequat leo tristique ante placerat cursus pellentesque et. Eros commodo est non feugiat turpis massa ut metus curabitur vel. Sollicitudin nullam hendrerit purus ut malesuada porttitor. Curabitur congue magna ac aliquam blandit sed nec elit consectetur porttitor diam.

Malesuada proin ante mi euismod eget dui vitae auctor rutrum nisl pellentesque leo metus. Curae aliquam vestibulum id tortor at placerat in gravida imperdiet odio. Aliquet blandit augue sed convallis augue et nibh dignissim ullamcorper suspendisse. Euismod tristique nibh ut rutrum ex aenean sed dictum lorem.

Default paragraph count [3]: 
Default word length range
Controls the character length of generated words when no explicit range is provided.

Preview:
pellentesque mollis sodales enim sit velit

Default word length range [1-12]: 
Default line range
Controls the number of words in each generated line.

Preview:
– pellentesque sed libero vel pharetra
– vulputate etiam consequat bibendum dolor quisque vitae ante
– vitae ante tristique suscipit lorem

Default line range [4-8]: 
Default sentence range
Controls the number of words in each generated sentence.

Preview:
dapibus sem ut finibus pharetra vivamus vestibulum tempus tempus. in faucibus orci luctus et ultrices posuere cubilia.

Default sentence range [6-14]: 
Default paragraph range
Controls the number of sentences in each generated paragraph.

Preview:
At gravida nulla libero non mi suspendisse. Habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Elementum ligula massa tincidunt neque ut sagittis quam diam id ipsum maecenas iaculis. Morbi faucibus ultricies scelerisque etiam vitae dolor tincidunt elit tristique feugiat sit amet. Metus curabitur vel ante in neque lacinia pharetra quisque.

Vehicula et ac sem duis rutrum. Ultrices consectetur sollicitudin nunc sed enim a. Magna quis aliquam orci turpis ac.

Default paragraph range [3-5]: 
Default paragraph sentence word range
Controls the number of words in each sentence inside paragraph output.

Preview:
Consequat odio venenatis ut aliquam faucibus ligula sed pellentesque. Varius dolor fusce dictum mauris id libero varius sagittis pellentesque habitant morbi tristique senectus. Cubilia curae aliquam vestibulum id tortor at.

Default paragraph sentence word range [6-14]: 
Default bullet character
Used by `lipsum lines -b` when no explicit bullet character is provided.

Preview:
– luctus et ultrices posuere cubilia curae aliquam vestibulum
– leo vitae tincidunt accumsan felis sed erat
– tellus libero viverra et odio

Default bullet character [–]: 
Default ordered list format
Used by `lipsum lines -o` when no explicit ordered marker format is provided.

Preview:
1. Non elementum accumsan urna maecenas quis odio quis.
2. Dignissim lorem posuere quis curabitur ultricies eros.
3. Ut molestie risus tempor at nunc sit amet.

Default ordered list format [%d.]: 
Copy on generate
When enabled, lipsum copies output to the clipboard and still prints it.

Current default: no

Copy on generate [no] (yes/no): 
Installed lipsum-cli.
Executable: /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.fm5wfCnSY4/.local/bin/lipsum
Config:     /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.fm5wfCnSY4/.lipsum/config
Corpus:     /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.fm5wfCnSY4/.lipsum/words
Sources:    /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.fm5wfCnSY4/.lipsum/sources
Templates:  /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.fm5wfCnSY4/.lipsum/templates

Add /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.fm5wfCnSY4/.local/bin to your PATH to run lipsum directly.
5
```

### TC68 Installer
Editor-config mode creates a config file, validates it, and leaves a working installed executable.

```sh
tmp_home="$(mktemp -d)"; EDITOR='true' HOME="$tmp_home" zsh '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./install.sh' --editor-config >/tmp/lipsum-installer-editor.out 2>&1; rc=$?; cat /tmp/lipsum-installer-editor.out; test -f "$tmp_home/.lipsum/config" && HOME="$tmp_home" "$tmp_home/.local/bin/lipsum" 3 words -n -l; verify_rc=$?; rm -rf "$tmp_home" /tmp/lipsum-installer-editor.out; exit $(( rc || verify_rc ))
```

Exit status: 0

```text

Installed lipsum-cli.
Executable: /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.nntbLv3pXN/.local/bin/lipsum
Config:     /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.nntbLv3pXN/.lipsum/config
Corpus:     /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.nntbLv3pXN/.lipsum/words
Sources:    /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.nntbLv3pXN/.lipsum/sources
Templates:  /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.nntbLv3pXN/.lipsum/templates

Add /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.nntbLv3pXN/.local/bin to your PATH to run lipsum directly.
porta ante nullam
```

### TC69 Custom Sources
Inline text can be used as a one-off source corpus.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' --text 'alpha beta gamma delta epsilon' 5 words -n -l | tr ' ' '\n' | awk 'NR==FNR { for (i = 1; i <= NF; i++) seen[$i]=1; next } NF { if (!seen[$1]) bad=1 } END { exit bad }' <(printf 'alpha beta gamma delta epsilon\n') -
```

Exit status: 0

```text
```

### TC70 Custom Sources
A file can provide a one-off source corpus.

```sh
tmp='$(mktemp)'; printf 'maple river lantern harbor velvet canyon' > "$tmp"; out="$('/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' --file "$tmp" 5 words -n -l | tr ' ' '\n' | awk 'NR==FNR { for (i = 1; i <= NF; i++) seen[$i]=1; next } NF { if (!seen[$1]) bad=1 } END { exit bad }' "$tmp" - 2>&1)"; rc=$?; rm -f "$tmp"; printf '%s\n' "$out"; exit $rc
```

Exit status: 0

```text
```

### TC71 Custom Sources
Stdin can provide a one-off source corpus via --text -.

```sh
printf 'violet cedar ember meadow signal\n' | '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' --text - 5 words -n -l | tr ' ' '\n' | awk 'NR==FNR { for (i = 1; i <= NF; i++) seen[$i]=1; next } NF { if (!seen[$1]) bad=1 } END { exit bad }' <(printf 'violet cedar ember meadow signal\n') -
```

Exit status: 0

```text
```

### TC72 Custom Sources
Custom input can be saved as a reusable named source.

```sh
tmp_home="$(mktemp -d)"; first="$(HOME="$tmp_home" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' --text 'atlas ember harbor signal twilight' --save-source customdemo 5 words -n -l)"; second="$(HOME="$tmp_home" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' --source customdemo 5 words -n -l)"; printf 'first=%s\nsecond=%s\n' "$first" "$second"; test -f "$tmp_home/.lipsum/sources/customdemo.words"; rc=$?; rm -rf "$tmp_home"; exit $rc
```

Exit status: 0

```text
first=ember harbor ember twilight ember
second=twilight atlas twilight signal atlas
```

### TC73 Errors
Custom source input and named source selection cannot be combined.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' --source hipster --text 'alpha beta gamma' 3 words
```

Exit status: 1

```text
Error: Use either --source or custom source input, not both


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
  [1msources, list-sources[0m       List built-in and saved source corpora with samples.

Options:
  [1m-n, -N, --no-full-stop[0m       Disable the full stop appended to output by default.
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-e, -E, --emoji[0m              Mix emoji into generated output.
  [1m-r, -R, --range[0m [1mn|min-max[0m
                               [1mwords[0m: word length filter in characters
                                      (defaults to config range when omitted)
                               [1mlines[0m: words per line
                               [1msentences[0m: words per sentence
                               [1mparagraphs[0m: sentences per paragraph
                               [1mcharacters[0m: ignored
  [1m-c, -C, --copy[0m               Copy generated output to the clipboard and still print it.
  [1m--no-copy[0m                    Disable clipboard copying even if enabled in config.
  [1m--no-emoji[0m                   Disable emoji even if enabled in config.
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
  [1mlipsum[0m --text 'alpha beta gamma delta' 3 words
  [1mlipsum[0m --file ./notes.txt 2 paragraphs
  [1mcurl -fsSL https://example.com | lipsum[0m --text - --save-source example-site 5 lines
  [1mlipsum[0m 140 characters -e -n
  [1mlipsum[0m 18 words -e -s tech
  [1mlipsum[0m sources
  [1mlipsum[0m 3 sentences -c
  [1mlipsum[0m config
```

### TC74 Errors
Saving a source without custom input fails cleanly.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' --save-source customdemo 3 words
```

Exit status: 1

```text
Error: --save-source requires --text or --file input


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
  [1msources, list-sources[0m       List built-in and saved source corpora with samples.

Options:
  [1m-n, -N, --no-full-stop[0m       Disable the full stop appended to output by default.
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-e, -E, --emoji[0m              Mix emoji into generated output.
  [1m-r, -R, --range[0m [1mn|min-max[0m
                               [1mwords[0m: word length filter in characters
                                      (defaults to config range when omitted)
                               [1mlines[0m: words per line
                               [1msentences[0m: words per sentence
                               [1mparagraphs[0m: sentences per paragraph
                               [1mcharacters[0m: ignored
  [1m-c, -C, --copy[0m               Copy generated output to the clipboard and still print it.
  [1m--no-copy[0m                    Disable clipboard copying even if enabled in config.
  [1m--no-emoji[0m                   Disable emoji even if enabled in config.
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
  [1mlipsum[0m --text 'alpha beta gamma delta' 3 words
  [1mlipsum[0m --file ./notes.txt 2 paragraphs
  [1mcurl -fsSL https://example.com | lipsum[0m --text - --save-source example-site 5 lines
  [1mlipsum[0m 140 characters -e -n
  [1mlipsum[0m 18 words -e -s tech
  [1mlipsum[0m sources
  [1mlipsum[0m 3 sentences -c
  [1mlipsum[0m config
```

### TC75 Emoji
Explicit emoji mode mixes weighted emoji into word output without changing the requested word count.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "emoji_charset='😀 😀 😀'\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/emoji-config.zsh'; out="$(LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/emoji-config.zsh' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 40 words -e -n -l)"; printf '%s\n' "$out"; printf '%s\n' "$out" | grep -F '😀' >/dev/null && printf '%s\n' "$out" | awk '{ print NF; if (NF != 40) exit 1 }'
```

Exit status: 0

```text
tellus pulvinar mauris velit litora risus tristique diam erat egestas morbi volutpat lacus velit consequat elit lorem molestie elementum enim phasellus eget aenean nec a tempor sem tristique ipsum consequat faucibus congue suscipit sapien sed 😀 😀 suscipit risus tristique
40
```

### TC76 Emoji
Config-driven emoji defaults can be disabled for one invocation with --no-emoji.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "emoji_enabled=1\nemoji_charset='😀 😀 😀'\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/emoji-default-config.zsh'; out="$(LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/emoji-default-config.zsh' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 40 words --no-emoji -n -l)"; printf '%s\n' "$out"; ! printf '%s\n' "$out" | grep -F '😀' >/dev/null && printf '%s\n' "$out" | awk '{ print NF; if (NF != 40) exit 1 }'
```

Exit status: 0

```text
blandit in ipsum justo ac urna ullamcorper quam tellus tincidunt viverra a mi lacinia ligula placerat nec mauris at et ac porta leo gravida laoreet etiam velit tincidunt volutpat nulla ornare pellentesque congue a nunc id sapien leo posuere ullamcorper
40
```

### TC77 Emoji
Character mode can append sparse emoji while keeping output visually message-like.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "emoji_charset='😀 😀 😀'\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/emoji-char-config.zsh'; out="$(LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/emoji-char-config.zsh' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 140 characters -e -n)"; printf '%s\n' "$out"; printf '%s\n' "$out" | grep -F '😀' >/dev/null
```

Exit status: 0

```text
Endrerit massa pharetra eu donec est elit pulvinar sed sagittis id vulputate ac elit phasellus bibendum id lacus in semper class aptent tac 😀
```

