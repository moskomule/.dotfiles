# .dotfiles
## basics


## Installation

```
cd $HOME
curl -L raw.github.com/moskomule/.dotfiles/master/setup.sh | bash
```

## Homebrew

Install homebrew

`/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`,

and unpack the bundled from `Brewfile`

```
cd $HOME/.dotfiles
brew bundle
```

## zsh

Write machine specific settings in `~/.zshrc`

## tmux

`.tmux.conf` is for tmux 2.1 or later. Settings for mouse had been changed.

## Python

`bash ./getconda.sh` downloads and installs latest miniconda in `~/.miniconda`