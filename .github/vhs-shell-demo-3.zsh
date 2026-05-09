#!/bin/zsh

set -euo pipefail

typeset original_home="$HOME"
typeset demo_home=''

demo_home="$(mktemp -d)"
mkdir -p "$demo_home/.lipsum"
cp "$original_home/.lipsum/words" "$demo_home/.lipsum/words"
cp -R "$original_home/.lipsum/sources" "$demo_home/.lipsum/"
mkdir -p "$demo_home/.lipsum/templates"

cat > "$demo_home/.zshrc" <<'EOF'
PROMPT='%F{#737373}> %f'
EOF

export HOME="$demo_home"
export PATH="/usr/local/bin:$PATH"
export ZDOTDIR="$demo_home"
export EDITOR=true

exec /bin/zsh -i
