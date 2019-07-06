# .dotfiles [![CircleCI](https://circleci.com/gh/moskomule/.dotfiles.svg?style=svg)](https://circleci.com/gh/moskomule/.dotfiles)
## basics


## Installation

```
cd $HOME
curl -sSL raw.github.com/moskomule/.dotfiles/master/setup.sh | bash
```

## Homebrew

Install homebrew via

`bash ./getbrew.sh`

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