# .dotfiles [![CircleCI](https://circleci.com/gh/moskomule/.dotfiles.svg?style=svg)](https://circleci.com/gh/moskomule/.dotfiles)
## basics


## Installation

```
cd $HOME
curl -sSL raw.github.com/moskomule/.dotfiles/master/setup.sh | bash
```

or

```
cd $HOME
git clone --recursive https://github.com/moskomule/.dotfiles.git
cd .dotfiles
make [all]
```

## Homebrew

```
make brew_bundle
```

## NeoVim

## zsh

Add machine specific settings to `~/.zshrc`.

## tmux

`.tmux.conf` is for tmux 2.1 or later. Settings for mouse had been changed.

## Python

`make conda_install` will install miniconda to `$HOME/.miniconda`.

## Update

`make update` will update dependencies.

## Clean

`make clean` will remove installed dotfiles. Note that this command will not brew and conda.
