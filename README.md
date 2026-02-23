# dotfiles

Personal dotfiles for macOS, managed with symlinks.

## Files

| File | Symlink |
|------|---------|
| `ssh/config` | `~/.ssh/config` |
| `.zshrc` | `~/.zshrc` |
| `.gitconfig` | `~/.gitconfig` |
| `Brewfile` | — |

## Setup on a new machine

```bash
git clone https://github.com/wahans/dotfiles ~/dotfiles

ln -s ~/dotfiles/ssh/config ~/.ssh/config
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.gitconfig ~/.gitconfig

source ~/.zshrc
```

### Restore Homebrew packages

```bash
brew bundle install --file=~/dotfiles/Brewfile
```

## Machine-specific config

Add a `~/.zshrc.local` file for anything specific to a machine (aliases, env vars, etc). It's sourced automatically and not tracked in the repo.

## Syncing

```bash
dotfiles-push   # MacBook Pro → GitHub
dotfiles-pull   # GitHub → any machine
```
