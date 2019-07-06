#!/bin/bash

DOTFILE_DIR=${HOME}/.dotfiles

cd ${HOME}
git clone --recursive https://github.com/moskomule/.dotfiles.git
cd ${DOTFILE_DIR}

if [[ -e ${HOME}/.zshrc ]]; then
    mv ${HOME}/.zshrc ${HOME}/.zshrc.backup
fi

if [[ -e ${HOME}/.vimrc ]]; then
    mv ${HOME}/.vimrc ${HOME}/.vimrc.backup
fi

echo "source ${DOTFILE_DIR}/zsh/shared" >> ${HOME}/.zshrc

if [[ ${XDG_CONFIG_HOME} == "" ]]; then
    XDG_CONFIG_HOME=${HOME}/.config
    echo "export XDG_CONFIG_HOME=${HOME}/.config" >> ${HOME}/.zshrc
fi

ln -s ${DOTFILE_DIR}/.tmux.conf ${HOME}/.tmux.conf
ln -s ${DOTFILE_DIR}/nvim/init.vim ${HOME}/.vimrc
mkdir -p ${XDG_CONFIG_HOME}/nvim
ln -s ${DOTFILE_DIR}/nvim/init.vim ${XDG_CONFIG_HOME}/nvim/init.vim

if [[ -e "${DOTFILE_DIR}/zsh/pure" ]]; then
    ln -s ${DOTFILE_DIR}/zsh/pure/pure.zsh ${DOTFILE_DIR}/zsh/prompt_pure_setup
    ln -s ${DOTFILE_DIR}/zsh/pure/async.zsh ${DOTFILE_DIR}/zsh/async
fi
