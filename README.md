# dotfiles

Personal dotfiles for macOS, managed with symlinks.

## Files

| File | Symlink |
|------|---------|
| `ssh/config` | `~/.ssh/config` |
| `.zshrc` | `~/.zshrc` |
| `.gitconfig` | `~/.gitconfig` |

## Setup on a new machine

```bash
git clone https://github.com/wahans/dotfiles ~/dotfiles

ln -s ~/dotfiles/ssh/config ~/.ssh/config
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
```
