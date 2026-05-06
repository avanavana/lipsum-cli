#!/bin/zsh

emulate -L zsh
setopt pipe_fail

typeset script_dir="${0:A:h}"
typeset default_emoji_charset='😀 😅 😂 🤣 🥲 🙂 😍 😛 🤓 😎 🤩 🥳 😕 🙁 😭 😡 🤔 🫡 😬 🙄 😮 💩 💀 🤖 🫶 🙌 👏 👍 👎 🤌 💪 🦾 🙏 👀 🧠 🧌 🤦 💅 👯‍♀️ 🧵 🌹 🌙 ✨ 🔥 💦 🍑 🍆 🍺 🍻 🏆 ✈️ 🚀 💡 💸 💎 🎉 🩷 ❤️ 💜 🖤 💔 ❌ 💯 ✅ 😀 😅 😂 🙂 😍 👏 👍 🙏 🤦 💅 ✨ 🔥 🚀 💡 🎉 ❤️ 💯 ✅ 😀 😅 😂 🙂 😍 👏 👍 🙏 🤦 💅 ✨ 🔥 🚀 💡 🎉 ❤️ 💯 ✅ 😀 😅 😂 🙂 😍 👏 👍 🙏 🤦 💅 ✨ 🔥 🚀 💡 🎉 ❤️ 💯 ✅ 😀 😅 😂 🙂 😍 👏 👍 🙏 🤦 💅 ✨ 🔥 🚀 💡 🎉 ❤️ 💯 ✅ 😀 😅 😂 🙂 😍 👏 👍 🙏 🤦 💅 ✨ 🔥 🚀 💡 🎉 ❤️ 💯 ✅ 😀 😅 😂 🙂 😍 👏 👍 🙏 🤦 💅 ✨ 🔥 🚀 💡 🎉 ❤️ 💯 ✅ 😀 😅 😂 🙂 😍 👏 👍 🙏 🤦 💅 ✨ 🔥 🚀 💡 🎉 ❤️ 💯 ✅'
typeset local_lipsum="$script_dir/lipsum"
typeset local_words="$script_dir/share/lorem.words"
typeset local_sources_dir="$script_dir/share/sources"
typeset raw_base_url="${LIPSUM_INSTALL_RAW_BASE:-https://raw.githubusercontent.com/avanavana/lipsum-cli/main}"
typeset -a bundled_source_names=( hipster tech pirate food corporate es fr de )

typeset install_mode=''
typeset bin_dir="${LIPSUM_INSTALL_BIN_DIR:-$HOME/.local/bin}"
typeset config_dir="$HOME/.lipsum"
typeset config_path="$config_dir/config"
typeset words_path="$config_dir/words"
typeset sources_dir="$config_dir/sources"
typeset templates_dir="$config_dir/templates"
typeset target_script="$bin_dir/lipsum"
typeset source_script=''
typeset bundled_words=''
typeset bundled_sources_dir=''
typeset staged_dir=''
typeset editor_cmd="${VISUAL:-${EDITOR:-vi}}"
typeset -i tty_fd=-1

typeset default_mode='words'
typeset default_word_count=10
typeset default_character_count=32
typeset default_line_count=5
typeset default_sentence_count=4
typeset default_paragraph_count=3
typeset default_line_range='4-8'
typeset default_sentence_range='6-14'
typeset default_paragraph_range='3-5'
typeset default_word_length_range='1-12'
typeset default_paragraph_sentence_word_range='6-14'
typeset default_bullet_char='–'
typeset default_ordered_list_format='%d.'
typeset punctuation_mode='period'
typeset copy_on_generate=0
typeset emoji_enabled=0
typeset emoji_charset="$default_emoji_charset"
typeset default_source='lorem'

die () {
  print -u2 -- "Error: $1"
  exit 1
}

