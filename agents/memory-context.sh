#!/usr/bin/env bash
# Print the shared memory notes from the Obsidian vault.
# Claude Code runs this as a SessionStart hook and adds the output to the context.
# The script prints nothing and exits 0 if it cannot find the vault.

vault="${OBSIDIAN_VAULT_PATH:-}"
if [ -z "$vault" ]; then
    for candidate in "$HOME/Obsidian/vault" "$HOME/vault"; do
        if [ -d "$candidate/memory" ]; then
            vault="$candidate"
            break
        fi
    done
fi

[ -n "$vault" ] && [ -d "$vault/memory" ] || exit 0

# The MacBook is a work machine: personal goals never load there.
# Set MEMORY_PROFILE to "work" or "personal" to override the default.
profile="${MEMORY_PROFILE:-}"
if [ -z "$profile" ]; then
    if [ "$(uname)" = "Darwin" ]; then profile=work; else profile=personal; fi
fi

notes="User Memory Now"
[ "$profile" = "personal" ] && notes="$notes Personal"

printf 'Shared memory from the Obsidian vault at %s, profile %s (see the vault AGENTS.md, "Shared Memory").\n' "$vault" "$profile"

for note in $notes; do
    file="$vault/memory/$note.md"
    [ -f "$file" ] || continue
    printf '\n<memory note="memory/%s.md">\n' "$note"
    # Drop the frontmatter block at the top of the note.
    awk 'NR == 1 && $0 == "---" { skip = 1; next } skip && $0 == "---" { skip = 0; next } !skip' "$file"
    printf '</memory>\n'
done

exit 0
