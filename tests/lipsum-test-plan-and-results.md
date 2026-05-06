# lipsum Test Plan And Results

Generated: 2026-05-06 15:42:00 EDT

Scripts under test:
- [/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum](/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum)
- [/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./install.sh](/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./install.sh)

## Test Plan

This plan covers the current CLI shape where generation modes are subcommands only, counts can appear before or after the subcommand, compact one-token short forms are supported, template generation is available as a first-class command, config editing/init are separate utility commands, output case can be controlled explicitly, multiple renderer formats are available, ordered lists are available for line output, emoji mixing can be enabled explicitly or via config, clipboard copying can be enabled directly or via config, and release automation scaffolding is present for branch-name enforcement and semantic-release.

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
- Output renderers: plain, html, markdown, json, and ndjson.
- Emoji mixing in explicit, config-driven, and override flows.
- Bullets and ordered lists.
- Built-in and imported templates, plus template-specific rendering flows.
- Config commands and config-driven defaults.
- Clipboard behaviors including explicit copy, config-driven copy, and explicit no-copy override.
- Installer flows for defaults, guided setup, and editor-config mode.
- Release automation scaffolding including branch-name validation and semantic-release configuration.
- Error handling for invalid combinations, removed mode flags, invalid ranges, incompatible options, and size caps.
- Shell integration patterns users are likely to rely on: loops, `xargs`, command substitution, stdin-driven wrappers, and output pipelines.

### Planned Cases

