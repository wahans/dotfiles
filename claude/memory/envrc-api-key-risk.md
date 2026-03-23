---
name: API key in ~/cl/.envrc
description: Anthropic API key lives in ~/cl/.envrc via direnv - must be moved before any git init or sharing of ~/cl/
type: project
domain: crosslayer
---

`~/cl/.envrc` contains an Anthropic API key loaded via direnv (scoped to ~/cl/ and subdirs).

**Why this matters:** No git repo at ~/cl/ root currently, so it's safe. But if ~/cl/ ever gets `git init`, backed up, or shared, the key would be exposed.

**How to apply:** If Wally ever mentions git init at ~/cl/, backing up ~/cl/, or sharing that directory, flag the .envrc and recommend moving the key to ~/.zshrc.local first.
