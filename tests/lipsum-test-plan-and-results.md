# lipsum Test Plan And Results

Generated: 2026-05-09 11:45:15 EDT

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
- TC61 Sources: The sources action separates built-in and imported sources and includes sample paragraphs.
- TC62 Sources: The long source option selects a named source corpus for one invocation.
- TC63 Sources: The short source option selects another named source corpus.
- TC64 Sources: Config can change the default source for bare and explicit generation.
- TC64A Sources: A specific source can be inspected through the sources action.
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
  [1msources, list-sources[0m       List sources, inspect one source, or manage imported sources.
  [1mtemplates, list-templates[0m   List saved templates with samples.

Options:
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m--from[0m [1mpath[0m             Seed a template from an example file with [1mtemplate new|edit[0m.
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
Lacus est faucibus eget consectetur blandit et aliquet tincidunt neque.
```

### TC05 Defaults
A bare numeric argument is treated as a default word count.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 6
```

Exit status: 0

```text
At lorem nec habitasse donec eu.
```

### TC06 Words
Count before mode works for exact word counts.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 2 words
```

Exit status: 0

```text
Ex ut.
```

### TC07 Words
Mode before count still works for exact word counts.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' words 2
```

Exit status: 0

```text
Aliquam mauris.
```

### TC08 Words
A top-level count range works for default words mode.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 3-5 -p none -l | awk '{ print NF; if (NF < 3 || NF > 5) exit 1 }'
```

Exit status: 0

```text
3
```

### TC09 Words
A top-level count range works with an explicit word subcommand.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 3-5 w -p none -l | awk '{ print NF; if (NF < 3 || NF > 5) exit 1 }'
```

Exit status: 0

```text
5
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
Sagittis sollicitudin nullam hendrerit purus ut malesuada porttitor duis ut auctor nunc quis tristiq.
```

### TC12 Characters
Character count ranges resolve to a random exact count.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 24-30 characters -p none -l | tr -d '\n' | wc -m | awk '{ print $1; if ($1 < 24 || $1 > 30) exit 1 }'
```

Exit status: 0

```text
29
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
– Ante mi euismod eget dui vitae auctor.
– Penatibus et magnis dis.
– Nisi facilisis ut nunc.
– Orci a condimentum porta duis placerat.
– A fringilla aliquam vel nisi dolor.
```

### TC15 Lines
Random top-level line counts and internal line lengths both work together.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4-6 lines -r 6-10 | awk '{ print NF; if (NF < 6 || NF > 10) bad=1 } END { if (NR < 4 || NR > 6 || bad) exit 1 }'
```

Exit status: 0

```text
8
7
8
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
Fermentum consequat felis pulvinar at morbi volutpat fermentum metus at vehicula. Porttitor et ipsum vestibulum ultrices enim sed ipsum tristique imperdiet donec sollicitudin.
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
At pellentesque ut gravida mauris non condimentum commodo dui odio. Nascetur ridiculus mus ut aliquet iaculis ante a placerat. Id tortor at placerat in gravida imperdiet odio sed gravida. Tristique gravida donec posuere lectus purus eget accumsan odio malesuada at ut consectetur malesuada.

In venenatis rutrum diam sapien sodales libero ac maximus tellus leo. Enim neque sed nunc morbi quis ex at lacus rutrum. Vulputate dictum orci non rhoncus aliquam fermentum.
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
sed consectetur et nec.
```

### TC26 Case
Uppercase output works.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4 words -p none -u
```

Exit status: 0

```text
PELLENTESQUE BLANDIT DIAM FUSCE.
```

### TC27 Case
Title case output works.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4 words -p none -t
```

Exit status: 0

```text
Dolor Odio A At.
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
  <li>Dolor velit suscipit sed lobortis at aliquet.</li>
  <li>A venenatis felis ultricies sit amet lorem.</li>
  <li>Imperdiet proin at enim odio nunc bibendum.</li>
</ul>
```

### TC83 Formats
Markdown formatting turns unprefixed lines into a markdown list.

```sh
out="$('/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 3 lines -f markdown -p none -l)"; printf '%s\n' "$out"; printf '%s\n' "$out" | awk '/^- / { count++ } END { if (count != 3) exit 1 }'
```

Exit status: 0

```text
- rutrum suspendisse viverra auctor.
- molestie cras sed commodo quam.
- viverra non neque dapibus pharetra nulla in.
```

### TC84 Formats
JSON formatting returns an array for paragraph output.

```sh
out="$('/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 2 paragraphs -f json)"; printf '%s\n' "$out"; printf '%s\n' "$out" | grep -Eq '^\[ ".*", ".*" \]$'
```

Exit status: 0

```text
[ "Eleifend tempor nulla efficitur pretium tincidunt integer tincidunt purus ut nibh placerat vehicula et. Enim eros at nulla aliquam quis aliquam dui nec hendrerit nunc. Tempus eget integer eu venenatis erat phasellus.", "Non non magna sed at erat orci cras sed condimentum massa. Primis in faucibus orci luctus et ultrices posuere cubilia. Vivamus eget risus at elit iaculis tristique morbi. Placerat vehicula et ac sem duis rutrum lorem ut interdum dapibus interdum. Donec pharetra sapien id quam euismod porttitor in sodales luctus urna vel finibus ex." ]
```

### TC85 Formats
NDJSON formatting emits one JSON string per requested word.

```sh
out="$('/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4 words -f ndjson -p none -l)"; printf '%s\n' "$out"; printf '%s\n' "$out" | awk '/^".*"$/ { count++ } END { if (count != 4) exit 1 }'
```

Exit status: 0

```text
"consectetur"
"a"
"eget"
"at."
```

### TC86 Templates
Template scaffolding creates a new starter template in the user template directory.

```sh
tmp_home="$(mktemp -d)"; out="$(HOME="$tmp_home" VISUAL=true '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' template new starter-demo)"; rc=$?; printf '%s\n' "$out"; test -f "$tmp_home/.lipsum/templates/starter-demo.tpl" && grep -F '# title: Starter Demo' "$tmp_home/.lipsum/templates/starter-demo.tpl" >/dev/null; verify_rc=$?; rm -rf "$tmp_home"; exit $(( rc || verify_rc ))
```

Exit status: 0

```text
Template is ready: /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.YT4gqy09kk/.lipsum/templates/starter-demo.tpl
```

### TC86A Templates
Template edit can create or reseed a template from an example file.

```sh
tmp_home="$(mktemp -d)"; out="$(HOME="$tmp_home" VISUAL=true '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' template edit seeded-post --from '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./examples/templates/blog-post.tpl')"; rc=$?; printf '%s\n' "$out"; test -f "$tmp_home/.lipsum/templates/seeded-post.tpl" && grep -F '# title: Blog Post' "$tmp_home/.lipsum/templates/seeded-post.tpl" >/dev/null; verify_rc=$?; rm -rf "$tmp_home"; exit $(( rc || verify_rc ))
```

Exit status: 0

```text
Template is ready: /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.jlxZNqSZJ1/.lipsum/templates/seeded-post.tpl
```

### TC87 Templates
A template can be seeded from an example file and then rendered with a top-level count.

```sh
tmp_home="$(mktemp -d)"; HOME="$tmp_home" VISUAL=true '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' template new conventional-commit --from '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./examples/templates/conventional-commit.tpl' >/dev/null && out="$(HOME="$tmp_home" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 3 template conventional-commit -p none)"; rc=$?; printf '%s\n' "$out"; printf '%s\n' "$out" | awk 'END { print NR; if (NR != 3) exit 1 }'; verify_rc=$?; rm -rf "$tmp_home"; exit $(( rc || verify_rc ))
```

Exit status: 0

```text
test: commodo dictum odio
test: eu dictum
style: iaculis libero eget
3
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
  ticket-205 gamma
```

### TC89 Templates
A custom template can be rendered from the user template directory.

```sh
tmp_home="$(mktemp -d)"; mkdir -p "$tmp_home/.lipsum/templates"; printf '# title: Ticket\nticket-{{number(100-999)}} {{choice(alpha|beta|gamma)}}\n' > "$tmp_home/.lipsum/templates/ticket.tpl"; out="$(HOME="$tmp_home" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' template ticket -p none)"; printf '%s\n' "$out"; printf '%s\n' "$out" | grep -Eq '^ticket-[0-9]{3} (alpha|beta|gamma)$'; rc=$?; rm -rf "$tmp_home"; exit $rc
```

Exit status: 0

```text
ticket-171 beta
```

### TC90 Templates
Templates also render cleanly through JSON output formatting.

```sh
tmp_home="$(mktemp -d)"; HOME="$tmp_home" VISUAL=true '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' template new blog-post --from '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./examples/templates/blog-post.tpl' >/dev/null && out="$(HOME="$tmp_home" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 2 template blog-post -f json)"; rc=$?; printf '%s\n' "$out"; printf '%s\n' "$out" | grep -Eq '^\[ ".+", ".+" \]$'; verify_rc=$?; rm -rf "$tmp_home"; exit $(( rc || verify_rc ))
```

Exit status: 0

```text
[ "Elit phasellus bibendum id lacus in semper class.\nBy nullam hendrerit\n\nPorta dignissim diam nisi cursus massa eget viverra quam est ac turpis aliquam id lacus eget erat cursus.", "Magna non ex pellentesque at posuere.\nBy netus et\n\nVolutpat lorem phasellus massa risus lobortis eu pellentesque id aliquam at lectus maecenas." ]
```

### TC91 Config
Config can set the default output format for bare invocations.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "default_mode='lines'\ndefault_line_count=2\ndefault_line_range='2-2'\ndefault_format='json'\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/format-config.zsh'; out="$(LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/format-config.zsh' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' -p none -l)"; printf '%s\n' "$out"; printf '%s\n' "$out" | grep -Eq '^\[ ".+", ".+" \]$'
```

Exit status: 0

```text
[ "auctor praesent", "posuere elit" ]
```

### TC28 Ordered Lists
Default ordered lists use numeric markers.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 3 lines -o
```

Exit status: 0

```text
1. Consectetur eget eros ut sollicitudin porttitor mi.
2. Est sed suscipit libero leo.
3. Sed velit urna gravida sit amet risus.
```

### TC29 Ordered Lists
Ordered list formulas support alphabetic markers.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4 lines -o '(%A)'
```

Exit status: 0

```text
(A) Mi a vulputate erat blandit a mauris.
(B) Imperdiet in ex quis interdum sollicitudin enim aliquam.
(C) Morbi ligula ante commodo vel arcu sit.
(D) Sapien integer in ex gravida dui porta efficitur.
```

### TC30 Ordered Lists
Ordered list formulas support zero-padded zero-indexed digits.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 3 lines -o '%00z)'
```

Exit status: 0

```text
000) Volutpat id curabitur consectetur tellus egestas velit pharetra.
001) Ac pulvinar augue ut sollicitudin at.
002) Fames ac ante ipsum primis in.
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
stdout=dictum sapien faucibus magna.
clipboard=dictum sapien faucibus magna.
```

### TC38 Copy
Config can enable copy by default.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "copy_on_generate=1\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/copy-config.zsh'; rm -f '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/clipboard-config.txt'; out="$(LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/copy-config.zsh' LIPSUM_CLIPBOARD_COMMAND="sh -c 'cat > \"\$1\"' _ '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/clipboard-config.txt'" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4 w -p none -l)"; clip="$(cat '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/clipboard-config.txt')"; printf 'stdout=%s\nclipboard=%s\n' "$out" "$clip"; [[ "$out" == "$clip" ]]
```

Exit status: 0

```text
stdout=ac penatibus pulvinar aptent
clipboard=ac penatibus pulvinar aptent
```

### TC39 Copy
Explicit no-copy overrides config-driven clipboard copying.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "copy_on_generate=1\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/no-copy-config.zsh'; rm -f '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/clipboard-no-copy.txt'; out="$(LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/no-copy-config.zsh' LIPSUM_CLIPBOARD_COMMAND="sh -c 'cat > \"\$1\"' _ '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/clipboard-no-copy.txt'" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4 w --no-copy -p none -l)"; printf 'stdout=%s\nclipboard_exists=%s\n' "$out" "$(test -e '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/clipboard-no-copy.txt'; echo $?)"; [[ ! -e '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/clipboard-no-copy.txt' ]]
```

Exit status: 0

```text
stdout=at felis metus praesent
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
  [1mtemplate, tpl, tmpl[0m      Render a named template, or use [1mtemplate new|edit[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List sources, inspect one source, or manage imported sources.
  [1mtemplates, list-templates[0m   List saved templates with samples.

Options:
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m--from[0m [1mpath[0m             Seed a template from an example file with [1mtemplate new|edit[0m.
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
  [1mtemplate, tpl, tmpl[0m      Render a named template, or use [1mtemplate new|edit[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List sources, inspect one source, or manage imported sources.
  [1mtemplates, list-templates[0m   List saved templates with samples.

Options:
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m--from[0m [1mpath[0m             Seed a template from an example file with [1mtemplate new|edit[0m.
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
  [1mtemplate, tpl, tmpl[0m      Render a named template, or use [1mtemplate new|edit[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List sources, inspect one source, or manage imported sources.
  [1mtemplates, list-templates[0m   List saved templates with samples.

Options:
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m--from[0m [1mpath[0m             Seed a template from an example file with [1mtemplate new|edit[0m.
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
  [1mtemplate, tpl, tmpl[0m      Render a named template, or use [1mtemplate new|edit[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List sources, inspect one source, or manage imported sources.
  [1mtemplates, list-templates[0m   List saved templates with samples.

Options:
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m--from[0m [1mpath[0m             Seed a template from an example file with [1mtemplate new|edit[0m.
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
  [1mtemplate, tpl, tmpl[0m      Render a named template, or use [1mtemplate new|edit[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List sources, inspect one source, or manage imported sources.
  [1mtemplates, list-templates[0m   List saved templates with samples.

Options:
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m--from[0m [1mpath[0m             Seed a template from an example file with [1mtemplate new|edit[0m.
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
  [1mtemplate, tpl, tmpl[0m      Render a named template, or use [1mtemplate new|edit[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List sources, inspect one source, or manage imported sources.
  [1mtemplates, list-templates[0m   List saved templates with samples.

Options:
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m--from[0m [1mpath[0m             Seed a template from an example file with [1mtemplate new|edit[0m.
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
  [1mtemplate, tpl, tmpl[0m      Render a named template, or use [1mtemplate new|edit[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List sources, inspect one source, or manage imported sources.
  [1mtemplates, list-templates[0m   List saved templates with samples.

Options:
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m--from[0m [1mpath[0m             Seed a template from an example file with [1mtemplate new|edit[0m.
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
  [1mtemplate, tpl, tmpl[0m      Render a named template, or use [1mtemplate new|edit[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List sources, inspect one source, or manage imported sources.
  [1mtemplates, list-templates[0m   List saved templates with samples.

Options:
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m--from[0m [1mpath[0m             Seed a template from an example file with [1mtemplate new|edit[0m.
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
  [1mtemplate, tpl, tmpl[0m      Render a named template, or use [1mtemplate new|edit[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List sources, inspect one source, or manage imported sources.
  [1mtemplates, list-templates[0m   List saved templates with samples.

Options:
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m--from[0m [1mpath[0m             Seed a template from an example file with [1mtemplate new|edit[0m.
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
  [1mtemplate, tpl, tmpl[0m      Render a named template, or use [1mtemplate new|edit[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List sources, inspect one source, or manage imported sources.
  [1mtemplates, list-templates[0m   List saved templates with samples.

Options:
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m--from[0m [1mpath[0m             Seed a template from an example file with [1mtemplate new|edit[0m.
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
  [1mtemplate, tpl, tmpl[0m      Render a named template, or use [1mtemplate new|edit[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List sources, inspect one source, or manage imported sources.
  [1mtemplates, list-templates[0m   List saved templates with samples.

Options:
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m--from[0m [1mpath[0m             Seed a template from an example file with [1mtemplate new|edit[0m.
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
  [1mtemplate, tpl, tmpl[0m      Render a named template, or use [1mtemplate new|edit[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List sources, inspect one source, or manage imported sources.
  [1mtemplates, list-templates[0m   List saved templates with samples.

Options:
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m--from[0m [1mpath[0m             Seed a template from an example file with [1mtemplate new|edit[0m.
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
  [1mtemplate, tpl, tmpl[0m      Render a named template, or use [1mtemplate new|edit[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/bad-config.zsh[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List sources, inspect one source, or manage imported sources.
  [1mtemplates, list-templates[0m   List saved templates with samples.

Options:
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m--from[0m [1mpath[0m             Seed a template from an example file with [1mtemplate new|edit[0m.
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

### TC53 Shell Integration
A for-loop can generate progressively longer exact bullet lines.

```sh
for n in 3 4 5; do '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 1 l -r "$n" -b; done
```

Exit status: 0

```text
– Fusce risus erat.
– In faucibus orci luctus.
– Risus quisque pulvinar eget nunc.
```

### TC54 Shell Integration
Piped numeric input can drive sentence generation through a while-read loop.

```sh
printf '4\n6\n' | while read -r n; do '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 1 s -r "$n" -l; done
```

Exit status: 0

```text
magna sit amet eleifend.
lacinia lectus orci in nisi nullam.
```

### TC55 Shell Integration
Piped numeric input can drive line generation through xargs.

```sh
printf '3\n5\n' | xargs -I{} zsh -c "'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 1 lines -r \"\$1\" -b" _ {}
```

Exit status: 0

```text
– Rutrum sagittis quis.
– Non rutrum morbi tempor at.
```

### TC56 Shell Integration
Command substitution can inline generated text inside another command.

```sh
printf '[%s]\n' "$('/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4 w -p none -l)"
```

Exit status: 0

```text
[sed libero sed mattis.]
```

### TC57 Shell Integration
Direct stdin piping into lipsum is harmless and the command still produces stdout.

```sh
printf 'stdin is ignored here\n' | '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 5 w
```

Exit status: 0

```text
Fusce volutpat et scelerisque sed.
```

### TC58 Shell Integration
Paragraph output can be piped into fold for visual wrapping.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 1 p | fold -s -w 40
```

Exit status: 0

```text
Interdum ligula nec sapien egestas nec 
fermentum odio viverra donec. Ut metus 
curabitur vel ante in neque lacinia. 
Tincidunt aliquam erat volutpat ut 
dignissim magna eget nulla. Dictumst 
etiam vitae nibh tempus nibh blandit 
imperdiet. Quam et ultrices fermentum 
tellus ante ornare eros non.
```

### TC59 Shell Integration
Bullet output can be piped into line numbering for visual review.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 4 l -b | nl -ba
```

Exit status: 0

```text
     1	– Vehicula tellus sit amet imperdiet.
     2	– Ornare eros non molestie turpis.
     3	– Gravida mauris non condimentum commodo dui odio sodales.
     4	– Pharetra orci eu tristique arcu vestibulum nec.
```

### TC60 Shell Integration
Word output can be piped into newline transforms for tokenized display.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 8 w -p none -l | tr ' ' '\n'
```

Exit status: 0

```text
dapibus
ultrices
in
faucibus
ex
feugiat
elit
donec.
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
  Et ultrices posuere cubilia curae sed eget malesuada. Vestibulum id nibh a placerat vestibulum aliquet faucibus elit blandit laoreet.

- Hipster Ipsum (hipster)
  Wayfarers pabst scenester lo fi cold brew normcore snackwave. Enamel pin messenger bag tattooed flannel tote bag slowcore gastropub.

- Tech Ipsum (tech)
  Latency uptime roadmap sprint backlog schema runtime package endpoint console branch. Provider tenant workspace config registry commit review patch issue milestone.

- Pirate Ipsum (pirate)
  Bilge pump dockside lantern reef breaker compass rose longboat shoreline wave. Harbor watch tide mark seaworthy ballast hold trade wind spray-soaked timber.

- Food Ipsum (food)
  Yogurt custard marmalade sorbet preserve jam tarragon dill mint. Garden party supper club pastry case confection.

- Corporate Ipsum (corporate)
  Principle measurable outcome customer signal workflow streamlining priority matrix facilitator summary. Checklist launch note weekly digest quarterly review stakeholder map operating principle.

- Spanish Ipsum (es)
  Farol cuento abrazo sonido refugio paisaje memoria puerto cocina mantel. Piedra nube campo jardin casa ventana puerta abrazo.

- French Ipsum (fr)
  Cannelle citron farine patio balcon lampe histoire refuge. Pierre riviere maison parfum silence sourire regard temps couleur parole chanson.

- German Ipsum (de)
  Frucht stern mond sonne regen winter fruehling sommer herbst reise. Freundlichkeit heimweg schimmer mauer feld ufer kiesel feder.

Imported Sources:
- Custom Demo (custom-demo)
  Atlas ember harbor signal twilight atlas ember harbor signal. Atlas ember harbor signal twilight atlas ember harbor signal twilight atlas.

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

### TC64A Sources
A specific source can be inspected through the sources action.

```sh
out="$(HOME="$(mktemp -d)" LIPSUM_SOURCE_DIR='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./share/sources' LIPSUM_DICT='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./share/lorem.words' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' sources corporate)"; printf '%s\n' "$out"; printf '%s\n' "$out" | grep -F 'Source Details' >/dev/null && printf '%s\n' "$out" | grep -F 'Title: Corporate Ipsum' >/dev/null && printf '%s\n' "$out" | grep -F 'Slug: corporate' >/dev/null && printf '%s\n' "$out" | grep -F 'Type: built-in' >/dev/null && printf '%s\n' "$out" | grep -F 'Sample:' >/dev/null
```

Exit status: 0

```text
Source Details

Title: Corporate Ipsum
Slug: corporate
Type: built-in
Path: /Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./share/sources/corporate.words
Default: no
Word count: 151

Sample:
Vendor review forecasting pipeline win rate retention. Readiness checklist launch note weekly digest quarterly review stakeholder.
```

### TC64B Sources
An imported source can be renamed through the sources action.

```sh
tmp_home="$(mktemp -d)"; mkdir -p "$tmp_home/.lipsum/sources"; printf 'atlas ember harbor signal twilight\n' > "$tmp_home/.lipsum/sources/custom-demo.words"; out="$(HOME="$tmp_home" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' sources custom-demo --rename renamed-demo)"; rc=$?; printf '%s\n' "$out"; test -f "$tmp_home/.lipsum/sources/renamed-demo.words" && test ! -f "$tmp_home/.lipsum/sources/custom-demo.words"; verify_rc=$?; rm -rf "$tmp_home"; exit $(( rc || verify_rc ))
```

Exit status: 0

```text
Renamed source custom-demo to renamed-demo
```

### TC64C Sources
A source can be set as the default through the sources action.

```sh
tmp_home="$(mktemp -d)"; mkdir -p "$tmp_home/.lipsum/sources"; printf 'atlas ember harbor signal twilight\n' > "$tmp_home/.lipsum/sources/custom-demo.words"; out="$(HOME="$tmp_home" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' sources custom-demo --set-default)"; rc=$?; printf '%s\n' "$out"; grep -F "default_source='custom-demo'" "$tmp_home/.lipsum/config" >/dev/null; verify_rc=$?; rm -rf "$tmp_home"; exit $(( rc || verify_rc ))
```

Exit status: 0

```text
Default source set to custom-demo
```

### TC64D Sources
Deleting a source asks for confirmation and removes the imported source.

```sh
tmp_home="$(mktemp -d)"; mkdir -p "$tmp_home/.lipsum/sources"; printf 'default_source='\''custom-demo'\''\n' > "$tmp_home/.lipsum/config"; printf 'atlas ember harbor signal twilight\n' > "$tmp_home/.lipsum/sources/custom-demo.words"; out="$(printf 'y\n' | HOME="$tmp_home" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' sources custom-demo --delete)"; rc=$?; printf '%s\n' "$out"; test ! -f "$tmp_home/.lipsum/sources/custom-demo.words" && grep -F "default_source='lorem'" "$tmp_home/.lipsum/config" >/dev/null; verify_rc=$?; rm -rf "$tmp_home"; exit $(( rc || verify_rc ))
```

Exit status: 0

```text
Delete source 'custom-demo'? [y/N] Deleted source custom-demo
```

### TC64E Errors
Built-in sources cannot be deleted through the sources action.

```sh
'/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' sources lorem --delete
```

Exit status: 1

```text
Error: Built-in sources cannot be deleted: lorem


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
  [1msources, list-sources[0m       List sources, inspect one source, or manage imported sources.
  [1mtemplates, list-templates[0m   List saved templates with samples.

Options:
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m--from[0m [1mpath[0m             Seed a template from an example file with [1mtemplate new|edit[0m.
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

### TC64F Lipsumize
A plain text file can be imported into a reusable source corpus.

```sh
tmp_home="$(mktemp -d)"; tmp_file="$tmp_home/book.txt"; printf 'maple river lantern harbor velvet canyon\n' > "$tmp_file"; out="$(HOME="$tmp_home" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsumize' bookish "$tmp_file")"; rc=$?; printf '%s\n' "$out"; HOME="$tmp_home" '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' --source bookish 5 words -p none -l | tr ' ' '\n' | awk 'NR==FNR { for (i = 1; i <= NF; i++) seen[$i]=1; next } NF { if (!seen[$1]) bad=1 } END { exit bad }' "$tmp_file" -; verify_rc=$?; rm -rf "$tmp_home"; exit $(( rc || verify_rc ))
```

Exit status: 0

```text
Saved source: bookish
Type: text
Path: /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.jsV3WVoAPl/.lipsum/sources/bookish.words
Words: 6

Preview:
maple river lantern harbor velvet canyon
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
Saved source: example-site
Type: url
Path: /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.sR6LfawEmO/.lipsum/sources/example-site.words
Words: 21

Preview:
Example Domain Example Domain This domain is for use in documentation examples without needing permission Avoid use in
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

Create or update a reusable lipsum source corpus from local text, HTML, EPUB, stdin,
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
Executable:  /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.8xFgzejpcO/.local/bin/lipsum
Companion:   /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.8xFgzejpcO/.local/bin/lipsumize
Config:      /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.8xFgzejpcO/.lipsum/config
Corpus:      /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.8xFgzejpcO/.lipsum/words
Sources:     /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.8xFgzejpcO/.lipsum/sources
Templates:   /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.8xFgzejpcO/.lipsum/templates

Add /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.8xFgzejpcO/.local/bin to your PATH to run lipsum and lipsumize directly.
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
Eu ullamcorper a nunc egestas ipsum ultrices quam posuere aliquet.

Default mode [words] (words/characters/lines/sentences/paragraphs): 
Default source
Choose the source corpus used by default. Available: lorem hipster tech pirate food corporate es fr de.

Preview:
vitae metus nisi sit vestibulum urna.

Default source [lorem]: 
Default word count
Used when your default mode is words and you run `lipsum` with no count.

Preview:
Amet nibh ex in augue gravida ante dui non ut.

Default word count [10]: 
Default character count
Used when your default mode is characters and you run `lipsum` with no count.

Preview:
To lobortis et duis venenatis di.

Default character count [32]: 
Default line count
Used when your default mode is lines and you run `lipsum` with no count.

Preview:
– Consectetur nunc imperdiet elementum tempus.
– Enim nulla malesuada sem.
– Lacinia gravida nulla facilisi fusce ac.
– Est duis vel cursus diam sed blandit mauris.
– Ultrices dui nec vestibulum mi.

Default line count [5]: 
Default sentence count
Used when your default mode is sentences and you run `lipsum` with no count.

Preview:
Arcu sed auctor dolor et consectetur condimentum ipsum. Vehicula tellus sit amet imperdiet lectus tincidunt maximus phasellus viverra elementum. Ex sed elementum turpis ac diam ultrices porta quisque vulputate lectus diam. Rutrum nisl pellentesque leo metus tristique at interdum sit amet.

Default sentence count [4]: 
Default paragraph count
Used when your default mode is paragraphs and you run `lipsum` with no count.

Preview:
Eleifend enim quis lobortis ante luctus nec donec fringilla orci quis ex volutpat id. Tempus nibh blandit imperdiet ut rutrum varius. Purus eleifend egestas donec efficitur consequat metus ultrices feugiat cras varius. Finibus semper posuere justo sed in pharetra.

Ac ornare interdum et malesuada fames ac. Accumsan odio malesuada at ut consectetur malesuada eleifend vivamus ac fringilla sem suspendisse id. Fermentum consequat felis pulvinar at morbi volutpat fermentum metus at vehicula. Congue at praesent orci nisi sodales nec.

Malesuada et risus a dignissim mauris tempus. Convallis a ex aliquam non aliquam ante at euismod. Sollicitudin elit sit amet dui consequat. Primis in faucibus etiam eleifend bibendum. Felis curabitur vel ex quis urna porttitor fermentum nam.

Default paragraph count [3]: 
Default word length range
Controls the character length of generated words when no explicit range is provided.

Preview:
sit urna sit eu nisi sit.

Default word length range [1-12]: 
Default line range
Controls the number of words in each generated line.

Preview:
– felis et suscipit nunc mollis.
– et risus nullam eu turpis ac nibh scelerisque.
– urna at ante sagittis.

Default line range [4-8]: 
Default sentence range
Controls the number of words in each generated sentence.

Preview:
vulputate dictum orci non rhoncus aliquam fermentum lacinia tristique phasellus dui massa bibendum. dignissim sed ornare scelerisque elementum nulla sit amet.

Default sentence range [6-14]: 
Default paragraph range
Controls the number of sentences in each generated paragraph.

Preview:
Lacus eu lobortis arcu sed auctor dolor et consectetur condimentum ipsum. Volutpat proin tempus velit eget massa consectetur. Ultricies mi ac rutrum lacus cras. Vivamus ut felis vitae orci rhoncus lacinia suspendisse enim lacus commodo sagittis.

Lectus purus eget accumsan odio malesuada at ut consectetur. Scelerisque ante sagittis a quisque semper metus ac interdum. At leo consectetur porttitor nulla ut varius enim maecenas a tempor felis. Elit convallis rhoncus curabitur ornare accumsan dui quis mattis aenean.

Default paragraph range [3-5]: 
Default paragraph sentence word range
Controls the number of words in each sentence inside paragraph output.

Preview:
Sed ipsum eget nibh vestibulum venenatis sed eu ultrices libero. Aliquam vulputate ligula odio tincidunt nisl at gravida nulla libero non. Suscipit ipsum eget consequat quisque pharetra vitae est eu eleifend mauris.

Default paragraph sentence word range [6-14]: 
Default bullet character
Used by `lipsum lines -b` when no explicit bullet character is provided.

Preview:
– ex commodo in urna nec.
– sem eu laoreet velit blandit.
– duis maximus finibus orci.

Default bullet character [–]: 
Default ordered list format
Used by `lipsum lines -o` when no explicit ordered marker format is provided.

Preview:
1. At risus euismod consequat non.
2. Pretium mi vehicula vestibulum porta.
3. Diam tempor ac ornare eget tincidunt maximus ante.

Default ordered list format [%d.]: 
Default format
Choose how generated output is rendered when you do not pass --format explicitly.

Preview:
Nunc lobortis ligula purus mattis dapibus lacus feugiat.
Ac iaculis diam maecenas.
Risus morbi vehicula lacus id hendrerit.

Default format [plain] (plain/html/markdown/json/ndjson): 
Copy on generate
When enabled, lipsum copies output to the clipboard and still prints it.

Current default: no

Copy on generate [no] (yes/no): 
Installed lipsum-cli.
Executable:  /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.1L4wTh8rJu/.local/bin/lipsum
Companion:   /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.1L4wTh8rJu/.local/bin/lipsumize
Config:      /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.1L4wTh8rJu/.lipsum/config
Corpus:      /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.1L4wTh8rJu/.lipsum/words
Sources:     /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.1L4wTh8rJu/.lipsum/sources
Templates:   /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.1L4wTh8rJu/.lipsum/templates

Add /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.1L4wTh8rJu/.local/bin to your PATH to run lipsum and lipsumize directly.
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
Executable:  /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.B1ULoFfwCw/.local/bin/lipsum
Companion:   /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.B1ULoFfwCw/.local/bin/lipsumize
Config:      /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.B1ULoFfwCw/.lipsum/config
Corpus:      /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.B1ULoFfwCw/.lipsum/words
Sources:     /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.B1ULoFfwCw/.lipsum/sources
Templates:   /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.B1ULoFfwCw/.lipsum/templates

Add /var/folders/z3/qtqd5lgn3lj_k68wjk7wwprr0000gn/T/tmp.B1ULoFfwCw/.local/bin to your PATH to run lipsum and lipsumize directly.
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
first=harbor harbor atlas atlas atlas
second=atlas atlas twilight harbor atlas
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
  [1mtemplate, tpl, tmpl[0m      Render a named template, or use [1mtemplate new|edit[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List sources, inspect one source, or manage imported sources.
  [1mtemplates, list-templates[0m   List saved templates with samples.

Options:
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m--from[0m [1mpath[0m             Seed a template from an example file with [1mtemplate new|edit[0m.
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
  [1mtemplate, tpl, tmpl[0m      Render a named template, or use [1mtemplate new|edit[0m

Other Actions:
  [1minit[0m                         Create a starter config file at [1m/Users/avanavana/.lipsum/config[0m.
  [1mconfig, settings, prefs, preferences[0m
                               Open the config file in $VISUAL, $EDITOR, or [1mvi[0m.
  [1msources, list-sources[0m       List sources, inspect one source, or manage imported sources.
  [1mtemplates, list-templates[0m   List saved templates with samples.

Options:
  [1m-l, -L, --lowercase[0m          Return output entirely in lowercase.
  [1m-u, -U, --uppercase[0m          Return output entirely in uppercase.
  [1m-t, -T, --title-case[0m         Return output in title case.
  [1m-s, -S, --source[0m [1mname[0m         Choose a named source corpus such as [1mlorem[0m or [1mhipster[0m.
  [1m--text[0m [1mtext|- [0m        Use inline text, or stdin via [1m--text -[0m, as the source corpus.
  [1m--file[0m [1mpath[0m             Use a file's contents as the source corpus for this invocation.
  [1m--save-source[0m [1mname[0m    Save custom text or file input as a reusable named source.
  [1m--from[0m [1mpath[0m             Seed a template from an example file with [1mtemplate new|edit[0m.
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

### TC75 Emoji
Explicit emoji mode mixes weighted emoji into word output without changing the requested word count.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "emoji_charset='😀 😀 😀'\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/emoji-config.zsh'; out="$(LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/emoji-config.zsh' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 40 words -e -p none -l)"; printf '%s\n' "$out"; printf '%s\n' "$out" | grep -F '😀' >/dev/null && printf '%s\n' "$out" | awk '{ print NF; if (NF != 40) exit 1 }'
```

Exit status: 0

```text
quis tempus mi nisi et sollicitudin in vel orci class ut amet in amet eros ac libero tempus auctor viverra id ipsum orci ornare a vulputate ultricies primis in consequat hendrerit mauris nulla nunc est in platea pulvinar 😀 😀
40
```

### TC76 Emoji
Config-driven emoji defaults can be disabled for one invocation with --no-emoji.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "emoji_enabled=1\nemoji_charset='😀 😀 😀'\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/emoji-default-config.zsh'; out="$(LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/emoji-default-config.zsh' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 40 words --no-emoji -p none -l)"; printf '%s\n' "$out"; ! printf '%s\n' "$out" | grep -F '😀' >/dev/null && printf '%s\n' "$out" | awk '{ print NF; if (NF != 40) exit 1 }'
```

Exit status: 0

```text
id ornare sed semper neque dui eget dolor convallis viverra eget quis iaculis tincidunt dui ornare non aliquam lacinia sodales id laoreet libero etiam ultricies mi laoreet ex ornare nam ornare ante vitae faucibus diam rhoncus suscipit erat phasellus odio
40
```

### TC77 Emoji
Character mode can append sparse emoji while keeping output visually message-like.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "emoji_charset='😀 😀 😀'\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/emoji-char-config.zsh'; out="$(LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/emoji-char-config.zsh' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 140 characters -e -p none)"; printf '%s\n' "$out"; printf '%s\n' "$out" | grep -F '😀' >/dev/null
```

Exit status: 0

```text
Titor id metus aliquam et neque non justo lobortis mattis in vel metus sed porta nunc eget commodo lobortis mauris libero efficitur metus v 😀
```

### TC78 Emoji
Full stops stay attached to the text when character output ends with trailing emoji.

```sh
mkdir -p '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts'; printf "emoji_charset='😀 😀 😀'\n" > '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/emoji-punctuation-config.zsh'; out="$(LIPSUM_CONFIG='/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./tests/test-artifacts/emoji-punctuation-config.zsh' '/Users/avanavana/Dropbox/My Mac (MacBook-Pro.lan1)/Documents/Projects/Code/shell/lipsum-cli/./lipsum' 140 characters -e -l)"; printf '%s\n' "$out"; printf '%s\n' "$out" | grep -Eq '\. 😀$'
```

Exit status: 0

```text
ugiat viverra eros eget pretium justo fusce tristique eros in aliquet semper praesent quis ex vestibulum ornare ex a pulvinar nunc phasellu. 😀
```