print_help () {
  cat <<EOF
Usage: install.sh [ options ]

Install options:
  --yes, --defaults      Install immediately with default configuration.
  --interactive, --guided
                          Run the step-by-step configuration prompts.
  --editor-config        Open the config file in \$VISUAL, \$EDITOR, or vi.
  --bin-dir <path>       Install the executable to a custom bin directory.
  --help                 Show this help text.

With no flags, the installer shows an interactive menu when a TTY is available.
In non-interactive shells, it falls back to defaults mode.
EOF
}

setup_tty () {
  if [[ -r /dev/tty && -w /dev/tty ]]; then
    { exec {tty_fd}<> /dev/tty; } 2>/dev/null || tty_fd=-1
  fi
}

read_line () {
  local prompt="$1"
  local reply=''

  if (( tty_fd >= 0 )); then
    print -u $tty_fd -n -- "$prompt"
    IFS= read -r -u $tty_fd reply
  else
    print -n -- "$prompt"
    IFS= read -r reply
  fi

  REPLY="$reply"
}

read_key () {
  local key=''

  if (( tty_fd >= 0 )); then
    read -r -s -k 1 -u $tty_fd key
  else
    read -r -s -k 1 key
  fi

  REPLY="$key"
}

download_file () {
  local url="$1"
  local destination="$2"

  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$url" -o "$destination" || die "Could not download $url"
    return
  fi

  if command -v wget >/dev/null 2>&1; then
    wget -qO "$destination" "$url" || die "Could not download $url"
    return
  fi

  die "curl or wget is required when installer payloads are not available locally"
}

prepare_payloads () {
  if [[ -r $local_lipsum && -r $local_words && -d $local_sources_dir ]]; then
    source_script="$local_lipsum"
    bundled_words="$local_words"
    bundled_sources_dir="$local_sources_dir"
    return
  fi

  staged_dir="$(mktemp -d "${TMPDIR:-/tmp}/lipsum-installer.XXXXXX")" || die "Could not create a staging directory"
  source_script="$staged_dir/lipsum"
  bundled_words="$staged_dir/lorem.words"
  bundled_sources_dir="$staged_dir/sources"

  download_file "$raw_base_url/lipsum" "$source_script"
  download_file "$raw_base_url/share/lorem.words" "$bundled_words"
  mkdir -p "$bundled_sources_dir" || die "Could not create staged source directory"
  local source_name=''
  for source_name in "${bundled_source_names[@]}"; do
    download_file "$raw_base_url/share/sources/$source_name.words" "$bundled_sources_dir/$source_name.words"
  done
  chmod 755 "$source_script" || die "Could not mark staged lipsum executable"
}

cleanup () {
  if [[ -n $staged_dir && -d $staged_dir ]]; then
    rm -rf "$staged_dir"
  fi
}

trap cleanup EXIT

write_config_file () {
  local destination="$1"

  cat > "$destination" <<EOF
# lipsum config
# This file is sourced by the lipsum zsh script. Keep values shell-friendly.

default_mode='$default_mode'

default_word_count=$default_word_count
default_character_count=$default_character_count
default_line_count=$default_line_count
default_sentence_count=$default_sentence_count
default_paragraph_count=$default_paragraph_count

default_line_range='$default_line_range'
default_sentence_range='$default_sentence_range'
default_paragraph_range='$default_paragraph_range'
default_word_length_range='$default_word_length_range'
default_paragraph_sentence_word_range='$default_paragraph_sentence_word_range'

default_bullet_char='$default_bullet_char'
default_ordered_list_format='$default_ordered_list_format'
punctuation_mode='$punctuation_mode'
copy_on_generate=$copy_on_generate
emoji_enabled=$emoji_enabled
emoji_charset='$emoji_charset'

# Reserved for future source selection support.
default_source='$default_source'
EOF
}

validate_config_file () {
  local candidate="$1"

  LIPSUM_CONFIG="$candidate" LIPSUM_DICT="$bundled_words" "$source_script" 1 words -p none >/dev/null 2>&1
}

preview_with_config () {
  local temp_config=''

  temp_config="$(mktemp "${TMPDIR:-/tmp}/lipsum-config-preview.XXXXXX")" || die "Could not create preview config"
  write_config_file "$temp_config"

  LIPSUM_CONFIG="$temp_config" LIPSUM_DICT="$bundled_words" "$source_script" "$@" 2>/dev/null
  rm -f "$temp_config"
}

