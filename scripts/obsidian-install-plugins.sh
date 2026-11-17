#!/usr/bin/env bash
# Install every plugin listed in a vault's .obsidian/community-plugins.json.
# The vault's .gitignore excludes .obsidian/plugins/*, so a fresh clone has the
# list of enabled plugins but none of their files. This downloads the latest
# release (main.js, manifest.json, styles.css) of each one from GitHub.
#
# Usage: obsidian-install-plugins.sh [vault-path]
# Safe to re-run: plugins that already have a main.js are skipped.
# Plugin settings (data.json) are NOT restored; they start at defaults.
set -euo pipefail

VAULT="${1:-/mnt/c/Users/louis/Documents/vault}"
LIST="$VAULT/.obsidian/community-plugins.json"
DEST="$VAULT/.obsidian/plugins"
REGISTRY="https://raw.githubusercontent.com/obsidianmd/obsidian-releases/master/community-plugins.json"

# Plugins that are not in the official registry: id -> GitHub owner/repo.
declare -A EXTRA_REPOS=(
  [scroll-with-jk]="LukasKorotaj/Scroll-With-j-k-in-Obsidian"
)

for cmd in curl jq; do
  command -v "$cmd" >/dev/null || { echo "missing: $cmd" >&2; exit 1; }
done
[ -f "$LIST" ] || { echo "not found: $LIST" >&2; exit 1; }

registry="$(mktemp)"
trap 'rm -f "$registry"' EXIT
curl -fsSL "$REGISTRY" -o "$registry"

mkdir -p "$DEST"
installed=() skipped=() failed=()

while IFS= read -r id; do
  [ -n "$id" ] || continue
  if [ -f "$DEST/$id/main.js" ]; then
    skipped+=("$id"); continue
  fi
  repo="${EXTRA_REPOS[$id]:-}"
  [ -n "$repo" ] || repo="$(jq -r --arg id "$id" '.[] | select(.id == $id) | .repo' "$registry")"
  if [ -z "$repo" ]; then
    echo "!! $id: not in the community registry (beta/BRAT or local plugin?)"
    failed+=("$id"); continue
  fi
  echo "-> $id ($repo)"
  tmp="$(mktemp -d)"
  base="https://github.com/$repo/releases/latest/download"
  if curl -fsSL "$base/main.js" -o "$tmp/main.js" \
     && curl -fsSL "$base/manifest.json" -o "$tmp/manifest.json"; then
    curl -fsSL "$base/styles.css" -o "$tmp/styles.css" 2>/dev/null || rm -f "$tmp/styles.css"
    mkdir -p "$DEST/$id"
    cp "$tmp"/* "$DEST/$id/"
    installed+=("$id")
  else
    echo "!! $id: download failed"
    failed+=("$id")
  fi
  rm -rf "$tmp"
done < <(jq -r '.[]' "$LIST")

echo
echo "installed: ${#installed[@]}  skipped: ${#skipped[@]}  failed: ${#failed[@]}"
[ ${#failed[@]} -eq 0 ] || { printf 'failed: %s\n' "${failed[@]}"; exit 2; }
