#!/bin/zsh

set -euo pipefail

[[ $# -ge 1 ]] || exit 1
cat > "$1"