show_preview () {
  print -- ''
  print -- 'Preview:'
  preview_with_config "$@"
  print -- ''
}

is_installer_source_name () {
  local name="$1"
  local source_name=''

  name="${(L)name}"

  if [[ $name == 'lorem' ]]; then
    return 0
  fi

  for source_name in "${bundled_source_names[@]}"; do
    if [[ $name == $source_name ]]; then
      return 0
    fi
  done

  return 1
}

installer_source_summary () {
  REPLY="lorem ${(j: :)bundled_source_names}"
}

prompt_header () {
  print -- ''
  print -- "$1"
  print -- "$2"
}

prompt_choice_default_mode () {
  while :; do
    prompt_header 'Default mode' 'This controls what a bare `lipsum` command generates.'
    show_preview
    read_line "Default mode [${default_mode}] (words/characters/lines/sentences/paragraphs): "

    if [[ -z $REPLY ]]; then
      return
    fi

    case "$REPLY" in
      words|characters|lines|sentences|paragraphs)
        default_mode="$REPLY"
        return
        ;;
      *)
        print -u2 -- 'Please enter words, characters, lines, sentences, or paragraphs.'
        ;;
    esac
  done
}

prompt_choice_default_source () {
  local source_names=''

  installer_source_summary
  source_names="$REPLY"

  while :; do
    prompt_header 'Default source' "Choose the source corpus used by default. Available: $source_names."
    show_preview 6 words -p none -l
    read_line "Default source [${default_source}]: "

    if [[ -z $REPLY ]]; then
      return
    fi

    if is_installer_source_name "$REPLY"; then
      default_source="${(L)REPLY}"
      return
    fi

    print -u2 -- "Please enter one of: $source_names"
  done
}

prompt_positive_integer () {
  local var_name="$1"
  local label="$2"
  local explanation="$3"
  shift 3

  while :; do
    prompt_header "$label" "$explanation"
    show_preview "$@"
    read_line "$label [${(P)var_name}]: "

    if [[ -z $REPLY ]]; then
      return
    fi

    if [[ $REPLY == <-> && $REPLY -gt 0 ]]; then
      typeset -g "$var_name=$REPLY"
      return
    fi

    print -u2 -- 'Please enter a positive integer.'
  done
}

prompt_range () {
  local var_name="$1"
  local label="$2"
  local explanation="$3"
  shift 3

  while :; do
    prompt_header "$label" "$explanation"
    show_preview "$@"
    read_line "$label [${(P)var_name}]: "

    if [[ -z $REPLY ]]; then
      return
    fi

    if [[ $REPLY == <-> || $REPLY == <->-<-> ]]; then
      local min="${REPLY%%-*}"
      local max="${REPLY##*-}"
      if [[ $REPLY == <-> ]]; then
        min="$REPLY"
        max="$REPLY"
      fi

      if (( min > 0 && max > 0 && min <= max )); then
        typeset -g "$var_name=$REPLY"
        return
      fi
    fi

    print -u2 -- 'Please enter a positive integer or a min-max range.'
  done
}

prompt_text_value () {
  local var_name="$1"
  local label="$2"
  local explanation="$3"
  shift 3

  while :; do
    prompt_header "$label" "$explanation"
    show_preview "$@"
    read_line "$label [${(P)var_name}]: "

    if [[ -z $REPLY ]]; then
      return
    fi

    typeset -g "$var_name=$REPLY"
    return
  done
}

