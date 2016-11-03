 #!/bin/bash

 for file in .??*
 do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
#    echo "$file"
    ln -sv $HOME/.dotfiles/$file $HOME/$file
 done
ln -snv $HOME/.dotfiles/.vim ${HOME}/.config/nvim
ln -snv $HOME/.dotfiles/.vimrc ${HOME}/.config/nvim/init.vim
