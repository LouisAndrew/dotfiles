#!/usr/bin/env bash
# Build "CommitMono" from the commitmono.com source fonts and "CommitMono Nonicons"
# from it, into <out_dir>. The settings are in build_commit_mono.py.
set -euo pipefail

out_dir=${1:?usage: build-fonts.sh <out_dir>}
DOTFILES_PATH=${DOTFILES_PATH:-"$(cd "$(dirname "$0")/.." && pwd)"}

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
mkdir -p "$out_dir"

python3 -m venv "$tmp/venv"
"$tmp/venv/bin/pip" install -q fonttools
"$tmp/venv/bin/python" "$DOTFILES_PATH/scripts/build_commit_mono.py" "$out_dir"
curl -fsSL -o "$tmp/nonicons.ttf" "https://raw.githubusercontent.com/ya2s/nonicons/master/dist/nonicons.ttf"
"$tmp/venv/bin/python" "$DOTFILES_PATH/scripts/patch_nonicons.py" "$tmp/nonicons.ttf" "$out_dir" "$out_dir"/CommitMono-*.otf
