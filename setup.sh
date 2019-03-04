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

ln -s $(pwd)/nvim/init.vim ${HOME}/.vimrc

if [[ -e "$HOME/.dotfiles/zsh/pure" ]]; then
    ln -s $HOME/.dotfiles/zsh/pure/pure.zsh $HOME/.dotfiles/zsh/prompt_pure_setup
    ln -s $HOME/.dotfiles/zsh/pure/async.zsh $HOME/.dotfiles/zsh/async
fi

