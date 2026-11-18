#!/usr/bin/env bash
# Merge the shared Claude Code and Codex settings from dotfiles into the live config files.
#
# The apps and other tools (Orca, herdr, plugins) also write to these files, and the files
# hold machine-specific paths. So this script does not symlink them. It merges only the keys
# that dotfiles owns, and it keeps everything else. Run it again after you change a shared file.
#
#   claude/settings.shared.json -> ~/.claude/settings.json (every host)
#   claude/settings.mac.json    -> ~/.claude/settings.json (macOS only, the work MacBook)
#   codex/config.shared.toml    -> ~/.codex/config.toml    (every host)
#   hermes/config.shared.yaml   -> ~/.hermes/config.yaml   (hosts with Hermes)
set -euo pipefail

DOTFILES_PATH="${DOTFILES_PATH:-$(cd "$(dirname "$0")/.." && pwd)}"

merge_claude() {
    local live="$HOME/.claude/settings.json"
    local layers=("$DOTFILES_PATH/claude/settings.shared.json")
    [ "$(uname)" = "Darwin" ] && layers+=("$DOTFILES_PATH/claude/settings.mac.json")

    command -v jq >/dev/null 2>&1 || { echo "agent-config: jq not found, skipped Claude settings" >&2; return 0; }
    mkdir -p "$HOME/.claude"
    [ -f "$live" ] || echo '{}' > "$live"

    local result tmp
    result=$(cat "$live")
    for layer in "${layers[@]}"; do
        result=$(jq -n --argjson live "$result" --slurpfile base "$layer" '
            $base[0] as $b
            # Plain keys: dotfiles wins. Hooks and permission lists: add entries, keep local ones.
            | ($live * ($b | del(.hooks, .permissions)))
            | .hooks = reduce (($b.hooks // {}) | to_entries[]) as $e (($live.hooks // {});
                (.[$e.key] // []) as $cur
                | .[$e.key] = $cur + [$e.value[] | select(. as $x | any($cur[]; . == $x) | not)])
            | .permissions = reduce (($b.permissions // {}) | to_entries[]) as $p (($live.permissions // {});
                if ($p.value | type) == "array"
                then .[$p.key] = (((.[$p.key] // []) + $p.value) | unique)
                else .[$p.key] = $p.value end)
            | if .hooks == {} then del(.hooks) else . end
            | if .permissions == {} then del(.permissions) else . end')
    done

    if [ "$result" != "$(jq . "$live")" ]; then
        cp "$live" "$live.dotfiles-backup"
        tmp=$(mktemp)
        printf '%s\n' "$result" > "$tmp" && mv "$tmp" "$live"
        echo "agent-config: updated $live (backup: $live.dotfiles-backup)"
    else
        echo "agent-config: $live is up to date"
    fi
}

merge_codex() {
    local live="$HOME/.codex/config.toml"
    mkdir -p "$HOME/.codex"
    [ -f "$live" ] || : > "$live"
    python3 - "$DOTFILES_PATH/codex/config.shared.toml" "$live" <<'PY'
import re, shutil, sys

shared_path, live_path = sys.argv[1], sys.argv[2]
HEADER = re.compile(r"^\s*\[[^\[].*\]\s*$")
KEY = re.compile(r"^\s*([A-Za-z0-9_.\"-]+)\s*=")

def sections(lines):
    """Split TOML lines into [(header or None, [lines])]. Only simple one-line values are managed."""
    out = [(None, [])]
    for line in lines:
        if HEADER.match(line):
            out.append((line.strip(), []))
        else:
            out[-1][1].append(line)
    return out

shared = {}
for header, body in sections(open(shared_path).read().splitlines()):
    for line in body:
        m = KEY.match(line)
        if m:
            shared.setdefault(header, []).append((m.group(1), line.strip()))

original = open(live_path).read()
live = sections(original.splitlines())

for header, pairs in shared.items():
    target = next((s for s in live if s[0] == header), None)
    if target is None:
        live.append((header, [line for _, line in pairs] + [""]))
        continue
    body = target[1]
    insert_at = 0
    for key, line in pairs:
        idx = next((i for i, l in enumerate(body) if (m := KEY.match(l)) and m.group(1) == key), None)
        if idx is None:
            body.insert(insert_at, line)
            insert_at += 1
        else:
            body[idx] = line

text = []
for header, body in live:
    if header is not None:
        if text and text[-1] != "":
            text.append("")
        text.append(header)
    text.extend(body)
merged = "\n".join(text).strip("\n") + "\n"

if merged != original:
    shutil.copyfile(live_path, live_path + ".dotfiles-backup")
    open(live_path, "w").write(merged)
    print(f"agent-config: updated {live_path} (backup: {live_path}.dotfiles-backup)")
else:
    print(f"agent-config: {live_path} is up to date")
PY
}

merge_hermes() {
    local live="$HOME/.hermes/config.yaml"
    [ -f "$live" ] || return 0
    if grep -q "herdr-status.sh" "$live"; then
        echo "agent-config: $live is up to date"
    # A second top-level hooks key would replace the first one when YAML loads.
    elif grep -q "^hooks:" "$live"; then
        echo "agent-config: $live has its own hooks block, add hermes/config.shared.yaml by hand" >&2
    else
        cp "$live" "$live.dotfiles-backup"
        printf '\n' >> "$live"
        cat "$DOTFILES_PATH/hermes/config.shared.yaml" >> "$live"
        echo "agent-config: updated $live (backup: $live.dotfiles-backup)"
    fi
}

merge_claude
merge_codex
merge_hermes
