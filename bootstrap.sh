#!/usr/bin/env bash
# Usage: DOTFILES_PATH=~/dotfiles ./bootstrap.sh
export DOTFILES_PATH="${DOTFILES_PATH:-$(cd "$(dirname "$0")" && pwd)}"

for file in "$DOTFILES_PATH"/bootstrap/*.sh; do
    . "$file"
done
