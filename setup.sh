#!/bin/bash

for file in .??*; do
    if [[ "$file" == ".git" ]]; then 
        continue 
    fi
    if [[ "$file" == ".DS_Store" ]]; then
        continue
    fi
    ln -fsv $(pwd)/$file $HOME/$file
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
ln -fsnv .vim $CONFIG/nvim
ln -fsnv .vimrc $CONFIG/nvim/init.vim
ln -fsnv dein/plugins.toml $DEIN/plugins.toml