prompt_copy_default () {
  local default_answer='no'

  if (( copy_on_generate == 1 )); then
    default_answer='yes'
  fi

  while :; do
    prompt_header 'Copy on generate' 'When enabled, lipsum copies output to the clipboard and still prints it.'
    print -- ''
    print -- "Current default: $([[ $copy_on_generate == 1 ]] && print yes || print no)"
    print -- ''
    read_line "Copy on generate [$default_answer] (yes/no): "

    if [[ -z $REPLY ]]; then
      return
    fi

    case "${(L)REPLY}" in
      y|yes)
        copy_on_generate=1
        return
        ;;
      n|no)
        copy_on_generate=0
        return
        ;;
      *)
        print -u2 -- 'Please answer yes or no.'
        ;;
    esac
  done
}

run_guided_setup () {
  prompt_choice_default_mode
  prompt_choice_default_source
  prompt_positive_integer default_word_count 'Default word count' 'Used when your default mode is words and you run `lipsum` with no count.' words
  prompt_positive_integer default_character_count 'Default character count' 'Used when your default mode is characters and you run `lipsum` with no count.' characters -p none
  prompt_positive_integer default_line_count 'Default line count' 'Used when your default mode is lines and you run `lipsum` with no count.' lines -b
  prompt_positive_integer default_sentence_count 'Default sentence count' 'Used when your default mode is sentences and you run `lipsum` with no count.' sentences
  prompt_positive_integer default_paragraph_count 'Default paragraph count' 'Used when your default mode is paragraphs and you run `lipsum` with no count.' paragraphs
  prompt_range default_word_length_range 'Default word length range' 'Controls the character length of generated words when no explicit range is provided.' 6 words -p none -l
  prompt_range default_line_range 'Default line range' 'Controls the number of words in each generated line.' 3 lines -b -p none -l
  prompt_range default_sentence_range 'Default sentence range' 'Controls the number of words in each generated sentence.' 2 sentences -l
  prompt_range default_paragraph_range 'Default paragraph range' 'Controls the number of sentences in each generated paragraph.' 2 paragraphs
  prompt_range default_paragraph_sentence_word_range 'Default paragraph sentence word range' 'Controls the number of words in each sentence inside paragraph output.' 1 paragraphs
  prompt_text_value default_bullet_char 'Default bullet character' 'Used by `lipsum lines -b` when no explicit bullet character is provided.' 3 lines -b -p none -l
  prompt_text_value default_ordered_list_format 'Default ordered list format' 'Used by `lipsum lines -o` when no explicit ordered marker format is provided.' 3 lines -o
  prompt_copy_default
}

