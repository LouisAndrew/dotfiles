---
name: dotfiles-maintainer
description: Maintain this dotfiles repository safely and consistently. Use when adding, changing, debugging, or reviewing shell, editor, terminal, or bootstrap configuration in the dotfiles repository.
---

# Dotfiles maintainer

Keep configuration changes small, portable, and reversible.

## Workflow

1. Read the relevant configuration and bootstrap files before editing.
2. Reuse the repository's existing layout and conventions.
3. Keep secrets, credentials, generated state, and machine-specific session data out of the repository.
4. Quote shell paths and variables unless intentional splitting is required.
5. Preserve unrelated local configuration when creating symlinks.
6. Run the narrowest syntax check for every changed configuration file.
7. Exercise the changed command or application path when available.

## Symlink changes

- Store the source file in this repository.
- Link only the configuration resources that should be versioned.
- Do not link entire state directories when they contain authentication, trust, cache, or session data.
- Refuse to replace an existing non-symlink destination automatically; report it so the owner can migrate it deliberately.
