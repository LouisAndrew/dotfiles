# Linux / WSL shims for macOS-isms used across the dotfiles
[[ "$OSTYPE" == linux* ]] || return 0

if ! command -v pbcopy >/dev/null; then
  if command -v wl-copy >/dev/null; then
    pbcopy() { wl-copy "$@"; }
    pbpaste() { wl-paste --no-newline "$@"; }
  elif command -v xclip >/dev/null; then
    pbcopy() { xclip -selection clipboard "$@"; }
    pbpaste() { xclip -selection clipboard -o "$@"; }
  fi
fi

# Open files/URLs with the Windows host under WSL, xdg-open elsewhere
if [[ -n "$WSL_DISTRO_NAME" ]] && command -v wslview >/dev/null; then
  alias open="wslview"
elif command -v xdg-open >/dev/null; then
  alias open="xdg-open"
fi
