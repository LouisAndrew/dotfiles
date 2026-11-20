#!/usr/bin/env bash
# On WSL, build "CommitMono" and "CommitMono Nonicons" and install them for the Windows user, so
# Windows apps such as the Herdr app can use them. Per-user fonts need no admin.
set -euo pipefail

command -v powershell.exe >/dev/null 2>&1 || exit 0
DOTFILES_PATH=${DOTFILES_PATH:-"$(cd "$(dirname "$0")/.." && pwd)"}

localappdata=$(wslpath -u "$(cd /mnt/c && cmd.exe /c 'echo %LOCALAPPDATA%' 2>/dev/null | tr -d '\r')")
font_dir="$localappdata/Microsoft/Windows/Fonts"
mkdir -p "$font_dir"

if [ -f "$font_dir/CommitMonoNonicons-200-Regular.otf" ]; then
    echo "CommitMono Nonicons is installed on Windows; skipping"
    exit 0
fi

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
bash "$DOTFILES_PATH/scripts/build-fonts.sh" "$tmp/out"

registry='HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts'
for font in "$tmp"/out/*.otf; do
    name=$(basename "$font")
    cp "$font" "$font_dir/$name"
    win_path=$(wslpath -w "$font_dir/$name")
    (cd /mnt/c && powershell.exe -NoProfile -Command \
        "New-ItemProperty -Path '$registry' -Name '${name%.otf} (OpenType)' -Value '$win_path' -PropertyType String -Force | Out-Null")
done
echo "Installed CommitMono and CommitMono Nonicons for the Windows user. Restart Windows apps to use it."