choose_install_mode () {
  if [[ -n $install_mode ]]; then
    return
  fi

  if (( tty_fd < 0 )); then
    install_mode='defaults'
    return
  fi

  local -a options=( 'defaults' 'interactive mode' 'custom config in $EDITOR' )
  local -i selected=1
  local key=''
  local rest=''

  while :; do
    if command -v clear >/dev/null 2>&1; then
      clear
    else
      print -- $'\e[2J\e[H'
    fi

    print -- 'Install lipsum and configure with:'
    print -- ''

    local -i i=1
    while (( i <= ${#options[@]} )); do
      if (( i == selected )); then
        print -- "> ${options[i]}"
      else
        print -- "  ${options[i]}"
      fi
      (( i++ ))
    done

    print -- ''
    print -- 'Use arrow keys and press Enter.'

    read_key
    key="$REPLY"

    case "$key" in
      '')
        case $selected in
          1) install_mode='defaults' ;;
          2) install_mode='interactive' ;;
          3) install_mode='editor-config' ;;
        esac
        return
        ;;
      $'\n'|$'\r')
        case $selected in
          1) install_mode='defaults' ;;
          2) install_mode='interactive' ;;
          3) install_mode='editor-config' ;;
        esac
        return
        ;;
      k)
        (( selected > 1 )) && (( selected-- ))
        ;;
      j)
        (( selected < ${#options[@]} )) && (( selected++ ))
        ;;
      1)
        install_mode='defaults'
        return
        ;;
      2)
        install_mode='interactive'
        return
        ;;
      3)
        install_mode='editor-config'
        return
        ;;
      $'\e')
        if (( tty_fd >= 0 )); then
          read -r -s -k 2 -u $tty_fd rest
        else
          read -r -s -k 2 rest
        fi

        case "$rest" in
          '[A')
            (( selected > 1 )) && (( selected-- ))
            ;;
          '[B')
            (( selected < ${#options[@]} )) && (( selected++ ))
            ;;
        esac
        ;;
    esac
  done
}

ensure_directories () {
  mkdir -p "$bin_dir" "$config_dir" "$sources_dir" "$templates_dir" || die 'Could not create installation directories'
}

install_executable () {
  cp "$source_script" "$target_script" || die "Could not install lipsum to $target_script"
  chmod 755 "$target_script" || die "Could not mark $target_script executable"
}

install_corpus_files () {
  if [[ ! -e $words_path ]]; then
    cp "$bundled_words" "$words_path" || die "Could not install default corpus to $words_path"
  fi

  if [[ ! -e $sources_dir/lorem.words ]]; then
    cp "$bundled_words" "$sources_dir/lorem.words" || die "Could not install bundled source corpus"
  fi

  local source_name=''
  for source_name in "${bundled_source_names[@]}"; do
    if [[ ! -e $sources_dir/$source_name.words ]]; then
      cp "$bundled_sources_dir/$source_name.words" "$sources_dir/$source_name.words" || die "Could not install bundled source corpus: $source_name"
    fi
  done
}

backup_existing_config () {
  if [[ -e $config_path ]]; then
    local backup_path="$config_path.bak.$(date '+%Y%m%d%H%M%S')"
    cp "$config_path" "$backup_path" || die "Could not back up existing config to $backup_path"
    print -- "Backed up existing config to $backup_path"
  fi
}

write_installer_config () {
  backup_existing_config
  write_config_file "$config_path" || die "Could not write config file"

  validate_config_file "$config_path" || die 'The generated config did not validate'
}

open_config_in_editor () {
  if [[ ! -e $config_path ]]; then
    write_config_file "$config_path" || die "Could not create config file"
  fi

  while :; do
    zsh -fc "setopt nonomatch; $editor_cmd ${(q)config_path}" || die 'Editor command failed'

    if validate_config_file "$config_path"; then
      return
    fi

    print -u2 -- ''
    print -u2 -- "The config at $config_path is not valid yet."
    read_line 'Re-open the config in the editor? [Y/n]: '

    case "${(L)REPLY}" in
      ''|y|yes)
        ;;
      *)
        die 'Installation aborted with invalid config'
        ;;
    esac
  done
}

show_path_hint () {
  local found=0
  local entry=''

  for entry in $path; do
    if [[ $entry == $bin_dir ]]; then
      found=1
      break
    fi
  done

  if (( ! found )); then
    print -- ''
    print -- "Add $bin_dir to your PATH to run lipsum directly."
  fi
}

print_summary () {
  print -- ''
  print -- 'Installed lipsum-cli.'
  print -- "Executable: $target_script"
  print -- "Config:     $config_path"
  print -- "Corpus:     $words_path"
  print -- "Sources:    $sources_dir"
  print -- "Templates:  $templates_dir"
  show_path_hint
}

while (( $# > 0 )); do
  case "$1" in
    --yes|--defaults)
      install_mode='defaults'
      ;;
    --interactive)
      install_mode='interactive'
      ;;
    --guided)
      install_mode='interactive'
      ;;
    --editor-config)
      install_mode='editor-config'
      ;;
    --bin-dir)
      [[ -n $2 ]] || die 'Missing path for --bin-dir'
      bin_dir="$2"
      target_script="$bin_dir/lipsum"
      shift
      ;;
    --help)
      print_help
      exit 0
      ;;
    *)
      die "Unknown installer option: $1"
      ;;
  esac
  shift
done

setup_tty
prepare_payloads
choose_install_mode
ensure_directories
install_executable
install_corpus_files

case "$install_mode" in
  defaults)
    write_installer_config
    ;;
  interactive)
    run_guided_setup
    write_installer_config
    ;;
  editor-config)
    open_config_in_editor
    ;;
  *)
    die "Unknown install mode: $install_mode"
    ;;
esac

print_summary
