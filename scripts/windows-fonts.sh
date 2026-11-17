#!/usr/bin/env bash
# On WSL, build "CommitMono Nonicons" and install it for the Windows user, so
# Windows apps such as the Herdr app can use it. Per-user fonts need no admin.
set -euo pipefail

command -v powershell.exe >/dev/null 2>&1 || exit 0
DOTFILES_PATH=${DOTFILES_PATH:-"$(cd "$(dirname "$0")/.." && pwd)"}

localappdata=$(wslpath -u "$(cd /mnt/c && cmd.exe /c 'echo %LOCALAPPDATA%' 2>/dev/null | tr -d '\r')")
font_dir="$localappdata/Microsoft/Windows/Fonts"
mkdir -p "$font_dir"

if compgen -G "$font_dir/CommitMonoNonicons-*.otf" >/dev/null; then
    echo "CommitMono Nonicons is installed on Windows; skipping"
    exit 0
fi

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
mkdir -p "$tmp/in" "$tmp/out"

# The CommitMono fonts that are already on Windows can have custom weights from
# commitmono.com, so patch those. Use the release fonts only as a fallback.
if compgen -G "$font_dir/CommitMono-*.otf" >/dev/null; then
    cp "$font_dir"/CommitMono-*.otf "$tmp/in/"
else
    curl -fsSL -o "$tmp/commit-mono.zip" \
        "https://github.com/eigilnikolajsen/commit-mono/releases/download/v1.143/CommitMono-1.143.zip"
    python3 -m zipfile -e "$tmp/commit-mono.zip" "$tmp/zip"
    find "$tmp/zip" -maxdepth 2 -name 'CommitMono-*.otf' -exec cp {} "$tmp/in/" \;
fi
curl -fsSL -o "$tmp/nonicons.ttf" "https://raw.githubusercontent.com/ya2s/nonicons/master/dist/nonicons.ttf"
chmod u+w "$tmp"/in/*

python3 -m venv "$tmp/venv"
"$tmp/venv/bin/pip" install -q fonttools
"$tmp/venv/bin/python" "$DOTFILES_PATH/scripts/patch_nonicons.py" "$tmp/nonicons.ttf" "$tmp/out" "$tmp"/in/*.otf

registry='HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts'
for font in "$tmp"/out/*.otf; do
    name=$(basename "$font")
    cp "$font" "$font_dir/$name"
    win_path=$(wslpath -w "$font_dir/$name")
    (cd /mnt/c && powershell.exe -NoProfile -Command \
        "New-ItemProperty -Path '$registry' -Name '${name%.otf} (OpenType)' -Value '$win_path' -PropertyType String -Force | Out-Null")
done
echo "Installed CommitMono Nonicons for the Windows user. Restart Windows apps to use it."
