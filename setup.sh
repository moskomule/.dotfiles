#!/bin/bash

cd ${HOME}
git clone --recursive https://github.com/moskomule/.dotfiles.git
cd .dotfiles

ln -s ${PWD}/.tmux.conf ${HOME}/.tmux.conf
ln -s ${PWD}/nvim/init.vim ${HOME}/.vimrc
mkdir -p ${XDG_CONFIG_HOME}/nvim
ln -s ${PWD}/nvim/init.vim ${XDG_CONFIG_HOME}/nvim/init.vim

if [[ -e ${HOME}/.zshrc ]]; then
    mv ${HOME}/.zshrc ${HOME}/.zshrc.backup
fi

echo "source ${PWD}/zsh/shared" >> ${HOME}/.zshrc

if [[ -e "${PWD}/zsh/pure" ]]; then
    ln -s ${PWD}/zsh/pure/pure.zsh ${PWD}/zsh/prompt_pure_setup
    ln -s ${PWD}/zsh/pure/async.zsh ${PWD}/.dotfiles/zsh/async
fi