- TC01 Smoke: Syntax check parses cleanly.
- TC02 Metadata: Short help flag renders the updated usage screen and examples.
- TC03 Metadata: Long version flag returns the version string.
- TC03A Release Tooling: Branch-name validation accepts a conventional branch name.
- TC03B Release Tooling: Branch-name validation rejects a non-conventional branch name.
- TC03C Release Tooling: semantic-release configuration loads and targets main.
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
- TC79 Punctuation: End punctuation mode allows standard message endings.
- TC80 Punctuation: All punctuation mode adds internal punctuation as well as a sentence ending.
- TC81 Punctuation: None punctuation mode removes terminal punctuation entirely.
- TC82 Formats: HTML formatting wraps line output as list markup.
- TC83 Formats: Markdown formatting turns unprefixed lines into a markdown list.
- TC84 Formats: JSON formatting returns an array for paragraph output.
- TC85 Formats: NDJSON formatting emits one JSON string per requested word.
- TC86 Templates: A built-in template can render a single item.
- TC87 Templates: A top-level count works before the template command.
- TC88 Templates: The templates action separates built-in and imported templates and includes sample output.
- TC89 Templates: A custom template can be rendered from the user template directory.
- TC90 Templates: Templates also render cleanly through JSON output formatting.
- TC91 Config: Config can set the default output format for bare invocations.
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
- TC66 Installer: Defaults mode installs the executable, config, corpus, bundled sources, bundled templates, and support directories into a temp HOME.
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
- TC78 Emoji: Full stops stay attached to the text when character output ends with trailing emoji.

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
       [1mlipsum[0m [ options ] [ [1mcount|min-max[0m ] [1mtemplate[0m [1mname[0m
       [1mlipsum[0m [ options ] [1mtemplate[0m [1mname[0m [ [1mcount|min-max[0m ]
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
  [1mtemplate, tpl, tmpl[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List built-in and saved source corpora with samples.
  [1mtemplates, list-templates[0m   List built-in and saved templates with samples.

Options:
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m-f, -F, --format[0m [1mname[0m         Render as [1mplain[0m, [1mhtml[0m, [1mmarkdown[0m, [1mjson[0m, or [1mndjson[0m.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-p, -P, --punctuation[0m [ mode ]
                               Set punctuation handling: [1mperiod[0m, [1mend[0m, [1mall[0m, [1mnone[0m
                               Bare [1m-p[0m defaults to [1mall[0m
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
  [1mlipsum[0m 140 characters -e -p none
  [1mlipsum[0m 18 words -e -s tech
  [1mlipsum[0m 12 words -p all
  [1mlipsum[0m 4 lines -f html
  [1mlipsum[0m 3 paragraphs -f json
  [1mlipsum[0m template notification 4
  [1mlipsum[0m 3 template conventional-commit -p none
  [1mlipsum[0m templates
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
0.9.0
```

### TC03A Release Tooling
Branch-name validation accepts a conventional branch name.

```sh
node '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./scripts/validate-branch-name.mjs' feat/output-formats
```

Exit status: 0

```text
Branch name is valid: feat/output-formats
```

### TC03B Release Tooling
Branch-name validation rejects a non-conventional branch name.

```sh
node '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./scripts/validate-branch-name.mjs' not_a_valid_branch
```

Exit status: 1

```text
Invalid branch name: not_a_valid_branch
Expected format: <type>/<description> or <type>/<scope>/<description>
```

### TC03C Release Tooling
semantic-release configuration loads and targets main.

```sh
node -e "const config = require('./release.config.cjs'); console.log(config.branches.join(',')); if (!config.plugins.length || config.branches[0] !== 'main') process.exit(1);"
```

Exit status: 0

```text
main
```

### TC04 Defaults
Bare invocation uses the default words mode.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum'
```

Exit status: 0

```text
Et risus odio imperdiet tempus blandit eget convallis ex lectus.
```

### TC05 Defaults
A bare numeric argument is treated as a default word count.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 6
```

Exit status: 0

```text
Tortor sem eros nulla in phasellus.
```

### TC06 Words
Count before mode works for exact word counts.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 2 words
```

Exit status: 0

```text
Nunc cursus.
```

### TC07 Words
Mode before count still works for exact word counts.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' words 2
```

Exit status: 0

```text
Sed consectetur.
```

### TC08 Words
A top-level count range works for default words mode.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 3-5 -p none -l | awk '{ print NF; if (NF < 3 || NF > 5) exit 1 }'
```

Exit status: 0

```text
5
```

### TC09 Words
A top-level count range works with an explicit word subcommand.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 3-5 w -p none -l | awk '{ print NF; if (NF < 3 || NF > 5) exit 1 }'
```

Exit status: 0

```text
4
```

### TC10 Words
Word ranges filter word length in characters.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 5 words -r 3-4 -p none -l | awk '{ for (i = 1; i <= NF; i++) { if (length($i) < 3 || length($i) > 4) bad=1 } } END { print NF; if (bad) exit 1 }'
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
Dapibus nullam at suscipit nisl nulla imperdiet suscipit ipsum eget consequat quisque pharetra vitae.
```

### TC12 Characters
Character count ranges resolve to a random exact count.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 24-30 characters -p none -l | tr -d '\n' | wc -m | awk '{ print $1; if ($1 < 24 || $1 > 30) exit 1 }'
```

Exit status: 0

```text
28
```

### TC13 Characters
Internal range is ignored for characters.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 20 characters -r 3-4 -p none | tr -d '\n' | wc -m | awk '{ print $1; if ($1 != 20) exit 1 }'
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
– In pellentesque condimentum libero nullam at leo consectetur.
– Massa at volutpat massa volutpat id curabitur consectetur.
– Curabitur vel ante in neque lacinia.
– Ut bibendum a nisl curabitur ex odio.
– Dolor sit amet consectetur.
```

### TC15 Lines
Random top-level line counts and internal line lengths both work together.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4-6 lines -r 6-10 | awk '{ print NF; if (NF < 6 || NF > 10) bad=1 } END { if (NR < 4 || NR > 6 || bad) exit 1 }'
```

Exit status: 0

```text
8
9
8
8
10
7
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
4
```

### TC17 Sentences
Default sentences mode generates the requested number of sentences.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 2 sentences
```

Exit status: 0

```text
Purus sagittis volutpat donec elementum mi nec diam. Orci ut fermentum risus molestie eu.
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
5
```

### TC19 Paragraphs
Default paragraphs mode emits multiple paragraphs with blank-line separation.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 2 paragraphs
```

Exit status: 0

```text
Eleifend in sed tincidunt tincidunt mauris sed faucibus lectus efficitur. Lobortis eu pellentesque id aliquam at lectus maecenas dictum. Lorem iaculis consectetur pellentesque nec malesuada felis aenean elit elit facilisis at magna.

Eros in auctor praesent congue tincidunt risus quisque pulvinar eget nunc ac. Euismod dictum praesent sollicitudin euismod libero consectetur feugiat nunc rutrum ac sed sollicitudin elit. Interdum sapien neque consectetur mi ac sagittis felis est eget est cras tempus.
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
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 10c -p none | tr -d '\n' | wc -m | awk '{ print $1; if ($1 != 10) exit 1 }'
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
1
```

### TC25 Case
Lowercase output works with the new lowercase option.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4 words -p none -l
```

Exit status: 0

```text
suscipit feugiat purus pharetra
```

### TC26 Case
Uppercase output works.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4 words -p none -u
```

Exit status: 0

```text
MASSA RHONCUS ID BIBENDUM
```

### TC27 Case
Title case output works.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4 words -p none -t
```

Exit status: 0

```text
Vestibulum Euismod Consequat Ultrices
```

### TC79 Punctuation
End punctuation mode allows standard message endings.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 12 words -p end | grep -Eq '[.!?]$'
```

Exit status: 0

```text
```

### TC80 Punctuation
All punctuation mode adds internal punctuation as well as a sentence ending.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 12 words -p all -l | grep -Eq '[,()—-].*[.!?]$'
```

Exit status: 0

```text
```

### TC81 Punctuation
None punctuation mode removes terminal punctuation entirely.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 8 words -p none -l | grep -Ev '[.!?]$'
```

Exit status: 0

```text
suscipit nullam ipsum ultricies lectus sit elementum nulla
```

### TC82 Formats
HTML formatting wraps line output as list markup.

```sh
out="$('/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 3 lines -f html)"; printf '%s\n' "$out"; printf '%s\n' "$out" | grep -F '<ul>' >/dev/null && printf '%s\n' "$out" | grep -F '<li>' >/dev/null && printf '%s\n' "$out" | grep -F '</ul>' >/dev/null
```

Exit status: 0

```text
<ul>
  <li>Gravida sit amet risus eget.</li>
  <li>Justo a massa accumsan ut cursus ante.</li>
  <li>Diam maecenas nec urna sed ante lobortis pharetra.</li>
</ul>
```

### TC83 Formats
Markdown formatting turns unprefixed lines into a markdown list.

```sh
out="$('/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 3 lines -f markdown -p none -l)"; printf '%s\n' "$out"; printf '%s\n' "$out" | awk '/^- / { count++ } END { if (count != 3) exit 1 }'
```

Exit status: 0

```text
- diam commodo varius maecenas aliquet
- ipsum primis in faucibus
- nunc a velit lectus interdum
```

### TC84 Formats
JSON formatting returns an array for paragraph output.

```sh
out="$('/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 2 paragraphs -f json)"; printf '%s\n' "$out"; printf '%s\n' "$out" | grep -Eq '^\[ ".*", ".*" \]$'
```

Exit status: 0

```text
[ "Enim nulla facilisi sed at pretium magna ac iaculis diam. Euismod nulla ut aliquet imperdiet ex. Odio nunc bibendum auctor metus vitae tincidunt donec at tincidunt tellus suspendisse. Nec dapibus integer id eros tortor donec pharetra. Augue eu mattis semper nisi mauris tempor quam.", "Orci molestie nec mauris nec sem. Porttitor odio sit amet nisl consequat iaculis nam augue dolor ultrices ut suscipit. Vel finibus ex congue a mauris. Ante finibus proin eu blandit libero vel eleifend risus morbi vehicula lacus id hendrerit." ]
```

### TC85 Formats
NDJSON formatting emits one JSON string per requested word.

```sh
out="$('/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4 words -f ndjson -p none -l)"; printf '%s\n' "$out"; printf '%s\n' "$out" | awk '/^".*"$/ { count++ } END { if (count != 4) exit 1 }'
```

Exit status: 0

```text
"nec"
"quis"
"lobortis"
"gravida"
```

### TC86 Templates
A built-in template can render a single item.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' template notification
```

Exit status: 0

```text
ut bibendum turpis nam sit amet cursus! 💡
```

### TC87 Templates
A top-level count works before the template command.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 3 template conventional-commit -p none | awk 'END { print NR; if (NR != 3) exit 1 }'
```

Exit status: 0

```text
3
```

### TC88 Templates
The templates action separates built-in and imported templates and includes sample output.

```sh
tmp_home="$(mktemp -d)"; mkdir -p "$tmp_home/.lipsum/templates"; printf '# title: Custom Ticket\nticket-{{number(100-999)}} {{choice(alpha|beta|gamma)}}\n' > "$tmp_home/.lipsum/templates/custom-ticket.tpl"; out="$(HOME="$tmp_home" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' templates)"; printf '%s\n' "$out"; printf '%s\n' "$out" | grep -F 'Built-In Templates:' >/dev/null && printf '%s\n' "$out" | grep -F 'Imported Templates:' >/dev/null && printf '%s\n' "$out" | grep -F 'Conventional Commit (conventional-commit)' >/dev/null && printf '%s\n' "$out" | grep -F 'Custom Ticket (custom-ticket)' >/dev/null; rc=$?; rm -rf "$tmp_home"; exit $rc
```

Exit status: 0

```text
Available Templates

Built-In Templates:
- Conventional Commit (conventional-commit)
  fix: risus eget fermentum ligula

- Email Subject (email-subject)
  follow-up: eu donec

- Notification (notification)
  tincidunt integer orci sodales posuere nam et! 👍

- APA Citation (apa-citation)
  convallis, quis. (1992). Efficitur metus vel posuere risus libero vel.

- Status Update (status-update)
  tracking amet volutpat iaculis!

Imported Templates:
- Custom Ticket (custom-ticket)
  ticket-804 alpha
```

### TC89 Templates
A custom template can be rendered from the user template directory.

```sh
tmp_home="$(mktemp -d)"; mkdir -p "$tmp_home/.lipsum/templates"; printf '# title: Ticket\nticket-{{number(100-999)}} {{choice(alpha|beta|gamma)}}\n' > "$tmp_home/.lipsum/templates/ticket.tpl"; out="$(HOME="$tmp_home" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' template ticket -p none)"; printf '%s\n' "$out"; printf '%s\n' "$out" | grep -Eq '^ticket-[0-9]{3} (alpha|beta|gamma)$'; rc=$?; rm -rf "$tmp_home"; exit $rc
```

Exit status: 0

```text
ticket-920 gamma
```

### TC90 Templates
Templates also render cleanly through JSON output formatting.

```sh
out="$('/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 2 template conventional-commit -p none -f json)"; printf '%s\n' "$out"; printf '%s\n' "$out" | grep -Eq '^\[ ".+", ".+" \]$'
```

Exit status: 0

```text
[ "fix: orci luctus et", "style: tortor varius ut elit ut" ]
```

### TC91 Config
Config can set the default output format for bare invocations.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "default_mode='lines'\ndefault_line_count=2\ndefault_line_range='2-2'\ndefault_format='json'\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/format-config.zsh'; out="$(LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/format-config.zsh' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' -p none -l)"; printf '%s\n' "$out"; printf '%s\n' "$out" | grep -Eq '^\[ ".+", ".+" \]$'
```

Exit status: 0

```text
[ "nec est", "proin viverra" ]
```

### TC28 Ordered Lists
Default ordered lists use numeric markers.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 3 lines -o
```

Exit status: 0

```text
1. Lorem ultricies pharetra pellentesque quis.
2. Vel justo ac quam pulvinar aliquet.
3. Vestibulum turpis phasellus ac pulvinar.
```

### TC29 Ordered Lists
Ordered list formulas support alphabetic markers.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4 lines -o '(%A)'
```

Exit status: 0

```text
(A) In faucibus vestibulum ante ipsum primis.
(B) Nunc orci ac lectus sed.
(C) Netus et malesuada fames ac.
(D) Non non magna sed at erat orci cras.
```

### TC30 Ordered Lists
Ordered list formulas support zero-padded zero-indexed digits.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 3 lines -o '%00z)'
```

Exit status: 0

```text
000) Ac rutrum lacus cras ac nisl dictum.
001) Mauris libero efficitur metus vel posuere risus.
002) Ligula fusce laoreet pharetra ultrices pellentesque habitant.
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
default_format='plain'
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
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "default_mode='lines'\ndefault_line_count=3\ndefault_line_range='2-2'\ndefault_bullet_char='*'\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/defaults-config.zsh'; LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/defaults-config.zsh' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' -b -p none -l | awk '/^\*/ { print NF - 1; if (NF - 1 != 2) bad=1; count++ } END { if (count != 3 || bad) exit 1 }'
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
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "default_mode='characters'\ndefault_character_count=20\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/mode-config.zsh'; LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/mode-config.zsh' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' -p none -l | tr -d '\n' | wc -m | awk '{ print $1; if ($1 != 20) exit 1 }'
```

Exit status: 0

```text
20
```

### TC36 Config
Default word-length range applies to words output when no explicit range is provided.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "default_word_length_range='3-4'\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/word-range-config.zsh'; LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/word-range-config.zsh' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 5 words -p none -l | awk '{ for (i = 1; i <= NF; i++) { if (length($i) < 3 || length($i) > 4) bad=1 } } END { print NF; if (bad) exit 1 }'
```

Exit status: 0

```text
5
```

### TC37 Copy
Explicit copy writes the same content to the clipboard target and stdout.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; rm -f '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/clipboard-explicit.txt'; out="$(LIPSUM_CLIPBOARD_COMMAND="sh -c 'cat > \"\$1\"' _ '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/clipboard-explicit.txt'" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4 w -c -p none -l)"; clip="$(cat '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/clipboard-explicit.txt')"; printf 'stdout=%s\nclipboard=%s\n' "$out" "$clip"; [[ "$out" == "$clip" ]]
```

Exit status: 0

```text
stdout=etiam eu viverra quam
clipboard=etiam eu viverra quam
```

### TC38 Copy
Config can enable copy by default.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "copy_on_generate=1\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/copy-config.zsh'; rm -f '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/clipboard-config.txt'; out="$(LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/copy-config.zsh' LIPSUM_CLIPBOARD_COMMAND="sh -c 'cat > \"\$1\"' _ '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/clipboard-config.txt'" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4 w -p none -l)"; clip="$(cat '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/clipboard-config.txt')"; printf 'stdout=%s\nclipboard=%s\n' "$out" "$clip"; [[ "$out" == "$clip" ]]
```

Exit status: 0

```text
stdout=mattis tincidunt gravida velit
clipboard=mattis tincidunt gravida velit
```

### TC39 Copy
Explicit no-copy overrides config-driven clipboard copying.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "copy_on_generate=1\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/no-copy-config.zsh'; rm -f '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/clipboard-no-copy.txt'; out="$(LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/no-copy-config.zsh' LIPSUM_CLIPBOARD_COMMAND="sh -c 'cat > \"\$1\"' _ '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/clipboard-no-copy.txt'" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4 w --no-copy -p none -l)"; printf 'stdout=%s\nclipboard_exists=%s\n' "$out" "$(test -e '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/clipboard-no-copy.txt'; echo $?)"; [[ ! -e '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/clipboard-no-copy.txt' ]]
```

Exit status: 0

```text
stdout=sagittis rhoncus euismod id
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
       [1mlipsum[0m [ options ] [ [1mcount|min-max[0m ] [1mtemplate[0m [1mname[0m
       [1mlipsum[0m [ options ] [1mtemplate[0m [1mname[0m [ [1mcount|min-max[0m ]
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
  [1mtemplate, tpl, tmpl[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List built-in and saved source corpora with samples.
  [1mtemplates, list-templates[0m   List built-in and saved templates with samples.

Options:
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m-f, -F, --format[0m [1mname[0m         Render as [1mplain[0m, [1mhtml[0m, [1mmarkdown[0m, [1mjson[0m, or [1mndjson[0m.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-p, -P, --punctuation[0m [ mode ]
                               Set punctuation handling: [1mperiod[0m, [1mend[0m, [1mall[0m, [1mnone[0m
                               Bare [1m-p[0m defaults to [1mall[0m
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
  [1mlipsum[0m 140 characters -e -p none
  [1mlipsum[0m 18 words -e -s tech
  [1mlipsum[0m 12 words -p all
  [1mlipsum[0m 4 lines -f html
  [1mlipsum[0m 3 paragraphs -f json
  [1mlipsum[0m template notification 4
  [1mlipsum[0m 3 template conventional-commit -p none
  [1mlipsum[0m templates
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
       [1mlipsum[0m [ options ] [ [1mcount|min-max[0m ] [1mtemplate[0m [1mname[0m
       [1mlipsum[0m [ options ] [1mtemplate[0m [1mname[0m [ [1mcount|min-max[0m ]
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
  [1mtemplate, tpl, tmpl[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List built-in and saved source corpora with samples.
  [1mtemplates, list-templates[0m   List built-in and saved templates with samples.

Options:
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m-f, -F, --format[0m [1mname[0m         Render as [1mplain[0m, [1mhtml[0m, [1mmarkdown[0m, [1mjson[0m, or [1mndjson[0m.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-p, -P, --punctuation[0m [ mode ]
                               Set punctuation handling: [1mperiod[0m, [1mend[0m, [1mall[0m, [1mnone[0m
                               Bare [1m-p[0m defaults to [1mall[0m
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
  [1mlipsum[0m 140 characters -e -p none
  [1mlipsum[0m 18 words -e -s tech
  [1mlipsum[0m 12 words -p all
  [1mlipsum[0m 4 lines -f html
  [1mlipsum[0m 3 paragraphs -f json
  [1mlipsum[0m template notification 4
  [1mlipsum[0m 3 template conventional-commit -p none
  [1mlipsum[0m templates
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
       [1mlipsum[0m [ options ] [ [1mcount|min-max[0m ] [1mtemplate[0m [1mname[0m
       [1mlipsum[0m [ options ] [1mtemplate[0m [1mname[0m [ [1mcount|min-max[0m ]
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
  [1mtemplate, tpl, tmpl[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List built-in and saved source corpora with samples.
  [1mtemplates, list-templates[0m   List built-in and saved templates with samples.

Options:
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m-f, -F, --format[0m [1mname[0m         Render as [1mplain[0m, [1mhtml[0m, [1mmarkdown[0m, [1mjson[0m, or [1mndjson[0m.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-p, -P, --punctuation[0m [ mode ]
                               Set punctuation handling: [1mperiod[0m, [1mend[0m, [1mall[0m, [1mnone[0m
                               Bare [1m-p[0m defaults to [1mall[0m
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
  [1mlipsum[0m 140 characters -e -p none
  [1mlipsum[0m 18 words -e -s tech
  [1mlipsum[0m 12 words -p all
  [1mlipsum[0m 4 lines -f html
  [1mlipsum[0m 3 paragraphs -f json
  [1mlipsum[0m template notification 4
  [1mlipsum[0m 3 template conventional-commit -p none
  [1mlipsum[0m templates
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
       [1mlipsum[0m [ options ] [ [1mcount|min-max[0m ] [1mtemplate[0m [1mname[0m
       [1mlipsum[0m [ options ] [1mtemplate[0m [1mname[0m [ [1mcount|min-max[0m ]
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
  [1mtemplate, tpl, tmpl[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List built-in and saved source corpora with samples.
  [1mtemplates, list-templates[0m   List built-in and saved templates with samples.

Options:
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m-f, -F, --format[0m [1mname[0m         Render as [1mplain[0m, [1mhtml[0m, [1mmarkdown[0m, [1mjson[0m, or [1mndjson[0m.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-p, -P, --punctuation[0m [ mode ]
                               Set punctuation handling: [1mperiod[0m, [1mend[0m, [1mall[0m, [1mnone[0m
                               Bare [1m-p[0m defaults to [1mall[0m
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
  [1mlipsum[0m 140 characters -e -p none
  [1mlipsum[0m 18 words -e -s tech
  [1mlipsum[0m 12 words -p all
  [1mlipsum[0m 4 lines -f html
  [1mlipsum[0m 3 paragraphs -f json
  [1mlipsum[0m template notification 4
  [1mlipsum[0m 3 template conventional-commit -p none
  [1mlipsum[0m templates
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
       [1mlipsum[0m [ options ] [ [1mcount|min-max[0m ] [1mtemplate[0m [1mname[0m
       [1mlipsum[0m [ options ] [1mtemplate[0m [1mname[0m [ [1mcount|min-max[0m ]
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
  [1mtemplate, tpl, tmpl[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List built-in and saved source corpora with samples.
  [1mtemplates, list-templates[0m   List built-in and saved templates with samples.

Options:
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m-f, -F, --format[0m [1mname[0m         Render as [1mplain[0m, [1mhtml[0m, [1mmarkdown[0m, [1mjson[0m, or [1mndjson[0m.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-p, -P, --punctuation[0m [ mode ]
                               Set punctuation handling: [1mperiod[0m, [1mend[0m, [1mall[0m, [1mnone[0m
                               Bare [1m-p[0m defaults to [1mall[0m
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
  [1mlipsum[0m 140 characters -e -p none
  [1mlipsum[0m 18 words -e -s tech
  [1mlipsum[0m 12 words -p all
  [1mlipsum[0m 4 lines -f html
  [1mlipsum[0m 3 paragraphs -f json
  [1mlipsum[0m template notification 4
  [1mlipsum[0m 3 template conventional-commit -p none
  [1mlipsum[0m templates
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
       [1mlipsum[0m [ options ] [ [1mcount|min-max[0m ] [1mtemplate[0m [1mname[0m
       [1mlipsum[0m [ options ] [1mtemplate[0m [1mname[0m [ [1mcount|min-max[0m ]
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
  [1mtemplate, tpl, tmpl[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List built-in and saved source corpora with samples.
  [1mtemplates, list-templates[0m   List built-in and saved templates with samples.

Options:
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m-f, -F, --format[0m [1mname[0m         Render as [1mplain[0m, [1mhtml[0m, [1mmarkdown[0m, [1mjson[0m, or [1mndjson[0m.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-p, -P, --punctuation[0m [ mode ]
                               Set punctuation handling: [1mperiod[0m, [1mend[0m, [1mall[0m, [1mnone[0m
                               Bare [1m-p[0m defaults to [1mall[0m
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
  [1mlipsum[0m 140 characters -e -p none
  [1mlipsum[0m 18 words -e -s tech
  [1mlipsum[0m 12 words -p all
  [1mlipsum[0m 4 lines -f html
  [1mlipsum[0m 3 paragraphs -f json
  [1mlipsum[0m template notification 4
  [1mlipsum[0m 3 template conventional-commit -p none
  [1mlipsum[0m templates
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
       [1mlipsum[0m [ options ] [ [1mcount|min-max[0m ] [1mtemplate[0m [1mname[0m
       [1mlipsum[0m [ options ] [1mtemplate[0m [1mname[0m [ [1mcount|min-max[0m ]
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
  [1mtemplate, tpl, tmpl[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List built-in and saved source corpora with samples.
  [1mtemplates, list-templates[0m   List built-in and saved templates with samples.

Options:
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m-f, -F, --format[0m [1mname[0m         Render as [1mplain[0m, [1mhtml[0m, [1mmarkdown[0m, [1mjson[0m, or [1mndjson[0m.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-p, -P, --punctuation[0m [ mode ]
                               Set punctuation handling: [1mperiod[0m, [1mend[0m, [1mall[0m, [1mnone[0m
                               Bare [1m-p[0m defaults to [1mall[0m
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
  [1mlipsum[0m 140 characters -e -p none
  [1mlipsum[0m 18 words -e -s tech
  [1mlipsum[0m 12 words -p all
  [1mlipsum[0m 4 lines -f html
  [1mlipsum[0m 3 paragraphs -f json
  [1mlipsum[0m template notification 4
  [1mlipsum[0m 3 template conventional-commit -p none
  [1mlipsum[0m templates
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
       [1mlipsum[0m [ options ] [ [1mcount|min-max[0m ] [1mtemplate[0m [1mname[0m
       [1mlipsum[0m [ options ] [1mtemplate[0m [1mname[0m [ [1mcount|min-max[0m ]
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
  [1mtemplate, tpl, tmpl[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List built-in and saved source corpora with samples.
  [1mtemplates, list-templates[0m   List built-in and saved templates with samples.

Options:
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m-f, -F, --format[0m [1mname[0m         Render as [1mplain[0m, [1mhtml[0m, [1mmarkdown[0m, [1mjson[0m, or [1mndjson[0m.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-p, -P, --punctuation[0m [ mode ]
                               Set punctuation handling: [1mperiod[0m, [1mend[0m, [1mall[0m, [1mnone[0m
                               Bare [1m-p[0m defaults to [1mall[0m
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
  [1mlipsum[0m 140 characters -e -p none
  [1mlipsum[0m 18 words -e -s tech
  [1mlipsum[0m 12 words -p all
  [1mlipsum[0m 4 lines -f html
  [1mlipsum[0m 3 paragraphs -f json
  [1mlipsum[0m template notification 4
  [1mlipsum[0m 3 template conventional-commit -p none
  [1mlipsum[0m templates
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
       [1mlipsum[0m [ options ] [ [1mcount|min-max[0m ] [1mtemplate[0m [1mname[0m
       [1mlipsum[0m [ options ] [1mtemplate[0m [1mname[0m [ [1mcount|min-max[0m ]
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
  [1mtemplate, tpl, tmpl[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List built-in and saved source corpora with samples.
  [1mtemplates, list-templates[0m   List built-in and saved templates with samples.

Options:
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m-f, -F, --format[0m [1mname[0m         Render as [1mplain[0m, [1mhtml[0m, [1mmarkdown[0m, [1mjson[0m, or [1mndjson[0m.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-p, -P, --punctuation[0m [ mode ]
                               Set punctuation handling: [1mperiod[0m, [1mend[0m, [1mall[0m, [1mnone[0m
                               Bare [1m-p[0m defaults to [1mall[0m
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
  [1mlipsum[0m 140 characters -e -p none
  [1mlipsum[0m 18 words -e -s tech
  [1mlipsum[0m 12 words -p all
  [1mlipsum[0m 4 lines -f html
  [1mlipsum[0m 3 paragraphs -f json
  [1mlipsum[0m template notification 4
  [1mlipsum[0m 3 template conventional-commit -p none
  [1mlipsum[0m templates
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
       [1mlipsum[0m [ options ] [ [1mcount|min-max[0m ] [1mtemplate[0m [1mname[0m
       [1mlipsum[0m [ options ] [1mtemplate[0m [1mname[0m [ [1mcount|min-max[0m ]
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
  [1mtemplate, tpl, tmpl[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List built-in and saved source corpora with samples.
  [1mtemplates, list-templates[0m   List built-in and saved templates with samples.

Options:
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m-f, -F, --format[0m [1mname[0m         Render as [1mplain[0m, [1mhtml[0m, [1mmarkdown[0m, [1mjson[0m, or [1mndjson[0m.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-p, -P, --punctuation[0m [ mode ]
                               Set punctuation handling: [1mperiod[0m, [1mend[0m, [1mall[0m, [1mnone[0m
                               Bare [1m-p[0m defaults to [1mall[0m
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
  [1mlipsum[0m 140 characters -e -p none
  [1mlipsum[0m 18 words -e -s tech
  [1mlipsum[0m 12 words -p all
  [1mlipsum[0m 4 lines -f html
  [1mlipsum[0m 3 paragraphs -f json
  [1mlipsum[0m template notification 4
  [1mlipsum[0m 3 template conventional-commit -p none
  [1mlipsum[0m templates
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
       [1mlipsum[0m [ options ] [ [1mcount|min-max[0m ] [1mtemplate[0m [1mname[0m
       [1mlipsum[0m [ options ] [1mtemplate[0m [1mname[0m [ [1mcount|min-max[0m ]
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
  [1mtemplate, tpl, tmpl[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List built-in and saved source corpora with samples.
  [1mtemplates, list-templates[0m   List built-in and saved templates with samples.

Options:
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m-f, -F, --format[0m [1mname[0m         Render as [1mplain[0m, [1mhtml[0m, [1mmarkdown[0m, [1mjson[0m, or [1mndjson[0m.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-p, -P, --punctuation[0m [ mode ]
                               Set punctuation handling: [1mperiod[0m, [1mend[0m, [1mall[0m, [1mnone[0m
                               Bare [1m-p[0m defaults to [1mall[0m
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
  [1mlipsum[0m 140 characters -e -p none
  [1mlipsum[0m 18 words -e -s tech
  [1mlipsum[0m 12 words -p all
  [1mlipsum[0m 4 lines -f html
  [1mlipsum[0m 3 paragraphs -f json
  [1mlipsum[0m template notification 4
  [1mlipsum[0m 3 template conventional-commit -p none
  [1mlipsum[0m templates
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
       [1mlipsum[0m [ options ] [ [1mcount|min-max[0m ] [1mtemplate[0m [1mname[0m
       [1mlipsum[0m [ options ] [1mtemplate[0m [1mname[0m [ [1mcount|min-max[0m ]
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
  [1mtemplate, tpl, tmpl[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List built-in and saved source corpora with samples.
  [1mtemplates, list-templates[0m   List built-in and saved templates with samples.

Options:
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m-f, -F, --format[0m [1mname[0m         Render as [1mplain[0m, [1mhtml[0m, [1mmarkdown[0m, [1mjson[0m, or [1mndjson[0m.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-p, -P, --punctuation[0m [ mode ]
                               Set punctuation handling: [1mperiod[0m, [1mend[0m, [1mall[0m, [1mnone[0m
                               Bare [1m-p[0m defaults to [1mall[0m
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
  [1mlipsum[0m 140 characters -e -p none
  [1mlipsum[0m 18 words -e -s tech
  [1mlipsum[0m 12 words -p all
  [1mlipsum[0m 4 lines -f html
  [1mlipsum[0m 3 paragraphs -f json
  [1mlipsum[0m template notification 4
  [1mlipsum[0m 3 template conventional-commit -p none
  [1mlipsum[0m templates
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
       [1mlipsum[0m [ options ] [ [1mcount|min-max[0m ] [1mtemplate[0m [1mname[0m
       [1mlipsum[0m [ options ] [1mtemplate[0m [1mname[0m [ [1mcount|min-max[0m ]
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
  [1mtemplate, tpl, tmpl[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/bad-config.zsh[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List built-in and saved source corpora with samples.
  [1mtemplates, list-templates[0m   List built-in and saved templates with samples.

Options:
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m-f, -F, --format[0m [1mname[0m         Render as [1mplain[0m, [1mhtml[0m, [1mmarkdown[0m, [1mjson[0m, or [1mndjson[0m.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-p, -P, --punctuation[0m [ mode ]
                               Set punctuation handling: [1mperiod[0m, [1mend[0m, [1mall[0m, [1mnone[0m
                               Bare [1m-p[0m defaults to [1mall[0m
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
  [1mlipsum[0m 140 characters -e -p none
  [1mlipsum[0m 18 words -e -s tech
  [1mlipsum[0m 12 words -p all
  [1mlipsum[0m 4 lines -f html
  [1mlipsum[0m 3 paragraphs -f json
  [1mlipsum[0m template notification 4
  [1mlipsum[0m 3 template conventional-commit -p none
  [1mlipsum[0m templates
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
– Feugiat nunc rutrum.
– Egestas orci vel porta.
– Eleifend egestas donec efficitur consequat.
```

### TC54 Shell Integration
Piped numeric input can drive sentence generation through a while-read loop.

```sh
printf '4\n6\n' | while read -r n; do '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 1 s -r "$n" -l; done
```

Exit status: 0

```text
accumsan felis sed erat.
dui consequat hendrerit pellentesque et justo.
```

### TC55 Shell Integration
Piped numeric input can drive line generation through xargs.

```sh
printf '3\n5\n' | xargs -I{} zsh -c "'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 1 lines -r \"\$1\" -b" _ {}
```

Exit status: 0

```text
– Diam maecenas nec.
– Purus feugiat diam commodo varius.
```

### TC56 Shell Integration
Command substitution can inline generated text inside another command.

```sh
printf '[%s]\n' "$('/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4 w -p none -l)"
```

Exit status: 0

```text
[nec suscipit ut morbi]
```

### TC57 Shell Integration
Direct stdin piping into lipsum is harmless and the command still produces stdout.

```sh
printf 'stdin is ignored here\n' | '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 5 w
```

Exit status: 0

```text
Integer suscipit neque nisi sit.
```

### TC58 Shell Integration
Paragraph output can be piped into fold for visual wrapping.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 1 p | fold -s -w 40
```

Exit status: 0

```text
Mauris libero efficitur metus vel 
posuere. Nisl ultrices scelerisque eros 
porta nec phasellus nec faucibus risus. 
Ex dolor egestas ut est quis consequat 
venenatis quam lorem ipsum.
```

### TC59 Shell Integration
Bullet output can be piped into line numbering for visual review.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4 l -b | nl -ba
```

Exit status: 0

```text
     1	– Dui luctus varius purus congue in praesent varius.
     2	– A sem ullamcorper maximus nullam.
     3	– Amet imperdiet lectus tincidunt maximus phasellus.
     4	– Libero neque ultricies id.
```

### TC60 Shell Integration
Word output can be piped into newline transforms for tokenized display.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 8 w -p none -l | tr ' ' '\n'
```

Exit status: 0

```text
consectetur
risus
curabitur
ultrices
ex
posuere
fringilla
pretium
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
  Commodo mollis phasellus dictum leo luctus quam condimentum sed. Erat volutpat cras quis justo in urna.

- Hipster Ipsum (hipster)
  Banjo mumblecore wayfarers pabst scenester lo fi. Cardigan hammock umami kickstarter tote small batch.

- Tech Ipsum (tech)
  Docs preview staging production canary release candidate instrumentation search. Feature flag telemetry dashboard workflow session cache vector model prompt.

- Pirate Ipsum (pirate)
  Pump dockside lantern reef breaker compass rose longboat shoreline wave. Cannon rope splice driftwood treasure map harbor bell stern bow helm.

- Food Ipsum (food)
  Fishmonger greengrocer vineyard farmhouse garden party supper club pastry. Brioche croissant tartlet shortbread crumble infusion tasting menu supper brunch.

- Corporate Ipsum (corporate)
  Planning horizon commercial model revenue mix margin. Streamlining priority matrix facilitator summary synthesis memo.

- Spanish Ipsum (es)
  Verano invierno primavera otono sonrisa latido huella. Harina barrotejado patio corredor balcon techo cuaderno.

- French Ipsum (fr)
  Guitare ronde prairie moulin horizon cuisine terrasse avenue carnet douceur. Vallee miroir manteau livre lettre encre musique danse caresse calme.

- German Ipsum (de)
  Hof balkon lampe geschichte zuflucht stoff gitarre runde wiese muhle horizont. Feuer schatten platz gasse bruecke wind samen frucht.

Imported Sources:
- Custom Demo (custom-demo)
  Atlas ember harbor signal twilight atlas ember harbor signal. Atlas ember harbor signal twilight atlas ember harbor signal twilight.

Default source: lorem
```

### TC62 Sources
The long source option selects a named source corpus for one invocation.

```sh
HOME="$(mktemp -d)" LIPSUM_SOURCE_DIR='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./share/sources' LIPSUM_DICT='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./share/lorem.words' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' --source hipster 6 words -p none -l | tr ' ' '\n' | awk 'NR==FNR { for (i = 1; i <= NF; i++) seen[$i]=1; next } NF { if (!seen[$1]) bad=1 } END { exit bad }' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./share/sources/hipster.words' -
```

Exit status: 0

```text
```

### TC63 Sources
The short source option selects another named source corpus.

```sh
HOME="$(mktemp -d)" LIPSUM_SOURCE_DIR='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./share/sources' LIPSUM_DICT='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./share/lorem.words' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' -s tech 6 words -p none -l | tr ' ' '\n' | awk 'NR==FNR { for (i = 1; i <= NF; i++) seen[$i]=1; next } NF { if (!seen[$1]) bad=1 } END { exit bad }' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./share/sources/tech.words' -
```

Exit status: 0

```text
```

### TC64 Sources
Config can change the default source for bare and explicit generation.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "default_source='corporate'\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/source-config.zsh'; LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/source-config.zsh' LIPSUM_SOURCE_DIR='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./share/sources' LIPSUM_DICT='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./share/lorem.words' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 6 words -p none -l | tr ' ' '\n' | awk 'NR==FNR { for (i = 1; i <= NF; i++) seen[$i]=1; next } NF { if (!seen[$1]) bad=1 } END { exit bad }' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./share/sources/corporate.words' -
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
Defaults mode installs the executable, config, corpus, bundled sources, bundled templates, and support directories into a temp HOME.

```sh
tmp_home="$(mktemp -d)"; bin_dir="$tmp_home/.local/bin"; HOME="$tmp_home" zsh '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./install.sh' --yes --bin-dir "$bin_dir" >/tmp/lipsum-installer-defaults.out; rc=$?; cat /tmp/lipsum-installer-defaults.out; test -x "$bin_dir/lipsum" && test -f "$tmp_home/.lipsum/config" && grep -F 'emoji_charset=' "$tmp_home/.lipsum/config" >/dev/null && grep -F "punctuation_mode='period'" "$tmp_home/.lipsum/config" >/dev/null && grep -F "default_format='plain'" "$tmp_home/.lipsum/config" >/dev/null && test -f "$tmp_home/.lipsum/words" && test -f "$tmp_home/.lipsum/sources/lorem.words" && test -f "$tmp_home/.lipsum/sources/hipster.words" && test -f "$tmp_home/.lipsum/sources/tech.words" && test -f "$tmp_home/.lipsum/sources/pirate.words" && test -f "$tmp_home/.lipsum/sources/food.words" && test -f "$tmp_home/.lipsum/sources/corporate.words" && test -f "$tmp_home/.lipsum/sources/de.words" && test -f "$tmp_home/.lipsum/templates/conventional-commit.tpl" && test -f "$tmp_home/.lipsum/templates/notification.tpl" && HOME="$tmp_home" "$bin_dir/lipsum" template notification >/dev/null && HOME="$tmp_home" "$bin_dir/lipsum" 4 words -p none -l; verify_rc=$?; rm -rf "$tmp_home" /tmp/lipsum-installer-defaults.out; exit $(( rc || verify_rc ))
```

Exit status: 0

```text

Installed lipsum-cli.
Executable: /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.Jnl5mtdXjp/.local/bin/lipsum
Config:     /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.Jnl5mtdXjp/.lipsum/config
Corpus:     /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.Jnl5mtdXjp/.lipsum/words
Sources:    /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.Jnl5mtdXjp/.lipsum/sources
Templates:  /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.Jnl5mtdXjp/.lipsum/templates

Add /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.Jnl5mtdXjp/.local/bin to your PATH to run lipsum directly.
tellus enim felis aliquam.
```

### TC67 Installer
Interactive mode accepts step-by-step input and can change the default mode before installation.

```sh
tmp_home="$(mktemp -d)"; bin_dir="$tmp_home/.local/bin"; answers=$(printf 'lines\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n'); out="$(printf '%s' "$answers" | HOME="$tmp_home" zsh '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./install.sh' --interactive --bin-dir "$bin_dir" 2>&1)"; rc=$?; printf '%s\n' "$out"; HOME="$tmp_home" "$bin_dir/lipsum" -b -p none -l | awk '/^./ { count++ } END { print count; if (count != 5) exit 1 }'; verify_rc=$?; rm -rf "$tmp_home"; exit $(( rc || verify_rc ))
```

Exit status: 0

```text

Default mode
This controls what a bare `lipsum` command generates.

Preview:
Nibh purus gravida lectus sagittis quam magna fringilla ante dui.

Default mode [words] (words/characters/lines/sentences/paragraphs): 
Default source
Choose the source corpus used by default. Available: lorem hipster tech pirate food corporate es fr de.

Preview:
sed nulla ut dis cras elementum.

Default source [lorem]: 
Default word count
Used when your default mode is words and you run `lipsum` with no count.

Preview:
Quis lacinia magna suscipit nulla sapien morbi dictumst egestas turpis.

Default word count [10]: 
Default character count
Used when your default mode is characters and you run `lipsum` with no count.

Preview:
Rmentum semper nulla nec quam fa.

Default character count [32]: 
Default line count
Used when your default mode is lines and you run `lipsum` with no count.

Preview:
– Sapien eleifend rutrum aenean et.
– Pharetra purus id aliquam.
– Nec lorem viverra rutrum suspendisse viverra auctor.
– Nam elit ante ultricies.
– Leo luctus quam condimentum.

Default line count [5]: 
Default sentence count
Used when your default mode is sentences and you run `lipsum` with no count.

Preview:
Quis ante porta tempus nec at lorem sed a. Maximus risus fusce ut pharetra risus suspendisse vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia. Nam elit ante ultricies maximus felis sit amet suscipit sagittis felis.

Default sentence count [4]: 
Default paragraph count
Used when your default mode is paragraphs and you run `lipsum` with no count.

Preview:
Mattis purus tincidunt eu donec vel justo ac quam pulvinar aliquet donec iaculis. Faucibus quis consectetur diam cursus ut aliquet magna quis nisl. Elit sit amet dui consequat hendrerit pellentesque et justo eleifend. Phasellus bibendum id lacus in semper.

Nisl ultrices scelerisque eros porta nec phasellus nec faucibus risus praesent ac. Consectetur adipiscing elit suspendisse et suscipit velit pellentesque quis ultrices enim. Nunc sit amet imperdiet augue at rhoncus nulla nullam et tristique sapien vestibulum.

Dolor curabitur nunc nunc convallis sit amet ornare sit amet porttitor et ipsum vestibulum. Rhoncus mauris orci varius natoque penatibus et magnis. Donec vulputate dictum orci non rhoncus aliquam fermentum lacinia. Varius metus curabitur dapibus sem ut finibus pharetra vivamus vestibulum.

Default paragraph count [3]: 
Default word length range
Controls the character length of generated words when no explicit range is provided.

Preview:
condimentum velit semper egestas vestibulum mollis.

Default word length range [1-12]: 
Default line range
Controls the number of words in each generated line.

Preview:
– in ex gravida dui porta.
– augue nullam eleifend accumsan felis et.
– tempus nulla ante nulla tristique vitae placerat vel.

Default line range [4-8]: 
Default sentence range
Controls the number of words in each generated sentence.

Preview:
faucibus ligula sed pellentesque sodales sapien dui varius elit in laoreet. velit et dictum tincidunt purus nam at consectetur diam nunc sed dui.

Default sentence range [6-14]: 
Default paragraph range
Controls the number of sentences in each generated paragraph.

Preview:
Tristique lacus integer nec dui orci etiam ultrices. Orci eu tristique arcu vestibulum nec lectus turpis. Dictum non vel quam curabitur malesuada et risus a dignissim mauris tempus quam. Elit morbi tristique rhoncus auctor cras id nunc. Porttitor facilisis duis fringilla dui at ornare sodales pellentesque mollis bibendum.

Nulla nec quam faucibus faucibus felis vitae. Dictum maximus dui et euismod nulla. Vestibulum lacus in convallis vitae nisi at auctor proin ornare blandit nunc ac.

Default paragraph range [3-5]: 
Default paragraph sentence word range
Controls the number of words in each sentence inside paragraph output.

Preview:
Metus venenatis eget sed vehicula tellus in ullamcorper pulvinar. Leo nec tristique velit donec orci dui fringilla. Tristique lacus integer nec dui orci. Cubilia curae aliquam vestibulum id tortor at placerat in gravida imperdiet odio sed gravida. A egestas praesent commodo posuere consectetur suspendisse vitae diam libero morbi nec.

Default paragraph sentence word range [6-14]: 
Default bullet character
Used by `lipsum lines -b` when no explicit bullet character is provided.

Preview:
– quam est ac turpis aliquam id lacus eget.
– condimentum rutrum donec faucibus elit dui id.
– fames ac ante ipsum primis in faucibus donec.

Default bullet character [–]: 
Default ordered list format
Used by `lipsum lines -o` when no explicit ordered marker format is provided.

Preview:
1. Leo nec egestas purus sapien et nisi.
2. Congue vestibulum blandit erat sed sollicitudin rhoncus.
3. Vehicula nunc venenatis dui aliquet tristique dictum.

Default ordered list format [%d.]: 
Default format
Choose how generated output is rendered when you do not pass --format explicitly.

Preview:
Aliquam fusce nec risus et dui dapibus.
Donec bibendum accumsan rhoncus ut ultrices.
Litora torquent per conubia nostra per.

Default format [plain] (plain/html/markdown/json/ndjson): 
Copy on generate
When enabled, lipsum copies output to the clipboard and still prints it.

Current default: no

Copy on generate [no] (yes/no): 
Installed lipsum-cli.
Executable: /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.IQaVmRb0yu/.local/bin/lipsum
Config:     /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.IQaVmRb0yu/.lipsum/config
Corpus:     /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.IQaVmRb0yu/.lipsum/words
Sources:    /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.IQaVmRb0yu/.lipsum/sources
Templates:  /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.IQaVmRb0yu/.lipsum/templates

Add /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.IQaVmRb0yu/.local/bin to your PATH to run lipsum directly.
5
```

### TC68 Installer
Editor-config mode creates a config file, validates it, and leaves a working installed executable.

```sh
tmp_home="$(mktemp -d)"; bin_dir="$tmp_home/.local/bin"; EDITOR='true' HOME="$tmp_home" zsh '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./install.sh' --editor-config --bin-dir "$bin_dir" >/tmp/lipsum-installer-editor.out 2>&1; rc=$?; cat /tmp/lipsum-installer-editor.out; test -f "$tmp_home/.lipsum/config" && HOME="$tmp_home" "$bin_dir/lipsum" 3 words -p none -l; verify_rc=$?; rm -rf "$tmp_home" /tmp/lipsum-installer-editor.out; exit $(( rc || verify_rc ))
```

Exit status: 0

```text

Installed lipsum-cli.
Executable: /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.cKzTZe3E7B/.local/bin/lipsum
Config:     /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.cKzTZe3E7B/.lipsum/config
Corpus:     /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.cKzTZe3E7B/.lipsum/words
Sources:    /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.cKzTZe3E7B/.lipsum/sources
Templates:  /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.cKzTZe3E7B/.lipsum/templates

Add /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.cKzTZe3E7B/.local/bin to your PATH to run lipsum directly.
condimentum nec varius.
```

### TC69 Custom Sources
Inline text can be used as a one-off source corpus.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' --text 'alpha beta gamma delta epsilon' 5 words -p none -l | tr ' ' '\n' | awk 'NR==FNR { for (i = 1; i <= NF; i++) seen[$i]=1; next } NF { if (!seen[$1]) bad=1 } END { exit bad }' <(printf 'alpha beta gamma delta epsilon\n') -
```

Exit status: 0

```text
```

### TC70 Custom Sources
A file can provide a one-off source corpus.

```sh
tmp='$(mktemp)'; printf 'maple river lantern harbor velvet canyon' > "$tmp"; out="$('/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' --file "$tmp" 5 words -p none -l | tr ' ' '\n' | awk 'NR==FNR { for (i = 1; i <= NF; i++) seen[$i]=1; next } NF { if (!seen[$1]) bad=1 } END { exit bad }' "$tmp" - 2>&1)"; rc=$?; rm -f "$tmp"; printf '%s\n' "$out"; exit $rc
```

Exit status: 0

```text
```

### TC71 Custom Sources
Stdin can provide a one-off source corpus via --text -.

```sh
printf 'violet cedar ember meadow signal\n' | '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' --text - 5 words -p none -l | tr ' ' '\n' | awk 'NR==FNR { for (i = 1; i <= NF; i++) seen[$i]=1; next } NF { if (!seen[$1]) bad=1 } END { exit bad }' <(printf 'violet cedar ember meadow signal\n') -
```

Exit status: 0

```text
```

### TC72 Custom Sources
Custom input can be saved as a reusable named source.

```sh
tmp_home="$(mktemp -d)"; first="$(HOME="$tmp_home" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' --text 'atlas ember harbor signal twilight' --save-source customdemo 5 words -p none -l)"; second="$(HOME="$tmp_home" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' --source customdemo 5 words -p none -l)"; printf 'first=%s\nsecond=%s\n' "$first" "$second"; test -f "$tmp_home/.lipsum/sources/customdemo.words"; rc=$?; rm -rf "$tmp_home"; exit $rc
```

Exit status: 0

```text
first=atlas harbor signal harbor ember
second=harbor harbor atlas atlas harbor
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
       [1mlipsum[0m [ options ] [ [1mcount|min-max[0m ] [1mtemplate[0m [1mname[0m
       [1mlipsum[0m [ options ] [1mtemplate[0m [1mname[0m [ [1mcount|min-max[0m ]
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
  [1mtemplate, tpl, tmpl[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List built-in and saved source corpora with samples.
  [1mtemplates, list-templates[0m   List built-in and saved templates with samples.

Options:
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m-f, -F, --format[0m [1mname[0m         Render as [1mplain[0m, [1mhtml[0m, [1mmarkdown[0m, [1mjson[0m, or [1mndjson[0m.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-p, -P, --punctuation[0m [ mode ]
                               Set punctuation handling: [1mperiod[0m, [1mend[0m, [1mall[0m, [1mnone[0m
                               Bare [1m-p[0m defaults to [1mall[0m
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
  [1mlipsum[0m 140 characters -e -p none
  [1mlipsum[0m 18 words -e -s tech
  [1mlipsum[0m 12 words -p all
  [1mlipsum[0m 4 lines -f html
  [1mlipsum[0m 3 paragraphs -f json
  [1mlipsum[0m template notification 4
  [1mlipsum[0m 3 template conventional-commit -p none
  [1mlipsum[0m templates
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
       [1mlipsum[0m [ options ] [ [1mcount|min-max[0m ] [1mtemplate[0m [1mname[0m
       [1mlipsum[0m [ options ] [1mtemplate[0m [1mname[0m [ [1mcount|min-max[0m ]
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
  [1mtemplate, tpl, tmpl[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List built-in and saved source corpora with samples.
  [1mtemplates, list-templates[0m   List built-in and saved templates with samples.

Options:
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m-f, -F, --format[0m [1mname[0m         Render as [1mplain[0m, [1mhtml[0m, [1mmarkdown[0m, [1mjson[0m, or [1mndjson[0m.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-p, -P, --punctuation[0m [ mode ]
                               Set punctuation handling: [1mperiod[0m, [1mend[0m, [1mall[0m, [1mnone[0m
                               Bare [1m-p[0m defaults to [1mall[0m
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
  [1mlipsum[0m 140 characters -e -p none
  [1mlipsum[0m 18 words -e -s tech
  [1mlipsum[0m 12 words -p all
  [1mlipsum[0m 4 lines -f html
  [1mlipsum[0m 3 paragraphs -f json
  [1mlipsum[0m template notification 4
  [1mlipsum[0m 3 template conventional-commit -p none
  [1mlipsum[0m templates
  [1mlipsum[0m sources
  [1mlipsum[0m 3 sentences -c
  [1mlipsum[0m config
```

### TC75 Emoji
Explicit emoji mode mixes weighted emoji into word output without changing the requested word count.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "emoji_charset='😀 😀 😀'\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/emoji-config.zsh'; out="$(LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/emoji-config.zsh' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 40 words -e -p none -l)"; printf '%s\n' "$out"; printf '%s\n' "$out" | grep -F '😀' >/dev/null && printf '%s\n' "$out" | awk '{ print NF; if (NF != 40) exit 1 }'
```

Exit status: 0

```text
duis venenatis consectetur bibendum magna a non eget in mattis nisi tincidunt ut lobortis magna odio lacus congue pretium faucibus ante in bibendum in vitae nullam iaculis velit integer eget nec urna phasellus vestibulum quisque sit 😀 😀 accumsan phasellus
40
```

### TC76 Emoji
Config-driven emoji defaults can be disabled for one invocation with --no-emoji.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "emoji_enabled=1\nemoji_charset='😀 😀 😀'\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/emoji-default-config.zsh'; out="$(LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/emoji-default-config.zsh' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 40 words --no-emoji -p none -l)"; printf '%s\n' "$out"; ! printf '%s\n' "$out" | grep -F '😀' >/dev/null && printf '%s\n' "$out" | awk '{ print NF; if (NF != 40) exit 1 }'
```

Exit status: 0

```text
integer morbi turpis praesent arcu ut nunc feugiat libero enim ligula vulputate habitant ac a porta eros ultricies vitae arcu gravida ut morbi nascetur orci ac lacus consequat tortor ultrices purus tempor metus elit suscipit pulvinar justo praesent curae ac
40
```

### TC77 Emoji
Character mode can append sparse emoji while keeping output visually message-like.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "emoji_charset='😀 😀 😀'\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/emoji-char-config.zsh'; out="$(LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/emoji-char-config.zsh' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 140 characters -e -p none)"; printf '%s\n' "$out"; printf '%s\n' "$out" | grep -F '😀' >/dev/null
```

Exit status: 0

```text
Amet rhoncus tincidunt aliquam erat volutpat ut dignissim magna eget nulla ornare ornare suspendisse eget nisi massa proin in vehicula magn 😀
```

### TC78 Emoji
Full stops stay attached to the text when character output ends with trailing emoji.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "emoji_charset='😀 😀 😀'\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/emoji-punctuation-config.zsh'; out="$(LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/emoji-punctuation-config.zsh' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 140 characters -e -l)"; printf '%s\n' "$out"; printf '%s\n' "$out" | grep -Eq '\. 😀$'
```

Exit status: 0

```text
diet elementum tempus nulla ante nulla tristique vitae placerat vel cursus nec tortor nullam fringilla tempor arcu a malesuada lacus vivamu. 😀
```

