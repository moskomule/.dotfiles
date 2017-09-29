#!/bin/bash

for file in `ls`; do
    if [[ "$file" == ".git" ]]; then 
        continue 
    fi
    if [[ "$file" == ".DS_Store" ]]; then
        continue
    fi
    ln -fsv $HOME/.dotfiles/$file $HOME/$file
done

CONFIG=$HOME"/.config"
DEIN=$CONFIG"/dein"
if [[ ! -e CONFIG ]]; then
    mkdir $CONFIG
fi
if [[ ! -e $DEIN ]]; then
    mkdir $DEIN
fi

# nvim setup
ln -fsnv $HOME/.dotfiles/.vim $CONFIG/nvim
ln -fsnv $HOME/.dotfiles/.vimrc $CONFIG/nvim/init.vim
ln -fsnv $HOME/.dotfiles/dein/plugins.toml $DEIN/plugins.toml
