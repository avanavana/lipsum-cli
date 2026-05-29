# lipsum Test Plan And Results

Generated: 2026-05-29 16:41:53 EDT

Scripts under test:
- [/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum](/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum)
- [/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsumize](/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsumize)
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
- Companion source importing with `lipsumize`.
- Ad hoc source input from text, files, stdin, and saved custom sources.
- Case formatting: lowercase, uppercase, and title case.
- Output renderers: plain, html, markdown, json, and ndjson.
- Emoji mixing in explicit, config-driven, and override flows.
- Bullets and ordered lists.
- Saved templates, template scaffolding commands, and template-specific rendering flows.
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
- TC03D Metadata: The companion lipsumize script syntax-checks cleanly.
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
- TC86 Templates: Template scaffolding creates a new starter template in the user template directory.
- TC86A Templates: Template edit can create or reseed a template from an example file.
- TC87 Templates: A template can be seeded from an example file and then rendered with a top-level count.
- TC87A Templates: Nested concat() and opt() expressions work in templates with explicit probabilities.
- TC87B Templates: opt() can omit content completely with a zero probability.
- TC87C Templates: Templates can declare variables and reuse them inside optional nested expressions.
- TC87D Templates: Declared template variables respect opt() probabilities when referenced indirectly.
- TC88 Templates: The templates action lists saved templates and includes sample output.
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
- TC61 Sources: The sources action separates built-in and saved flavors and includes sample paragraphs.
- TC62 Sources: The long source option selects a named source corpus for one invocation.
- TC63 Sources: The short source option selects another named source corpus.
- TC64 Sources: Config can change the default source for bare and explicit generation.
- TC64A Sources: A specific flavor can be inspected through the sources action.
- TC64B Sources: An imported source can be renamed through the sources action.
- TC64C Sources: A source can be set as the default through the sources action.
- TC64D Sources: Deleting a source asks for confirmation and removes the imported source.
- TC64E Errors: Built-in sources cannot be deleted through the sources action.
- TC64F Lipsumize: A plain text file can be imported into a reusable source corpus.
- TC64G Lipsumize: A local HTML file can be stripped into a reusable source corpus.
- TC64H Lipsumize: A URL can be imported into a reusable source corpus.
- TC64I Errors: Reserved built-in source names are rejected by lipsumize.
- TC65 Installer: Installer syntax checks cleanly.
- TC66 Installer: Defaults mode installs both executables, config, corpora, and support directories into a temp HOME.
- TC67 Installer: Interactive mode accepts step-by-step input and can change the default mode before installation.
- TC68 Installer: Editor-config mode creates a config file, validates it, and leaves both executables working.
- TC69 Custom Sources: Inline text can be used as a one-off source corpus.
- TC70 Custom Sources: A file can provide a one-off source corpus.
- TC71 Custom Sources: Stdin can provide a one-off source corpus via --text -.
- TC72 Custom Sources: Custom input can be saved as a reusable named source.
- TC73 Errors: Custom source input and named source selection cannot be combined.
- TC74 Errors: Saving a source without custom input fails cleanly.
- TC75 Emoji: Explicit emoji mode mixes weighted emoji into word output without changing the requested word count.
- TC76 Emoji: Config-driven emoji defaults can be disabled for one invocation with --no-emoji.
- TC77 Emoji: Character mode can append sparse emoji while keeping output visually message-like.
- TC77A Emoji: Character mode always includes emoji when --emoji is enabled.
- TC77B Emoji: An explicit emoji probability argument is accepted and can force visible emoji output.
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
  [1mtemplate, tpl, tmpl[0m      Render a named template, or use [1mtemplate new|edit[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List lipsum flavors, inspect one flavor, or manage saved flavors.
  [1mtemplates, list-templates[0m   List saved templates with samples.

Options:
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a lipsum flavor such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the flavor source.
  [1m--file[0m [1mpath[0m             Use a file's contents as the flavor source for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable lipsum flavor.
  [1m--from[0m [1mpath[0m             Seed a template from an example file with [1mtemplate new|edit[0m.
  [1m-f, -F, --format[0m [1mname[0m         Render as [1mplain[0m, [1mhtml[0m, [1mmarkdown[0m, [1mjson[0m, or [1mndjson[0m.
  [1m-b, -B, --bullets[0m [ char ]   Prefix each generated line with [1mchar[0m (default: '–').
  [1m-o, -O, --ordered-list[0m [ fmt ]
                               Prefix each generated line with an ordered marker.
                               Default format: [1m%d.[0m
  [1m-p, -P, --punctuation[0m [ mode ]
                               Set punctuation handling: [1mperiod[0m, [1mend[0m, [1mall[0m, [1mnone[0m
                               Bare [1m-p[0m defaults to [1mall[0m
  [1m-e, -E, --emoji[0m [ 0.0-1.0 ]  Mix emoji into generated output.
                               Default emoji density is [1m0.5[0m
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
  [1mlipsum[0m sources --names
  [1mlipsum[0m --source hipster 8 words
  [1mlipsum[0m --text 'alpha beta gamma delta' 3 words
  [1mlipsum[0m --file ./notes.txt 2 paragraphs
  [1mcurl -fsSL https://example.com | lipsum[0m --text - --save-source example-site 5 lines
  [1mlipsum[0m 140 characters --emoji 1.0 -p none
  [1mlipsum[0m 18 words -e -s tech
  [1mlipsum[0m 12 words -p all
  [1mlipsum[0m 4 lines -f html
  [1mlipsum[0m 3 paragraphs -f json
  [1mlipsum[0m template new conventional-commit
  [1mlipsum[0m template new blog-post --from examples/templates/blog-post.tpl
  [1mlipsum[0m 3 template blog-post -p none
  [1mlipsum[0m templates
  [1mlipsum[0m sources
  [1mlipsum[0m sources corporate
  [1mlipsum[0m sources customdemo --rename renamed-demo
  [1mlipsum[0m sources customdemo --set-default
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

### TC03D Metadata
The companion lipsumize script syntax-checks cleanly.

```sh
zsh -n '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsumize'
```

Exit status: 0

```text
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
Ultrices consectetur augue libero diam lobortis ac ante curabitur vestibulum.
```

### TC05 Defaults
A bare numeric argument is treated as a default word count.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 6
```

Exit status: 0

```text
Consectetur quam sed turpis duis ut.
```

### TC06 Words
Count before mode works for exact word counts.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 2 words
```

Exit status: 0

```text
Eget justo.
```

### TC07 Words
Mode before count still works for exact word counts.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' words 2
```

Exit status: 0

```text
Porttitor vivamus.
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
3
```

### TC10 Words
Word ranges filter word length in characters.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 5 words -r 3-4 -p none -l | awk '{ for (i = 1; i <= NF; i++) { if (length($i) < 3 || length($i) > 4) bad=1 } } END { print NF; if (bad) exit 1 }'
```

Exit status: 1

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
Orem quis elementum metus sed eget ultricies mi ac rutrum lacus cras ac nisl dictum maximus dui et e.
```

### TC12 Characters
Character count ranges resolve to a random exact count.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 24-30 characters -p none -l | tr -d '\n' | wc -m | awk '{ print $1; if ($1 < 24 || $1 > 30) exit 1 }'
```

Exit status: 0

```text
25
```

### TC13 Characters
Internal range is ignored for characters.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 20 characters -r 3-4 -p none | tr -d '\n' | wc -m | awk '{ print $1; if ($1 != 20) exit 1 }'
```

Exit status: 1

```text
21
```

### TC14 Lines
Typical website bullet use case uses shorter default line lengths.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 5 lines -b
```

Exit status: 0

```text
– Eget ultricies mi ac rutrum lacus.
– Ac ante ipsum primis.
– Ac velit ac semper dictum enim donec laoreet.
– Risus praesent ac dictum.
– Aliquam dui nec hendrerit.
```

### TC15 Lines
Random top-level line counts and internal line lengths both work together.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4-6 lines -r 6-10 | awk '{ print NF; if (NF < 6 || NF > 10) bad=1 } END { if (NR < 4 || NR > 6 || bad) exit 1 }'
```

Exit status: 0

```text
9
10
8
7
8
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
Malesuada felis congue at praesent orci nisi sodales nec neque quis dignissim fringilla elit. Erat et commodo nam elit ante ultricies maximus felis.
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
5
```

### TC19 Paragraphs
Default paragraphs mode emits multiple paragraphs with blank-line separation.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 2 paragraphs
```

Exit status: 0

```text
Dapibus fusce pharetra quis nibh a suscipit donec velit ante. Mauris phasellus consequat leo tristique ante placerat cursus pellentesque. Enim aenean elementum tristique dignissim sed. Amet porttitor et ipsum vestibulum ultrices enim sed ipsum tristique imperdiet donec sollicitudin justo. Tempor vel nisi sed eget aliquet libero interdum et malesuada fames.

Dolor ultrices ut suscipit volutpat scelerisque et augue suspendisse. Ornare et in sit amet odio eget urna volutpat elementum at. Elit mauris quis mauris turpis duis maximus finibus orci. Enim auctor integer suscipit felis ullamcorper porta fringilla elit nunc suscipit leo nec. Nibh a suscipit donec velit ante facilisis a leo vitae tincidunt accumsan felis.
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

Exit status: 1

```text
11
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
2
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
velit et id vitae.
```

### TC26 Case
Uppercase output works.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4 words -p none -u
```

Exit status: 0

```text
DOLOR TINCIDUNT ELIT IN.
```

### TC27 Case
Title case output works.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4 words -p none -t
```

Exit status: 0

```text
Magna Lectus A Consectetur.
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

Exit status: 1

```text
```

### TC81 Punctuation
None punctuation mode removes terminal punctuation entirely.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 8 words -p none -l | grep -Ev '[.!?]$'
```

Exit status: 1

```text
```

### TC82 Formats
HTML formatting wraps line output as list markup.

```sh
out="$('/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 3 lines -f html)"; printf '%s\n' "$out"; printf '%s\n' "$out" | grep -F '<ul>' >/dev/null && printf '%s\n' "$out" | grep -F '<li>' >/dev/null && printf '%s\n' "$out" | grep -F '</ul>' >/dev/null
```

Exit status: 0

```text
<ul>
  <li>Id aliquam vulputate ligula odio tincidunt nisl at.</li>
  <li>Urna non varius commodo.</li>
  <li>Lobortis ligula purus mattis dapibus lacus feugiat.</li>
</ul>
```

### TC83 Formats
Markdown formatting turns unprefixed lines into a markdown list.

```sh
out="$('/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 3 lines -f markdown -p none -l)"; printf '%s\n' "$out"; printf '%s\n' "$out" | awk '/^- / { count++ } END { if (count != 3) exit 1 }'
```

Exit status: 0

```text
- turpis lectus vel leo cras non ligula elementum.
- ex congue a mauris.
- proin pharetra ligula leo.
```

### TC84 Formats
JSON formatting returns an array for paragraph output.

```sh
out="$('/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 2 paragraphs -f json)"; printf '%s\n' "$out"; printf '%s\n' "$out" | grep -Eq '^\[ ".*", ".*" \]$'
```

Exit status: 0

```text
[ "Hendrerit massa pharetra eu donec est elit pulvinar sed. Aliquet arcu sem eu laoreet velit blandit sed phasellus. Non pharetra erat vivamus ut felis vitae orci. Id velit condimentum cursus ut vehicula aliquet purus non.", "Quis viverra nisl praesent at tempor elit vitae semper orci nunc. Eu turpis ac nibh scelerisque ultrices vitae. Justo lobortis et duis venenatis diam lectus ut varius libero placerat non suspendisse. Velit pulvinar vulputate etiam consequat bibendum dolor quisque vitae ante tristique suscipit." ]
```

### TC85 Formats
NDJSON formatting emits one JSON string per requested word.

```sh
out="$('/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4 words -f ndjson -p none -l)"; printf '%s\n' "$out"; printf '%s\n' "$out" | awk '/^".*"$/ { count++ } END { if (count != 4) exit 1 }'
```

Exit status: 0

```text
"faucibus"
"rhoncus"
"tempus"
"magna."
```

### TC86 Templates
Template scaffolding creates a new starter template in the user template directory.

```sh
tmp_home="$(mktemp -d)"; out="$(HOME="$tmp_home" VISUAL=true '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' template new starter-demo)"; rc=$?; printf '%s\n' "$out"; test -f "$tmp_home/.lipsum/templates/starter-demo.tpl" && grep -F '# title: Starter Demo' "$tmp_home/.lipsum/templates/starter-demo.tpl" >/dev/null; verify_rc=$?; rm -rf "$tmp_home"; exit $(( rc || verify_rc ))
```

Exit status: 0

```text
Saved template as [1mstarter-demo[0m.
```

### TC86A Templates
Template edit can create or reseed a template from an example file.

```sh
tmp_home="$(mktemp -d)"; out="$(HOME="$tmp_home" VISUAL=true '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' template edit seeded-post --from '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./examples/templates/blog-post.tpl')"; rc=$?; printf '%s\n' "$out"; test -f "$tmp_home/.lipsum/templates/seeded-post.tpl" && grep -F '# title: Blog Post' "$tmp_home/.lipsum/templates/seeded-post.tpl" >/dev/null; verify_rc=$?; rm -rf "$tmp_home"; exit $(( rc || verify_rc ))
```

Exit status: 0

```text
Saved template as [1mseeded-post[0m.
```

### TC87 Templates
A template can be seeded from an example file and then rendered with a top-level count.

```sh
tmp_home="$(mktemp -d)"; HOME="$tmp_home" VISUAL=true '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' template new conventional-commit --from '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./examples/templates/conventional-commit.tpl' >/dev/null && out="$(HOME="$tmp_home" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 3 template conventional-commit -p none)"; rc=$?; printf '%s\n' "$out"; printf '%s\n' "$out" | awk 'END { print NR; if (NR != 3) exit 1 }'; verify_rc=$?; rm -rf "$tmp_home"; exit $(( rc || verify_rc ))
```

Exit status: 0

```text
chore: amet elit ornare efficitur
fix(ipsum): eu consectetur leo sed accumsan
fix: placerat vestibulum aliquet faucibus elit blandit
3
```

### TC87A Templates
Nested concat() and opt() expressions work in templates with explicit probabilities.

```sh
tmp_home="$(mktemp -d)"; mkdir -p "$tmp_home/.lipsum/templates"; printf '# title: Optional Scope\n{{choice(feat|fix)}}{{opt(concat("(", choice(alpha|beta|gamma), ")"), 1.0)}}: {{words(3)}}\n' > "$tmp_home/.lipsum/templates/optional-scope.tpl"; out="$(HOME="$tmp_home" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' template optional-scope -p none -l)"; printf '%s\n' "$out"; printf '%s\n' "$out" | grep -Eq '^(feat|fix)\((alpha|beta|gamma)\): [a-z]+ [a-z]+ [a-z]+$'; rc=$?; rm -rf "$tmp_home"; exit $rc
```

Exit status: 0

```text
feat(beta): nulla nec urna
```

### TC87B Templates
opt() can omit content completely with a zero probability.

```sh
tmp_home="$(mktemp -d)"; mkdir -p "$tmp_home/.lipsum/templates"; printf '# title: Optional Scope\n{{choice(feat|fix)}}{{opt(concat("(", choice(alpha|beta|gamma), ")"), 0)}}: {{words(3)}}\n' > "$tmp_home/.lipsum/templates/optional-scope.tpl"; out="$(HOME="$tmp_home" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' template optional-scope -p none -l)"; printf '%s\n' "$out"; ! printf '%s\n' "$out" | grep -q '(' && printf '%s\n' "$out" | grep -Eq '^(feat|fix): [a-z]+ [a-z]+ [a-z]+$'; rc=$?; rm -rf "$tmp_home"; exit $rc
```

Exit status: 1

```text
fix(alpha): arcu rutrum et
```

### TC87C Templates
Templates can declare variables and reuse them inside optional nested expressions.

```sh
tmp_home="$(mktemp -d)"; mkdir -p "$tmp_home/.lipsum/templates"; printf '# title: Variable Scope\n$type = choice(feat|fix)\n$scope = concat("(", choice(alpha|beta|gamma), ")")\n\n{{$type}}{{opt($scope, 1.0)}}: {{words(3)}}\n' > "$tmp_home/.lipsum/templates/variable-scope.tpl"; out="$(HOME="$tmp_home" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' template variable-scope -p none -l)"; printf '%s\n' "$out"; printf '%s\n' "$out" | grep -Eq '^(feat|fix)\((alpha|beta|gamma)\): [a-z]+ [a-z]+ [a-z]+$'; rc=$?; rm -rf "$tmp_home"; exit $rc
```

Exit status: 1

```text
fix: molestie risus in
```

### TC87D Templates
Declared template variables respect opt() probabilities when referenced indirectly.

```sh
tmp_home="$(mktemp -d)"; mkdir -p "$tmp_home/.lipsum/templates"; printf '# title: Variable Scope\n$type = choice(feat|fix)\n$scope = concat("(", choice(alpha|beta|gamma), ")")\n\n{{$type}}{{opt($scope, 0)}}: {{words(3)}}\n' > "$tmp_home/.lipsum/templates/variable-scope.tpl"; out="$(HOME="$tmp_home" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' template variable-scope -p none -l)"; printf '%s\n' "$out"; ! printf '%s\n' "$out" | grep -q '(' && printf '%s\n' "$out" | grep -Eq '^(feat|fix): [a-z]+ [a-z]+ [a-z]+$'; rc=$?; rm -rf "$tmp_home"; exit $rc
```

Exit status: 0

```text
feat: eget pretium justo
```

### TC88 Templates
The templates action lists saved templates and includes sample output.

```sh
tmp_home="$(mktemp -d)"; mkdir -p "$tmp_home/.lipsum/templates"; printf '# title: Custom Ticket\nticket-{{number(100-999)}} {{choice(alpha|beta|gamma)}}\n' > "$tmp_home/.lipsum/templates/custom-ticket.tpl"; out="$(HOME="$tmp_home" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' templates)"; printf '%s\n' "$out"; printf '%s\n' "$out" | grep -F 'Available Templates' >/dev/null && printf '%s\n' "$out" | grep -F 'Saved Templates:' >/dev/null && printf '%s\n' "$out" | grep -F 'Custom Ticket (custom-ticket)' >/dev/null; rc=$?; rm -rf "$tmp_home"; exit $rc
```

Exit status: 0

```text
Available Templates

Saved Templates:
- Custom Ticket (custom-ticket)
  ticket-395 gamma
```

### TC89 Templates
A custom template can be rendered from the user template directory.

```sh
tmp_home="$(mktemp -d)"; mkdir -p "$tmp_home/.lipsum/templates"; printf '# title: Ticket\nticket-{{number(100-999)}} {{choice(alpha|beta|gamma)}}\n' > "$tmp_home/.lipsum/templates/ticket.tpl"; out="$(HOME="$tmp_home" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' template ticket -p none)"; printf '%s\n' "$out"; printf '%s\n' "$out" | grep -Eq '^ticket-[0-9]{3} (alpha|beta|gamma)$'; rc=$?; rm -rf "$tmp_home"; exit $rc
```

Exit status: 0

```text
ticket-829 gamma
```

### TC90 Templates
Templates also render cleanly through JSON output formatting.

```sh
tmp_home="$(mktemp -d)"; HOME="$tmp_home" VISUAL=true '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' template new blog-post --from '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./examples/templates/blog-post.tpl' >/dev/null && out="$(HOME="$tmp_home" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 2 template blog-post -f json)"; rc=$?; printf '%s\n' "$out"; printf '%s\n' "$out" | grep -Eq '^\[ ".+", ".+" \]$'; verify_rc=$?; rm -rf "$tmp_home"; exit $(( rc || verify_rc ))
```

Exit status: 0

```text
[ "Blandit lacus eu lobortis arcu sed auctor dolor.\nBy orci molestie\n\nMetus eu maximus eleifend enim augue imperdiet odio ut consectetur nulla purus vitae orci phasellus.", "Bibendum lacus eget consectetur nibh.\nBy facilisis nunc\n\nEfficitur donec sed dui a metus pharetra condimentum sed consectetur metus eu maximus eleifend enim augue imperdiet." ]
```

### TC91 Config
Config can set the default output format for bare invocations.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "default_mode='lines'\ndefault_line_count=2\ndefault_line_range='2-2'\ndefault_format='json'\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/format-config.zsh'; out="$(LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/format-config.zsh' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' -p none -l)"; printf '%s\n' "$out"; printf '%s\n' "$out" | grep -Eq '^\[ ".+", ".+" \]$'
```

Exit status: 0

```text
[ "auctor sapien", "et eros" ]
```

### TC28 Ordered Lists
Default ordered lists use numeric markers.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 3 lines -o
```

Exit status: 0

```text
1. Eu turpis ac nibh scelerisque ultrices vitae.
2. Viverra lacinia eget ut leo nam ultrices.
3. Metus tristique at interdum sit.
```

### TC29 Ordered Lists
Ordered list formulas support alphabetic markers.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4 lines -o '(%A)'
```

Exit status: 0

```text
(A) Finibus lacinia justo vel commodo nulla feugiat urna.
(B) Ac semper dictum enim donec.
(C) Ante ornare eros non.
(D) Nulla facilisi vestibulum eget blandit.
```

### TC30 Ordered Lists
Ordered list formulas support zero-padded zero-indexed digits.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 3 lines -o '%00z)'
```

Exit status: 0

```text
000) Bibendum velit non pharetra erat.
001) Sodales fringilla eros in auctor.
002) Nunc ac porta praesent vitae auctor sapien ac.
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
[1mCopied to clipboard.[0m
stdout=aliquet elementum amet lacinia.
clipboard=aliquet elementum amet lacinia.
```

### TC38 Copy
Config can enable copy by default.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "copy_on_generate=1\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/copy-config.zsh'; rm -f '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/clipboard-config.txt'; out="$(LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/copy-config.zsh' LIPSUM_CLIPBOARD_COMMAND="sh -c 'cat > \"\$1\"' _ '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/clipboard-config.txt'" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4 w -p none -l)"; clip="$(cat '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/clipboard-config.txt')"; printf 'stdout=%s\nclipboard=%s\n' "$out" "$clip"; [[ "$out" == "$clip" ]]
```

Exit status: 0

```text
[1mCopied to clipboard.[0m
stdout=metus porttitor etiam elit
clipboard=metus porttitor etiam elit
```

### TC39 Copy
Explicit no-copy overrides config-driven clipboard copying.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "copy_on_generate=1\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/no-copy-config.zsh'; rm -f '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/clipboard-no-copy.txt'; out="$(LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/no-copy-config.zsh' LIPSUM_CLIPBOARD_COMMAND="sh -c 'cat > \"\$1\"' _ '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/clipboard-no-copy.txt'" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4 w --no-copy -p none -l)"; printf 'stdout=%s\nclipboard_exists=%s\n' "$out" "$(test -e '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/clipboard-no-copy.txt'; echo $?)"; [[ ! -e '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/clipboard-no-copy.txt' ]]
```

Exit status: 0

```text
stdout=non at at quis
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
```

### TC41 Errors
Removed long mode flags are rejected.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' --words=7
```

Exit status: 1

```text
Error: Illegal option --words=7
```

### TC42 Errors
Removed short mode flags are rejected.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' -w 7
```

Exit status: 1

```text
Error: Illegal option -w
```

### TC43 Errors
Invalid internal range syntax is rejected.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 2 lines -r abc
```

Exit status: 1

```text
Error: Invalid length range: abc
```

### TC44 Errors
A reversed internal range is rejected.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 1 s --range 10-5
```

Exit status: 1

```text
Error: length range minimum cannot be greater than maximum
```

### TC45 Errors
Zero counts are rejected.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 0 words
```

Exit status: 1

```text
Error: count values must be greater than zero
```

### TC46 Errors
Multiple counts are rejected.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 2 3 words
```

Exit status: 1

```text
Error: Multiple counts specified
```

### TC47 Errors
Multiple commands are rejected.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' words lines
```

Exit status: 1

```text
Error: Multiple commands specified
```

### TC48 Errors
Ordered lists are rejected for non-line modes.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 5 words -o
```

Exit status: 1

```text
Error: --ordered-list is only valid with lines
```

### TC49 Errors
Bullets and ordered lists cannot be combined.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 3 lines -b -o
```

Exit status: 1

```text
Error: Use either bullets or ordered-list, not both
```

### TC50 Errors
Unknown command names fail cleanly.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' banana
```

Exit status: 1

```text
Error: Unknown argument: banana
```

### TC51 Errors
Oversized character requests hit the configured safety cap.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 250000 c
```

Exit status: 1

```text
Error: Character count capped at 200000. Set LIPSUM_MAX_CHARACTERS to raise it.
```

### TC52 Errors
Invalid config values fail cleanly on the next run.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "default_line_range='9-2'\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/bad-config.zsh'; LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/bad-config.zsh' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 1 lines
```

Exit status: 1

```text
Error: default_line_range range minimum cannot be greater than maximum
```

### TC53 Shell Integration
A for-loop can generate progressively longer exact bullet lines.

```sh
for n in 3 4 5; do '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 1 l -r "$n" -b; done
```

Exit status: 0

```text
– Sed mollis neque.
– Dictum mollis ut scelerisque.
– Quam a sapien eleifend rutrum.
```

### TC54 Shell Integration
Piped numeric input can drive sentence generation through a while-read loop.

```sh
printf '4\n6\n' | while read -r n; do '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 1 s -r "$n" -l; done
```

Exit status: 0

```text
ut iaculis tincidunt ligula.
et ultrices posuere cubilia curae sed.
```

### TC55 Shell Integration
Piped numeric input can drive line generation through xargs.

```sh
printf '3\n5\n' | xargs -I{} zsh -c "'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 1 lines -r \"\$1\" -b" _ {}
```

Exit status: 0

```text
– Eu pellentesque id.
– At lectus maecenas dictum rhoncus.
```

### TC56 Shell Integration
Command substitution can inline generated text inside another command.

```sh
printf '[%s]\n' "$('/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4 w -p none -l)"
```

Exit status: 0

```text
[orci neque porta et.]
```

### TC57 Shell Integration
Direct stdin piping into lipsum is harmless and the command still produces stdout.

```sh
printf 'stdin is ignored here\n' | '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 5 w
```

Exit status: 0

```text
Consectetur ultrices ornare mauris nec.
```

### TC58 Shell Integration
Paragraph output can be piped into fold for visual wrapping.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 1 p | fold -s -w 40
```

Exit status: 0

```text
Habitant morbi tristique senectus et 
netus et malesuada fames ac turpis 
egestas proin. Donec finibus sem eget 
nunc ultrices a. Sed condimentum 
scelerisque morbi est ipsum tincidunt 
quis est nec pretium mollis ex aliquam. 
Tempor ac ornare eget tincidunt maximus 
ante duis tincidunt pharetra.
```

### TC59 Shell Integration
Bullet output can be piped into line numbering for visual review.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4 l -b | nl -ba
```

Exit status: 0

```text
     1	– Elit quisque ac arcu ut ex.
     2	– Amet mauris iaculis suscipit curabitur iaculis vel.
     3	– Suspendisse et suscipit velit.
     4	– Tristique ut proin ac mauris.
```

### TC60 Shell Integration
Word output can be piped into newline transforms for tokenized display.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 8 w -p none -l | tr ' ' '\n'
```

Exit status: 0

```text
dolor
nascetur
mauris
diam
justo
condimentum
phasellus
et.
```

### TC61 Sources
The sources action separates built-in and saved flavors and includes sample paragraphs.

```sh
tmp_home="$(mktemp -d)"; mkdir -p "$tmp_home/.lipsum/sources"; cp '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./share/sources/'*.words "$tmp_home/.lipsum/sources/"; printf 'atlas ember harbor signal twilight\n' > "$tmp_home/.lipsum/sources/custom-demo.words"; out="$(HOME="$tmp_home" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' sources)"; printf '%s\n' "$out"; printf '%s\n' "$out" | grep -F 'Built-In Flavors:' >/dev/null && printf '%s\n' "$out" | grep -F 'Saved Flavors:' >/dev/null && printf '%s\n' "$out" | grep -F 'Lorem Ipsum (lorem) [default]' >/dev/null && printf '%s\n' "$out" | grep -F 'Tech Ipsum (tech)' >/dev/null && printf '%s\n' "$out" | grep -F 'Corporate Ipsum (corporate)' >/dev/null && printf '%s\n' "$out" | grep -F 'Custom Demo (custom-demo)' >/dev/null; rc=$?; rm -rf "$tmp_home"; exit $rc
```

Exit status: 0

```text
Available Flavors

Built-In Flavors:
- Lorem Ipsum (lorem) [default]
  Dapibus tristique in hac habitasse platea dictumst integer nec augue suscipit. Malesuada vitae dolor mauris condimentum gravida nulla ut.

- Hipster Ipsum (hipster)
  Cardigan pickled microbatch cloud bread enamel pin messenger bag. Truffaut occupy banjo mumblecore wayfarers pabst scenester.

- Tech Ipsum (tech)
  Rollback cluster container webhook token feature flag telemetry dashboard. Observability refactor incident status page dependency changelog.

- Pirate Ipsum (pirate)
  Wake trail moon tide black flag storm cloud port call harbor. Signal flare tidepool saltwater shipshape weathered plank rope ladder harbor market.

- Food Ipsum (food)
  Saffron cardamom clove ginger sesame olive butter cream. Chargrilled braise caramel whisk fold reduce drizzle garnish plated porcelain linen.

- Corporate Ipsum (corporate)
  Review stakeholder map operating principle measurable outcome customer signal workflow streamlining. Facilitator summary synthesis memo executive alignment continuous.

- Spanish Ipsum (es)
  Viento semilla fruto tarde manana noche estrella luna sol lluvia. Silencio plaza calle puente aroma madera viento semilla fruto tarde manana.

- French Ipsum (fr)
  Temps couleur parole chanson terre mer desir memoire flamme. Regard temps couleur parole chanson terre mer desir memoire flamme.

- German Ipsum (de)
  Horizont kuche terrasse allee notiz heiterkeit morgen abend blatt. Mehl hof balkon lampe geschichte zuflucht stoff.

Saved Flavors:
- Custom Demo (custom-demo)
  Atlas ember harbor signal twilight atlas ember harbor signal twilight. Atlas ember harbor signal twilight atlas ember harbor signal twilight signal.

Default flavor: lorem
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

### TC64A Sources
A specific flavor can be inspected through the sources action.

```sh
out="$(HOME="$(mktemp -d)" LIPSUM_SOURCE_DIR='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./share/sources' LIPSUM_DICT='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./share/lorem.words' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' sources corporate)"; printf '%s\n' "$out"; printf '%s\n' "$out" | grep -F 'Flavor Details' >/dev/null && printf '%s\n' "$out" | grep -F 'Title: Corporate Ipsum' >/dev/null && printf '%s\n' "$out" | grep -F 'Slug: corporate' >/dev/null && printf '%s\n' "$out" | grep -F 'Type: built-in' >/dev/null && printf '%s\n' "$out" | grep -F 'Sample:' >/dev/null
```

Exit status: 0

```text
Flavor Details

Title: Corporate Ipsum
Slug: corporate
Type: built-in
Path: /Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./share/sources/corporate.words
Default: no
Word count: 151

Sample:
Synthesis adoption enablement benchmark baseline scenario planning. Evidence insight recommendation dependency unblock timeline checkpoint next step service.
```

### TC64B Sources
An imported source can be renamed through the sources action.

```sh
tmp_home="$(mktemp -d)"; mkdir -p "$tmp_home/.lipsum/sources"; printf 'atlas ember harbor signal twilight\n' > "$tmp_home/.lipsum/sources/custom-demo.words"; out="$(HOME="$tmp_home" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' sources custom-demo --rename renamed-demo)"; rc=$?; printf '%s\n' "$out"; test -f "$tmp_home/.lipsum/sources/renamed-demo.words" && test ! -f "$tmp_home/.lipsum/sources/custom-demo.words"; verify_rc=$?; rm -rf "$tmp_home"; exit $(( rc || verify_rc ))
```

Exit status: 0

```text
Renamed flavor custom-demo to renamed-demo
```

### TC64C Sources
A source can be set as the default through the sources action.

```sh
tmp_home="$(mktemp -d)"; mkdir -p "$tmp_home/.lipsum/sources"; printf 'atlas ember harbor signal twilight\n' > "$tmp_home/.lipsum/sources/custom-demo.words"; out="$(HOME="$tmp_home" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' sources custom-demo --set-default)"; rc=$?; printf '%s\n' "$out"; grep -F "default_source='custom-demo'" "$tmp_home/.lipsum/config" >/dev/null; verify_rc=$?; rm -rf "$tmp_home"; exit $(( rc || verify_rc ))
```

Exit status: 0

```text
Default flavor set to custom-demo
```

### TC64D Sources
Deleting a source asks for confirmation and removes the imported source.

```sh
tmp_home="$(mktemp -d)"; mkdir -p "$tmp_home/.lipsum/sources"; printf 'default_source='\''custom-demo'\''\n' > "$tmp_home/.lipsum/config"; printf 'atlas ember harbor signal twilight\n' > "$tmp_home/.lipsum/sources/custom-demo.words"; out="$(printf 'y\n' | HOME="$tmp_home" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' sources custom-demo --delete)"; rc=$?; printf '%s\n' "$out"; test ! -f "$tmp_home/.lipsum/sources/custom-demo.words" && grep -F "default_source='lorem'" "$tmp_home/.lipsum/config" >/dev/null; verify_rc=$?; rm -rf "$tmp_home"; exit $(( rc || verify_rc ))
```

Exit status: 0

```text
Delete flavor 'custom-demo'? [y/N] Deleted flavor custom-demo
```

### TC64E Errors
Built-in sources cannot be deleted through the sources action.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' sources lorem --delete
```

Exit status: 1

```text
Error: Built-in sources cannot be deleted: lorem
```

### TC64F Lipsumize
A plain text file can be imported into a reusable source corpus.

```sh
tmp_home="$(mktemp -d)"; tmp_file="$tmp_home/book.txt"; printf 'maple river lantern harbor velvet canyon\n' > "$tmp_file"; out="$(HOME="$tmp_home" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsumize' bookish "$tmp_file")"; rc=$?; printf '%s\n' "$out"; HOME="$tmp_home" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' --source bookish 5 words -p none -l | tr ' ' '\n' | awk 'NR==FNR { for (i = 1; i <= NF; i++) seen[$i]=1; next } NF { if (!seen[$1]) bad=1 } END { exit bad }' "$tmp_file" -; verify_rc=$?; rm -rf "$tmp_home"; exit $(( rc || verify_rc ))
```

Exit status: 0

```text
Saved as [1mbookish[0m to [1m/var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.xsHYN0zggu/.lipsum/sources/bookish.words[0m
```

### TC64G Lipsumize
A local HTML file can be stripped into a reusable source corpus.

```sh
tmp_home="$(mktemp -d)"; tmp_file="$tmp_home/page.html"; cat > "$tmp_file" <<'EOF'\n<html><body><h1>Atlas Harbor</h1><p>Signal twilight ember meadow.</p><script>ignored words forever</script></body></html>\nEOF\nout="$(HOME="$tmp_home" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsumize' webcopy "$tmp_file")"; rc=$?; printf '%s\n' "$out"; HOME="$tmp_home" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' --source webcopy 5 words -p none -l | tr ' ' '\n' | awk 'NR==FNR { for (i = 1; i <= NF; i++) seen[tolower($i)]=1; next } NF { if (!seen[tolower($1)]) bad=1 } END { exit bad }' <(printf 'Atlas Harbor Signal twilight ember meadow\n') -; verify_rc=$?; rm -rf "$tmp_home"; exit $(( rc || verify_rc ))
```

Exit status: 1

```text
(eval):1: parse error near `<'
```

### TC64H Lipsumize
A URL can be imported into a reusable source corpus.

```sh
tmp_home="$(mktemp -d)"; out="$(HOME="$tmp_home" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsumize' example-site https://example.com)"; rc=$?; printf '%s\n' "$out"; HOME="$tmp_home" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' --source example-site 5 words -p none -l | tr ' ' '\n' | awk 'NR==FNR { for (i = 1; i <= NF; i++) seen[tolower($i)]=1; next } NF { if (!seen[tolower($1)]) bad=1 } END { exit bad }' <(printf 'example domain this domain is for use in documentation examples without needing permission avoid use in operations learn more\n') -; verify_rc=$?; rm -rf "$tmp_home"; exit $(( rc || verify_rc ))
```

Exit status: 0

```text
Saved as [1mexample-site[0m to [1m/var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.5FbSyYMgAd/.lipsum/sources/example-site.words[0m
```

### TC64I Errors
Reserved built-in source names are rejected by lipsumize.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsumize' lorem ./README.md
```

Exit status: 1

```text
Error: Source name is reserved: lorem


Usage: [1mlipsumize[0m [ options ] [1mname[0m [1minput[0m
       [1mlipsumize[0m [ [1m-v/-V/--version[0m ]
       [1mlipsumize[0m [ [1m-h/-H/--help[0m ]

Create or update a reusable lipsum flavor from local text, HTML, EPUB, stdin,
or a URL, then save it under [1m~/.lipsum/sources/[0m for use with [1mlipsum[0m.

Options:
  [1m-f, -F, --force[0m      Overwrite an existing imported source.
  [1m-v, -V, --version[0m    Display the current version.
  [1m-h, -H, --help[0m       Display this help text.

Examples:
  [1mlipsumize[0m bookish ~/Documents/book.txt
  [1mlipsumize[0m startup-copy ./landing-page.html
  [1mlipsumize[0m moby-dick ~/Books/moby-dick.epub
  [1mlipsumize[0m example-site https://www.example.com
  [1mcurl -fsSL https://example.com | lipsumize[0m example-site -
  [1mlipsumize[0m --force example-site https://www.example.com
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
Defaults mode installs both executables, config, corpora, and support directories into a temp HOME.

```sh
tmp_home="$(mktemp -d)"; bin_dir="$tmp_home/.local/bin"; HOME="$tmp_home" zsh '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./install.sh' --yes --bin-dir "$bin_dir" >/tmp/lipsum-installer-defaults.out; rc=$?; cat /tmp/lipsum-installer-defaults.out; test -x "$bin_dir/lipsum" && test -x "$bin_dir/lipsumize" && test -f "$tmp_home/.lipsum/config" && grep -F 'emoji_charset=' "$tmp_home/.lipsum/config" >/dev/null && grep -F "punctuation_mode='period'" "$tmp_home/.lipsum/config" >/dev/null && grep -F "default_format='plain'" "$tmp_home/.lipsum/config" >/dev/null && test -f "$tmp_home/.lipsum/words" && test -f "$tmp_home/.lipsum/sources/lorem.words" && test -f "$tmp_home/.lipsum/sources/hipster.words" && test -f "$tmp_home/.lipsum/sources/tech.words" && test -f "$tmp_home/.lipsum/sources/pirate.words" && test -f "$tmp_home/.lipsum/sources/food.words" && test -f "$tmp_home/.lipsum/sources/corporate.words" && test -f "$tmp_home/.lipsum/sources/de.words" && test -d "$tmp_home/.lipsum/templates" && HOME="$tmp_home" VISUAL=true "$bin_dir/lipsum" template new installed-demo --from '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./examples/templates/conventional-commit.tpl' >/dev/null && printf 'atlas ember harbor signal twilight\n' | HOME="$tmp_home" "$bin_dir/lipsumize" customdemo - >/dev/null && HOME="$tmp_home" "$bin_dir/lipsum" --source customdemo 4 words -p none -l >/dev/null; verify_rc=$?; rm -rf "$tmp_home" /tmp/lipsum-installer-defaults.out; exit $(( rc || verify_rc ))
```

Exit status: 0

```text

Installed lipsum-cli.
Executable:  /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.1qAGd1d1Ta/.local/bin/lipsum
Companion:   /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.1qAGd1d1Ta/.local/bin/lipsumize
Config:      /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.1qAGd1d1Ta/.lipsum/config
Corpus:      /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.1qAGd1d1Ta/.lipsum/words
Sources:     /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.1qAGd1d1Ta/.lipsum/sources
Templates:   /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.1qAGd1d1Ta/.lipsum/templates

Add /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.1qAGd1d1Ta/.local/bin to your PATH to run lipsum and lipsumize directly.
```

### TC67 Installer
Interactive mode accepts step-by-step input and can change the default mode before installation.

```sh
tmp_home="$(mktemp -d)"; bin_dir="$tmp_home/.local/bin"; answers=$(printf 'lines\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n'); out="$(printf '%s' "$answers" | HOME="$tmp_home" zsh '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./install.sh' --interactive --bin-dir "$bin_dir" 2>&1)"; rc=$?; printf '%s\n' "$out"; HOME="$tmp_home" "$bin_dir/lipsum" -b -p none -l | awk '/^./ { count++ } END { print count; if (count != 5) exit 1 }'; verify_rc=$?; test -x "$bin_dir/lipsumize"; tool_rc=$?; rm -rf "$tmp_home"; exit $(( rc || verify_rc || tool_rc ))
```

Exit status: 0

```text

Default mode
This controls what a bare `lipsum` command generates.

Preview:
Sit odio at montes in quam in commodo blandit curae.

Default mode [words] (words/characters/lines/sentences/paragraphs): 
Default source
Choose the source corpus used by default. Available: lorem hipster tech pirate food corporate es fr de.

Preview:
mi augue nec volutpat amet eros.

Default source [lorem]: 
Default word count
Used when your default mode is words and you run `lipsum` with no count.

Preview:
Interdum ante facilisis vel convallis dolor ac vitae sapien libero.

Default word count [10]: 
Default character count
Used when your default mode is characters and you run `lipsum` with no count.

Preview:
S porttitor dolor integer sagitt.

Default character count [32]: 
Default line count
Used when your default mode is lines and you run `lipsum` with no count.

Preview:
– Interdum et malesuada fames.
– Ipsum eget consequat quisque pharetra vitae est.
– Finibus lacinia justo vel commodo nulla feugiat urna.
– Ante ipsum primis in faucibus.
– Sodales aliquam erat volutpat.

Default line count [5]: 
Default sentence count
Used when your default mode is sentences and you run `lipsum` with no count.

Preview:
Mollis phasellus dictum leo luctus quam condimentum sed mollis neque. Tristique sapien vestibulum ante ipsum primis in. Tristique phasellus dui massa bibendum ac erat ac. Metus aliquam et neque non justo lobortis mattis in vel metus.

Default sentence count [4]: 
Default paragraph count
Used when your default mode is paragraphs and you run `lipsum` with no count.

Preview:
Porttitor est duis vel cursus diam sed. Vel ex maximus maximus dui a ultrices ante aliquam erat volutpat fusce tempus. Congue mi eget sem faucibus id. Ex gravida dui porta efficitur in in leo nunc aliquam.

Primis in faucibus nunc lobortis ligula purus mattis dapibus. Faucibus id mattis neque congue vestibulum blandit erat sed sollicitudin. Lectus risus nec tristique metus finibus et nulla mollis ex id suscipit suscipit erat. Molestie semper ante sed aliquam aenean gravida libero ac gravida porta sed tincidunt. Ante eget vulputate in at tortor congue.

Pulvinar maximus orci ipsum viverra magna quis aliquam orci turpis ac justo. Id tincidunt posuere sed luctus nulla ac efficitur pulvinar. Pulvinar a massa tristique tristique morbi luctus lectus purus.

Default paragraph count [3]: 
Default word length range
Controls the character length of generated words when no explicit range is provided.

Preview:
proin bibendum duis bibendum semper eget.

Default word length range [1-12]: 
Default line range
Controls the number of words in each generated line.

Preview:
– mi in fringilla enim eros.
– commodo dictum odio faucibus.
– ac velit quisque viverra justo mi.

Default line range [4-8]: 
Default sentence range
Controls the number of words in each generated sentence.

Preview:
orci dignissim viverra nam ultricies felis eros sed. ut cursus posuere sapien non iaculis erat integer commodo.

Default sentence range [6-14]: 
Default paragraph range
Controls the number of sentences in each generated paragraph.

Preview:
Sit amet diam in cursus varius. Netus et malesuada fames ac turpis egestas sed velit urna. Consequat bibendum dolor quisque vitae ante tristique suscipit lorem a. Sagittis ac fermentum felis placerat nam convallis et lectus eget efficitur donec sed. Etiam dignissim eget eros ac mollis mauris vel nisi ut magna placerat auctor id.

In euismod etiam efficitur elit eget tempus accumsan. Sed at pretium magna ac iaculis diam. Primis in faucibus donec et mattis.

Default paragraph range [3-5]: 
Default paragraph sentence word range
Controls the number of words in each sentence inside paragraph output.

Preview:
Suspendisse bibendum dolor leo vel mattis tellus feugiat quis donec bibendum. Efficitur pretium tincidunt integer tincidunt purus ut nibh placerat vehicula et ac sem duis. Amet risus sed viverra nulla pharetra fringilla massa. Enim sed ipsum tristique imperdiet donec sollicitudin justo a massa. Efficitur curabitur sed ipsum eget nibh.

Default paragraph sentence word range [6-14]: 
Default bullet character
Used by `lipsum lines -b` when no explicit bullet character is provided.

Preview:
– blandit turpis maecenas consequat nisi odio.
– pellentesque mollis bibendum turpis.
– dui luctus varius purus congue in praesent.

Default bullet character [–]: 
Default ordered list format
Used by `lipsum lines -o` when no explicit ordered marker format is provided.

Preview:
1. Ante ultricies maximus felis sit.
2. Et tellus mauris ultricies nisi.
3. In faucibus aliquam erat volutpat.

Default ordered list format [%d.]: 
Default format
Choose how generated output is rendered when you do not pass --format explicitly.

Preview:
Fringilla massa ac ornare interdum.
At augue elementum faucibus nulla facilisi curabitur.
Morbi tristique senectus et netus et malesuada.

Default format [plain] (plain/html/markdown/json/ndjson): 
Copy on generate
When enabled, lipsum copies output to the clipboard and still prints it.

Current default: no

Copy on generate [no] (yes/no): 
Installed lipsum-cli.
Executable:  /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.gZudViMXBP/.local/bin/lipsum
Companion:   /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.gZudViMXBP/.local/bin/lipsumize
Config:      /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.gZudViMXBP/.lipsum/config
Corpus:      /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.gZudViMXBP/.lipsum/words
Sources:     /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.gZudViMXBP/.lipsum/sources
Templates:   /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.gZudViMXBP/.lipsum/templates

Add /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.gZudViMXBP/.local/bin to your PATH to run lipsum and lipsumize directly.
5
```

### TC68 Installer
Editor-config mode creates a config file, validates it, and leaves both executables working.

```sh
tmp_home="$(mktemp -d)"; bin_dir="$tmp_home/.local/bin"; EDITOR='true' HOME="$tmp_home" zsh '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./install.sh' --editor-config --bin-dir "$bin_dir" >/tmp/lipsum-installer-editor.out 2>&1; rc=$?; cat /tmp/lipsum-installer-editor.out; test -f "$tmp_home/.lipsum/config" && HOME="$tmp_home" "$bin_dir/lipsum" 3 words -p none -l >/dev/null && printf 'atlas ember harbor signal twilight\n' | HOME="$tmp_home" "$bin_dir/lipsumize" editor-demo - >/dev/null; verify_rc=$?; rm -rf "$tmp_home" /tmp/lipsum-installer-editor.out; exit $(( rc || verify_rc ))
```

Exit status: 0

```text

Installed lipsum-cli.
Executable:  /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.thiPJMUD16/.local/bin/lipsum
Companion:   /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.thiPJMUD16/.local/bin/lipsumize
Config:      /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.thiPJMUD16/.lipsum/config
Corpus:      /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.thiPJMUD16/.lipsum/words
Sources:     /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.thiPJMUD16/.lipsum/sources
Templates:   /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.thiPJMUD16/.lipsum/templates

Add /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.thiPJMUD16/.local/bin to your PATH to run lipsum and lipsumize directly.
```

### TC69 Custom Sources
Inline text can be used as a one-off source corpus.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' --text 'alpha beta gamma delta epsilon' 5 words -p none -l | tr ' ' '\n' | awk 'NR==FNR { for (i = 1; i <= NF; i++) seen[$i]=1; next } NF { if (!seen[$1]) bad=1 } END { exit bad }' <(printf 'alpha beta gamma delta epsilon\n') -
```

Exit status: 1

```text
```

### TC70 Custom Sources
A file can provide a one-off source corpus.

```sh
tmp='$(mktemp)'; printf 'maple river lantern harbor velvet canyon' > "$tmp"; out="$('/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' --file "$tmp" 5 words -p none -l | tr ' ' '\n' | awk 'NR==FNR { for (i = 1; i <= NF; i++) seen[$i]=1; next } NF { if (!seen[$1]) bad=1 } END { exit bad }' "$tmp" - 2>&1)"; rc=$?; rm -f "$tmp"; printf '%s\n' "$out"; exit $rc
```

Exit status: 1

```text
```

### TC71 Custom Sources
Stdin can provide a one-off source corpus via --text -.

```sh
printf 'violet cedar ember meadow signal\n' | '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' --text - 5 words -p none -l | tr ' ' '\n' | awk 'NR==FNR { for (i = 1; i <= NF; i++) seen[$i]=1; next } NF { if (!seen[$1]) bad=1 } END { exit bad }' <(printf 'violet cedar ember meadow signal\n') -
```

Exit status: 1

```text
```

### TC72 Custom Sources
Custom input can be saved as a reusable named source.

```sh
tmp_home="$(mktemp -d)"; first="$(HOME="$tmp_home" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' --text 'atlas ember harbor signal twilight' --save-source customdemo 5 words -p none -l)"; second="$(HOME="$tmp_home" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' --source customdemo 5 words -p none -l)"; printf 'first=%s\nsecond=%s\n' "$first" "$second"; test -f "$tmp_home/.lipsum/sources/customdemo.words"; rc=$?; rm -rf "$tmp_home"; exit $rc
```

Exit status: 0

```text
Saved as [1mcustomdemo[0m to [1m/var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.6YVIIZNeF1/.lipsum/sources/customdemo.words[0m
first=ember twilight harbor signal atlas
second=atlas atlas harbor signal signal
```

### TC73 Errors
Custom source input and named source selection cannot be combined.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' --source hipster --text 'alpha beta gamma' 3 words
```

Exit status: 1

```text
Error: Use either --source or custom source input, not both
```

### TC74 Errors
Saving a source without custom input fails cleanly.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' --save-source customdemo 3 words
```

Exit status: 1

```text
Error: --save-source requires --text or --file input
```

### TC75 Emoji
Explicit emoji mode mixes weighted emoji into word output without changing the requested word count.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "emoji_charset='😀 😀 😀'\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/emoji-config.zsh'; out="$(LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/emoji-config.zsh' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 40 words -e -p none -l)"; printf '%s\n' "$out"; printf '%s\n' "$out" | grep -F '😀' >/dev/null && printf '%s\n' "$out" | awk '{ print NF; if (NF != 40) exit 1 }'
```

Exit status: 0

```text
sit lorem eleifend augue eros nunc nulla ante enim cras non risus tempor rutrum dolor sed quis lacus ut tempor quis sit vel nisl et et turpis morbi ultricies mollis molestie sodales sed nisl ut fusce 😀 et libero elementum
40
```

### TC76 Emoji
Config-driven emoji defaults can be disabled for one invocation with --no-emoji.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "emoji_enabled=1\nemoji_charset='😀 😀 😀'\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/emoji-default-config.zsh'; out="$(LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/emoji-default-config.zsh' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 40 words --no-emoji -p none -l)"; printf '%s\n' "$out"; ! printf '%s\n' "$out" | grep -F '😀' >/dev/null && printf '%s\n' "$out" | awk '{ print NF; if (NF != 40) exit 1 }'
```

Exit status: 0

```text
felis pharetra hendrerit primis non venenatis ipsum feugiat eu at eleifend nunc maximus in in dictum fusce ipsum nisi posuere est ut feugiat odio fringilla faucibus tristique vitae nulla orci ac et felis pharetra elementum malesuada est tristique augue morbi
40
```

### TC77 Emoji
Character mode can append sparse emoji while keeping output visually message-like.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "emoji_charset='😀 😀 😀'\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/emoji-char-config.zsh'; out="$(LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/emoji-char-config.zsh' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 140 characters -e -p none)"; printf '%s\n' "$out"; printf '%s\n' "$out" | grep -F '😀' >/dev/null
```

Exit status: 0

```text
Alesuada gravida dolor vehicula proin pharetra ligula leo ut placerat turpis feugiat efficitur nam in accumsan leo nec tristique velit done 😀
```

### TC77A Emoji
Character mode always includes emoji when --emoji is enabled.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "emoji_charset='😀 😀 😀'\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/emoji-char-config-100.zsh'; out="$(LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/emoji-char-config-100.zsh' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 100 characters -e -p end)"; printf '%s\n' "$out"; printf '%s\n' "$out" | grep -F '😀' >/dev/null
```

Exit status: 0

```text
Euismod faucibus porttitor varius ac tortor aenean nec finibus orci quisque eget dui at augue eleme? 😀
```

### TC77B Emoji
An explicit emoji probability argument is accepted and can force visible emoji output.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "emoji_charset='😀 😀 😀'\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/emoji-char-config-100-explicit.zsh'; out="$(LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/emoji-char-config-100-explicit.zsh' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 100 characters --emoji 1.0 -p end)"; printf '%s\n' "$out"; printf '%s\n' "$out" | grep -F '😀' >/dev/null
```

Exit status: 0

```text
C phasellus nec faucibus risus praesent ac dictum ex sed elementum turpis ac diam ultrices porta qu. 😀
```

### TC78 Emoji
Full stops stay attached to the text when character output ends with trailing emoji.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "emoji_charset='😀 😀 😀'\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/emoji-punctuation-config.zsh'; out="$(LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/emoji-punctuation-config.zsh' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 140 characters -e -l)"; printf '%s\n' "$out"; printf '%s\n' "$out" | grep -Eq '\. 😀$'
```

Exit status: 0

```text
us dui curabitur in magna arcu fusce bibendum nibh ac convallis feugiat praesent condimentum aliquam ornare in et volutpat lorem phasellus. 😀
```

