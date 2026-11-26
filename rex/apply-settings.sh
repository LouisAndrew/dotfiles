#!/usr/bin/env bash
# Rex keeps its app settings in the app, not in init.lua, so set them to match herdr-app/settings.json.
# Needs Remote Control on in Rex Settings > General. Pass the client label or ID when more than
# one Rex app is connected (see `rex client ls`).
set -euo pipefail
DOTFILES_PATH=${DOTFILES_PATH:-$HOME/dev/dotfiles}
client=${1:-$(rex client ls | awk '$4 == "app" { print $NF; exit }')}

set_rex() { rex -C "$client" do "$@" >/dev/null; }

set_rex client.setting.terminal.typography.font value="CommitMono Nonicons"
# Herdr font_weight 200.
set_rex client.setting.terminal.typography.style value=ExtraLight
set_rex client.setting.terminal.typography.size value=16
# Herdr terminal_line_height 1.4. Rex adds a percent to the font's own line height (35px at 16pt
# on a Retina screen), so +28% gives the 45px rows that herdr draws.
set_rex client.setting.terminal.typography.line_height value=28
set_rex client.setting.terminal.advanced_fonts.ligatures value=false
set_rex client.setting.notifications.activity.sounds value=false
# Herdr has one theme, so stay in dark mode, where the imported theme applies.
set_rex client.theme.import path="$DOTFILES_PATH/rex/themes/herdr-ghostty"
set_rex client.setting.interface.appearance.scheme value=dark
# Rex takes its accent from macOS, so give Rex alone the gray Graphite accent instead of blue.
# Rex reads it at launch.
defaults write com.superlogical.rex AppleAccentColor -int -1
defaults write com.superlogical.rex AppleHighlightColor -string "0.847059 0.847059 0.862745 Graphite"
