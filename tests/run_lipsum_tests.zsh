#!/bin/zsh

emulate -L zsh
setopt pipe_fail

typeset script_dir="${0:h}"
if [[ $script_dir != /* ]]; then
  script_dir="$PWD/$script_dir"
fi

typeset project_dir="${script_dir:h}"
typeset report="$script_dir/lipsum-test-plan-and-results.md"
typeset lipsum="$project_dir/lipsum"
typeset installer="$project_dir/install.sh"
typeset lp="'$lipsum'"
typeset ip="'$installer'"
typeset artifacts="$script_dir/test-artifacts"

typeset -a case_ids=()
typeset -a case_categories=()
typeset -a case_summaries=()
typeset -a case_commands=()

register_case () {
  case_ids+=( "$1" )
  case_categories+=( "$2" )
  case_summaries+=( "$3" )
  case_commands+=( "$4" )
}

write_header () {
  cat >| "$report" <<EOF
# lipsum Test Plan And Results

Generated: $(date '+%Y-%m-%d %H:%M:%S %Z')

Scripts under test:
- [$lipsum]($lipsum)
- [$installer]($installer)

## Test Plan

This plan covers the current CLI shape where generation modes are subcommands only, counts can appear before or after the subcommand, compact one-token short forms are supported, config editing/init are separate utility commands, output case can be controlled explicitly, ordered lists are available for line output, and clipboard copying can be enabled directly or via config.

Coverage areas:
- Syntax and basic CLI metadata.
- Subcommand-only mode selection.
- Count parsing in both orderings: \`count mode\` and \`mode count\`.
- Compact short forms such as \`10c\`, \`s2\`, \`2-3l\`, and \`P1-3\`.
- Top-level count ranges such as \`3-5 words\`.
- Internal range handling for words, lines, sentences, paragraphs, and characters.
- Named source selection and source discovery.
- Ad hoc source input from text, files, stdin, and saved custom sources.
- Case formatting: lowercase, uppercase, and title case.
- Bullets and ordered lists.
- Config commands and config-driven defaults.
- Clipboard behaviors including explicit copy, config-driven copy, and explicit no-copy override.
- Installer flows for defaults, guided setup, and editor-config mode.
- Error handling for invalid combinations, removed mode flags, invalid ranges, incompatible options, and size caps.
- Shell integration patterns users are likely to rely on: loops, \`xargs\`, command substitution, stdin-driven wrappers, and output pipelines.

### Planned Cases

EOF

  local -i i=1
  while (( i <= ${#case_ids[@]} )); do
    print -- "- ${case_ids[i]} ${case_categories[i]}: ${case_summaries[i]}" >> "$report"
    (( i++ ))
  done

  cat >> "$report" <<'EOF'

## Execution Results

EOF
}

run_case () {
  local id="$1"
  local category="$2"
  local summary="$3"
  local command="$4"
  local output=''
  local exit_status=0

  output="$(eval "$command" 2>&1)"
  exit_status=$?

  print -- "### $id $category" >> "$report"
  print -- "$summary" >> "$report"
  print -- '' >> "$report"
  print -- '```sh' >> "$report"
  print -r -- "$command" >> "$report"
  print -- '```' >> "$report"
  print -- '' >> "$report"
  print -- "Exit status: $exit_status" >> "$report"
  print -- '' >> "$report"
  print -- '```text' >> "$report"
  if [[ -n $output ]]; then
    print -r -- "$output" >> "$report"
  fi
  print -- '```' >> "$report"
  print -- '' >> "$report"
}

register_case 'TC01' 'Smoke' 'Syntax check parses cleanly.' "zsh -n $lp"
register_case 'TC02' 'Metadata' 'Short help flag renders the updated usage screen and examples.' "$lp -h"
register_case 'TC03' 'Metadata' 'Long version flag returns the version string.' "$lp --version"
register_case 'TC04' 'Defaults' 'Bare invocation uses the default words mode.' "$lp"
register_case 'TC05' 'Defaults' 'A bare numeric argument is treated as a default word count.' "$lp 6"
register_case 'TC06' 'Words' 'Count before mode works for exact word counts.' "$lp 2 words"
register_case 'TC07' 'Words' 'Mode before count still works for exact word counts.' "$lp words 2"
register_case 'TC08' 'Words' 'A top-level count range works for default words mode.' "$lp 3-5 -n -l | awk '{ print NF; if (NF < 3 || NF > 5) exit 1 }'"
register_case 'TC09' 'Words' 'A top-level count range works with an explicit word subcommand.' "$lp 3-5 w -n -l | awk '{ print NF; if (NF < 3 || NF > 5) exit 1 }'"
register_case 'TC10' 'Words' 'Word ranges filter word length in characters.' "$lp 5 words -r 3-4 -n -l | awk '{ for (i = 1; i <= NF; i++) { if (length(\$i) < 3 || length(\$i) > 4) bad=1 } } END { print NF; if (bad) exit 1 }'"
register_case 'TC11' 'Characters' 'Count before the characters subcommand works.' "$lp 100 c"
register_case 'TC12' 'Characters' 'Character count ranges resolve to a random exact count.' "$lp 24-30 characters -n -l | tr -d '\n' | wc -m | awk '{ print \$1; if (\$1 < 24 || \$1 > 30) exit 1 }'"
register_case 'TC13' 'Characters' 'Internal range is ignored for characters.' "$lp 20 characters -r 3-4 -n | tr -d '\n' | wc -m | awk '{ print \$1; if (\$1 != 20) exit 1 }'"
register_case 'TC14' 'Lines' 'Typical website bullet use case uses shorter default line lengths.' "$lp 5 lines -b"
register_case 'TC15' 'Lines' 'Random top-level line counts and internal line lengths both work together.' "$lp 4-6 lines -r 6-10 | awk '{ print NF; if (NF < 6 || NF > 10) bad=1 } END { if (NR < 4 || NR > 6 || bad) exit 1 }'"
register_case 'TC16' 'Lines' 'Mode-first ordering works with an exact internal line length.' "$lp lines 4-6 -r 3 | awk '{ print NF; if (NF != 3) bad=1 } END { print NR; if (NR < 4 || NR > 6 || bad) exit 1 }'"
register_case 'TC17' 'Sentences' 'Default sentences mode generates the requested number of sentences.' "$lp 2 sentences"
register_case 'TC18' 'Sentences' 'Sentence count ranges and exact internal sentence lengths work together.' "$lp 2-4 s -r 5 -l | tr '.' '\n' | awk 'NF > 0 { print NF; count++; if (NF != 5) bad=1 } END { if (count < 2 || count > 4 || bad) exit 1 }'"
register_case 'TC19' 'Paragraphs' 'Default paragraphs mode emits multiple paragraphs with blank-line separation.' "$lp 2 paragraphs"
register_case 'TC20' 'Paragraphs' 'Exact paragraph sentence counts can be forced.' "$lp 2 paragraphs -r 2 | awk 'BEGIN { RS=\"\" } { count=gsub(/\\./, \"&\"); print count; if (count != 2) bad=1 } END { if (NR != 2 || bad) exit 1 }'"
register_case 'TC21' 'Compact Forms' 'Compact count+command suffix form works.' "$lp 10c -n | tr -d '\n' | wc -m | awk '{ print \$1; if (\$1 != 10) exit 1 }'"
register_case 'TC22' 'Compact Forms' 'Compact command+count prefix form works.' "$lp s2 | tr '.' '\n' | awk 'NF > 0 { count++ } END { print count; if (count != 2) exit 1 }'"
register_case 'TC23' 'Compact Forms' 'Compact range+command suffix form works.' "$lp 2-3l | awk 'END { print NR; if (NR < 2 || NR > 3) exit 1 }'"
register_case 'TC24' 'Compact Forms' 'Compact command+range prefix form works.' "$lp P1-3 | awk 'BEGIN { RS=\"\" } END { print NR; if (NR < 1 || NR > 3) exit 1 }'"
register_case 'TC25' 'Case' 'Lowercase output works with the new lowercase option.' "$lp 4 words -n -l"
register_case 'TC26' 'Case' 'Uppercase output works.' "$lp 4 words -n -u"
register_case 'TC27' 'Case' 'Title case output works.' "$lp 4 words -n -t"
register_case 'TC28' 'Ordered Lists' 'Default ordered lists use numeric markers.' "$lp 3 lines -o"
register_case 'TC29' 'Ordered Lists' 'Ordered list formulas support alphabetic markers.' "$lp 4 lines -o '(%A)'"
register_case 'TC30' 'Ordered Lists' 'Ordered list formulas support zero-padded zero-indexed digits.' "$lp 3 lines -o '%00z)'"
register_case 'TC31' 'Config Actions' 'Init creates a starter config file at an override path.' "mkdir -p '$artifacts'; rm -f '$artifacts/init-config.zsh'; LIPSUM_CONFIG='$artifacts/init-config.zsh' $lp init; sed -n '1,20p' '$artifacts/init-config.zsh'"
register_case 'TC32' 'Config Actions' 'Config opens an existing config file in the configured editor and validates it.' "mkdir -p '$artifacts'; printf \"default_mode='words'\n\" > '$artifacts/edit-config.zsh'; EDITOR='true' LIPSUM_CONFIG='$artifacts/edit-config.zsh' $lp config"
register_case 'TC33' 'Config Actions' 'Config creates a missing config file before opening it.' "mkdir -p '$artifacts'; rm -f '$artifacts/config-create.zsh'; EDITOR='true' LIPSUM_CONFIG='$artifacts/config-create.zsh' $lp config; test -f '$artifacts/config-create.zsh' && echo created"
register_case 'TC34' 'Config' 'Config can change the default mode, default count, default range, and default bullet character.' "mkdir -p '$artifacts'; printf \"default_mode='lines'\ndefault_line_count=3\ndefault_line_range='2-2'\ndefault_bullet_char='*'\n\" > '$artifacts/defaults-config.zsh'; LIPSUM_CONFIG='$artifacts/defaults-config.zsh' $lp -b -n -l | awk '/^\*/ { print NF - 1; if (NF - 1 != 2) bad=1; count++ } END { if (count != 3 || bad) exit 1 }'"
register_case 'TC35' 'Config' 'Config can change the default command for bare invocation.' "mkdir -p '$artifacts'; printf \"default_mode='characters'\ndefault_character_count=20\n\" > '$artifacts/mode-config.zsh'; LIPSUM_CONFIG='$artifacts/mode-config.zsh' $lp -n -l | tr -d '\n' | wc -m | awk '{ print \$1; if (\$1 != 20) exit 1 }'"
register_case 'TC36' 'Config' 'Default word-length range applies to words output when no explicit range is provided.' "mkdir -p '$artifacts'; printf \"default_word_length_range='3-4'\n\" > '$artifacts/word-range-config.zsh'; LIPSUM_CONFIG='$artifacts/word-range-config.zsh' $lp 5 words -n -l | awk '{ for (i = 1; i <= NF; i++) { if (length(\$i) < 3 || length(\$i) > 4) bad=1 } } END { print NF; if (bad) exit 1 }'"
register_case 'TC37' 'Copy' 'Explicit copy writes the same content to the clipboard target and stdout.' "mkdir -p '$artifacts'; rm -f '$artifacts/clipboard-explicit.txt'; out=\"\$(LIPSUM_CLIPBOARD_COMMAND=\"sh -c 'cat > \\\"\\\$1\\\"' _ '$artifacts/clipboard-explicit.txt'\" $lp 4 w -c -n -l)\"; clip=\"\$(cat '$artifacts/clipboard-explicit.txt')\"; printf 'stdout=%s\nclipboard=%s\n' \"\$out\" \"\$clip\"; [[ \"\$out\" == \"\$clip\" ]]"
register_case 'TC38' 'Copy' 'Config can enable copy by default.' "mkdir -p '$artifacts'; printf \"copy_on_generate=1\n\" > '$artifacts/copy-config.zsh'; rm -f '$artifacts/clipboard-config.txt'; out=\"\$(LIPSUM_CONFIG='$artifacts/copy-config.zsh' LIPSUM_CLIPBOARD_COMMAND=\"sh -c 'cat > \\\"\\\$1\\\"' _ '$artifacts/clipboard-config.txt'\" $lp 4 w -n -l)\"; clip=\"\$(cat '$artifacts/clipboard-config.txt')\"; printf 'stdout=%s\nclipboard=%s\n' \"\$out\" \"\$clip\"; [[ \"\$out\" == \"\$clip\" ]]"
register_case 'TC39' 'Copy' 'Explicit no-copy overrides config-driven clipboard copying.' "mkdir -p '$artifacts'; printf \"copy_on_generate=1\n\" > '$artifacts/no-copy-config.zsh'; rm -f '$artifacts/clipboard-no-copy.txt'; out=\"\$(LIPSUM_CONFIG='$artifacts/no-copy-config.zsh' LIPSUM_CLIPBOARD_COMMAND=\"sh -c 'cat > \\\"\\\$1\\\"' _ '$artifacts/clipboard-no-copy.txt'\" $lp 4 w --no-copy -n -l)\"; printf 'stdout=%s\nclipboard_exists=%s\n' \"\$out\" \"\$(test -e '$artifacts/clipboard-no-copy.txt'; echo \$?)\"; [[ ! -e '$artifacts/clipboard-no-copy.txt' ]]"
register_case 'TC40' 'Errors' 'Unknown long options fail with a usage error.' "$lp --wat"
register_case 'TC41' 'Errors' 'Removed long mode flags are rejected.' "$lp --words=7"
register_case 'TC42' 'Errors' 'Removed short mode flags are rejected.' "$lp -w 7"
register_case 'TC43' 'Errors' 'Invalid internal range syntax is rejected.' "$lp 2 lines -r abc"
register_case 'TC44' 'Errors' 'A reversed internal range is rejected.' "$lp 1 s --range 10-5"
register_case 'TC45' 'Errors' 'Zero counts are rejected.' "$lp 0 words"
register_case 'TC46' 'Errors' 'Multiple counts are rejected.' "$lp 2 3 words"
register_case 'TC47' 'Errors' 'Multiple commands are rejected.' "$lp words lines"
register_case 'TC48' 'Errors' 'Ordered lists are rejected for non-line modes.' "$lp 5 words -o"
register_case 'TC49' 'Errors' 'Bullets and ordered lists cannot be combined.' "$lp 3 lines -b -o"
register_case 'TC50' 'Errors' 'Unknown command names fail cleanly.' "$lp banana"
register_case 'TC51' 'Errors' 'Oversized character requests hit the configured safety cap.' "$lp 250000 c"
register_case 'TC52' 'Errors' 'Invalid config values fail cleanly on the next run.' "mkdir -p '$artifacts'; printf \"default_line_range='9-2'\n\" > '$artifacts/bad-config.zsh'; LIPSUM_CONFIG='$artifacts/bad-config.zsh' $lp 1 lines"
register_case 'TC53' 'Shell Integration' 'A for-loop can generate progressively longer exact bullet lines.' "for n in 3 4 5; do $lp 1 l -r \"\$n\" -b; done"
register_case 'TC54' 'Shell Integration' 'Piped numeric input can drive sentence generation through a while-read loop.' "printf '4\n6\n' | while read -r n; do $lp 1 s -r \"\$n\" -l; done"
register_case 'TC55' 'Shell Integration' 'Piped numeric input can drive line generation through xargs.' "printf '3\n5\n' | xargs -I{} zsh -c \"$lp 1 lines -r \\\"\\\$1\\\" -b\" _ {}"
register_case 'TC56' 'Shell Integration' 'Command substitution can inline generated text inside another command.' "printf '[%s]\n' \"\$($lp 4 w -n -l)\""
register_case 'TC57' 'Shell Integration' 'Direct stdin piping into lipsum is harmless and the command still produces stdout.' "printf 'stdin is ignored here\n' | $lp 5 w"
register_case 'TC58' 'Shell Integration' 'Paragraph output can be piped into fold for visual wrapping.' "$lp 1 p | fold -s -w 40"
register_case 'TC59' 'Shell Integration' 'Bullet output can be piped into line numbering for visual review.' "$lp 4 l -b | nl -ba"
register_case 'TC60' 'Shell Integration' 'Word output can be piped into newline transforms for tokenized display.' "$lp 8 w -n -l | tr ' ' '\n'"
register_case 'TC61' 'Sources' 'The sources action separates built-in and imported sources and includes sample paragraphs.' "tmp_home=\"\$(mktemp -d)\"; mkdir -p \"\$tmp_home/.lipsum/sources\"; cp '$project_dir/share/sources/'*.words \"\$tmp_home/.lipsum/sources/\"; printf 'atlas ember harbor signal twilight\n' > \"\$tmp_home/.lipsum/sources/custom-demo.words\"; out=\"\$(HOME=\"\$tmp_home\" $lp sources)\"; printf '%s\n' \"\$out\"; printf '%s\n' \"\$out\" | grep -F 'Built-In Sources:' >/dev/null && printf '%s\n' \"\$out\" | grep -F 'Imported Sources:' >/dev/null && printf '%s\n' \"\$out\" | grep -F 'Lorem Ipsum (lorem) [default]' >/dev/null && printf '%s\n' \"\$out\" | grep -F 'Tech Ipsum (tech)' >/dev/null && printf '%s\n' \"\$out\" | grep -F 'Corporate Ipsum (corporate)' >/dev/null && printf '%s\n' \"\$out\" | grep -F 'Custom Demo (custom-demo)' >/dev/null; rc=\$?; rm -rf \"\$tmp_home\"; exit \$rc"
register_case 'TC62' 'Sources' 'The long source option selects a named source corpus for one invocation.' "HOME=\"\$(mktemp -d)\" LIPSUM_SOURCE_DIR='$project_dir/share/sources' LIPSUM_DICT='$project_dir/share/lorem.words' $lp --source hipster 6 words -n -l | tr ' ' '\n' | awk 'NR==FNR { for (i = 1; i <= NF; i++) seen[\$i]=1; next } NF { if (!seen[\$1]) bad=1 } END { exit bad }' '$project_dir/share/sources/hipster.words' -"
register_case 'TC63' 'Sources' 'The short source option selects another named source corpus.' "HOME=\"\$(mktemp -d)\" LIPSUM_SOURCE_DIR='$project_dir/share/sources' LIPSUM_DICT='$project_dir/share/lorem.words' $lp -s tech 6 words -n -l | tr ' ' '\n' | awk 'NR==FNR { for (i = 1; i <= NF; i++) seen[\$i]=1; next } NF { if (!seen[\$1]) bad=1 } END { exit bad }' '$project_dir/share/sources/tech.words' -"
register_case 'TC64' 'Sources' 'Config can change the default source for bare and explicit generation.' "mkdir -p '$artifacts'; printf \"default_source='corporate'\n\" > '$artifacts/source-config.zsh'; LIPSUM_CONFIG='$artifacts/source-config.zsh' LIPSUM_SOURCE_DIR='$project_dir/share/sources' LIPSUM_DICT='$project_dir/share/lorem.words' $lp 6 words -n -l | tr ' ' '\n' | awk 'NR==FNR { for (i = 1; i <= NF; i++) seen[\$i]=1; next } NF { if (!seen[\$1]) bad=1 } END { exit bad }' '$project_dir/share/sources/corporate.words' -"
register_case 'TC65' 'Installer' 'Installer syntax checks cleanly.' "zsh -n $ip"
register_case 'TC66' 'Installer' 'Defaults mode installs the executable, config, corpus, bundled sources, and support directories into a temp HOME.' "tmp_home=\"\$(mktemp -d)\"; HOME=\"\$tmp_home\" zsh $ip --yes >/tmp/lipsum-installer-defaults.out; rc=\$?; cat /tmp/lipsum-installer-defaults.out; test -x \"\$tmp_home/.local/bin/lipsum\" && test -f \"\$tmp_home/.lipsum/config\" && test -f \"\$tmp_home/.lipsum/words\" && test -f \"\$tmp_home/.lipsum/sources/lorem.words\" && test -f \"\$tmp_home/.lipsum/sources/hipster.words\" && test -f \"\$tmp_home/.lipsum/sources/tech.words\" && test -f \"\$tmp_home/.lipsum/sources/pirate.words\" && test -f \"\$tmp_home/.lipsum/sources/food.words\" && test -f \"\$tmp_home/.lipsum/sources/corporate.words\" && test -f \"\$tmp_home/.lipsum/sources/de.words\" && test -d \"\$tmp_home/.lipsum/templates\" && HOME=\"\$tmp_home\" \"\$tmp_home/.local/bin/lipsum\" 4 words -n -l; verify_rc=\$?; rm -rf \"\$tmp_home\" /tmp/lipsum-installer-defaults.out; exit \$(( rc || verify_rc ))"
register_case 'TC67' 'Installer' 'Interactive mode accepts step-by-step input and can change the default mode before installation.' "tmp_home=\"\$(mktemp -d)\"; answers=\$(printf 'lines\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n'); out=\"\$(printf '%s' \"\$answers\" | HOME=\"\$tmp_home\" zsh $ip --interactive 2>&1)\"; rc=\$?; printf '%s\n' \"\$out\"; HOME=\"\$tmp_home\" \"\$tmp_home/.local/bin/lipsum\" -b -n -l | awk '/^./ { count++ } END { print count; if (count != 5) exit 1 }'; verify_rc=\$?; rm -rf \"\$tmp_home\"; exit \$(( rc || verify_rc ))"
register_case 'TC68' 'Installer' 'Editor-config mode creates a config file, validates it, and leaves a working installed executable.' "tmp_home=\"\$(mktemp -d)\"; EDITOR='true' HOME=\"\$tmp_home\" zsh $ip --editor-config >/tmp/lipsum-installer-editor.out 2>&1; rc=\$?; cat /tmp/lipsum-installer-editor.out; test -f \"\$tmp_home/.lipsum/config\" && HOME=\"\$tmp_home\" \"\$tmp_home/.local/bin/lipsum\" 3 words -n -l; verify_rc=\$?; rm -rf \"\$tmp_home\" /tmp/lipsum-installer-editor.out; exit \$(( rc || verify_rc ))"
register_case 'TC69' 'Custom Sources' 'Inline text can be used as a one-off source corpus.' "$lp --text 'alpha beta gamma delta epsilon' 5 words -n -l | tr ' ' '\n' | awk 'NR==FNR { for (i = 1; i <= NF; i++) seen[\$i]=1; next } NF { if (!seen[\$1]) bad=1 } END { exit bad }' <(printf 'alpha beta gamma delta epsilon\n') -"
register_case 'TC70' 'Custom Sources' 'A file can provide a one-off source corpus.' "tmp='\$(mktemp)'; printf 'maple river lantern harbor velvet canyon' > \"\$tmp\"; out=\"\$($lp --file \"\$tmp\" 5 words -n -l | tr ' ' '\n' | awk 'NR==FNR { for (i = 1; i <= NF; i++) seen[\$i]=1; next } NF { if (!seen[\$1]) bad=1 } END { exit bad }' \"\$tmp\" - 2>&1)\"; rc=\$?; rm -f \"\$tmp\"; printf '%s\n' \"\$out\"; exit \$rc"
register_case 'TC71' 'Custom Sources' 'Stdin can provide a one-off source corpus via --text -.' "printf 'violet cedar ember meadow signal\n' | $lp --text - 5 words -n -l | tr ' ' '\n' | awk 'NR==FNR { for (i = 1; i <= NF; i++) seen[\$i]=1; next } NF { if (!seen[\$1]) bad=1 } END { exit bad }' <(printf 'violet cedar ember meadow signal\n') -"
register_case 'TC72' 'Custom Sources' 'Custom input can be saved as a reusable named source.' "tmp_home=\"\$(mktemp -d)\"; first=\"\$(HOME=\"\$tmp_home\" $lp --text 'atlas ember harbor signal twilight' --save-source customdemo 5 words -n -l)\"; second=\"\$(HOME=\"\$tmp_home\" $lp --source customdemo 5 words -n -l)\"; printf 'first=%s\nsecond=%s\n' \"\$first\" \"\$second\"; test -f \"\$tmp_home/.lipsum/sources/customdemo.words\"; rc=\$?; rm -rf \"\$tmp_home\"; exit \$rc"
register_case 'TC73' 'Errors' 'Custom source input and named source selection cannot be combined.' "$lp --source hipster --text 'alpha beta gamma' 3 words"
register_case 'TC74' 'Errors' 'Saving a source without custom input fails cleanly.' "$lp --save-source customdemo 3 words"

mkdir -p "$artifacts"
write_header

local -i i=1
while (( i <= ${#case_ids[@]} )); do
  run_case "${case_ids[i]}" "${case_categories[i]}" "${case_summaries[i]}" "${case_commands[i]}"
  (( i++ ))
done
