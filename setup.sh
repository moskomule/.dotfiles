#!/bin/bash

for file in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
#   echo "$file"
    ln -fsv $HOME/.dotfiles/$file $HOME/$file
done

# nvim setup
ln -fsnv $HOME/.dotfiles/.vim $HOME/.config/nvim
ln -fsnv $HOME/.dotfiles/.vimrc $HOME/.config/nvim/init.vim
ln -fsnv $HOME/.dotfiles/dein/plugins.toml $HOME/.config/dein/plugins.toml
