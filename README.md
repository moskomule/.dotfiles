# .dotfiles 
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


## NeoVim

`.vimrc` is expected to work with VIM and NeoVim.

## zsh

Add machine specific settings to `~/.zshrc`, which git doesn't track.

## tmux

`.tmux.conf` is for tmux 2.1 or later. 

## Python

`make conda_install` will install miniconda to `$HOME/.miniconda`.

## [Home|Linux]brew

`make brew_install` will install homebrew and `make brew_bundle` will install bundled applications.

## Update

`make update` will update dependencies.

## Clean

> A bird does not foul the nest that it is about to leave (Japanese proverb)

`make clean` will remove installed dotfiles. Note that this command will not clean brew and conda.
