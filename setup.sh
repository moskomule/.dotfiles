#!/bin/bash

DOTFILES_DIR=${HOME}/.dotfiles

cd ${HOME}
if [[ $@ == "" ]]; then
    git clone --recursive https://github.com/moskomule/.dotfiles.git
fi

if [[ $1 == "test" ]]; then
# circle CI environment
    DOTFILES_DIR=/home/circleci/project
fi

cd ${DOTFILES_DIR}

if [[ -e ${HOME}/.zshrc ]]; then
    mv ${HOME}/.zshrc ${HOME}/.zshrc.backup
fi

if [[ -e ${HOME}/.vimrc ]]; then
    mv ${HOME}/.vimrc ${HOME}/.vimrc.backup
fi

echo "source ${DOTFILES_DIR}/zsh/shared" >> ${HOME}/.zshrc

if [[ ${XDG_CONFIG_HOME} == "" ]]; then
    XDG_CONFIG_HOME=${HOME}/.config
    echo "export XDG_CONFIG_HOME=${HOME}/.config" >> ${HOME}/.zshrc
fi

ln -sfv ${DOTFILES_DIR}/.tmux.conf ${HOME}/.tmux.conf
ln -sfv ${DOTFILES_DIR}/nvim/init.vim ${HOME}/.vimrc
mkdir -p ${XDG_CONFIG_HOME}/nvim
ln -sfv ${DOTFILES_DIR}/nvim/init.vim ${XDG_CONFIG_HOME}/nvim/init.vim
ln -sfv ${DOTFILES_DIR}/dein ${XDG_CONFIG_HOME}/dein

# zsh's theme
ln -sfv ${DOTFILES_DIR}/zsh/pure/pure.zsh ${DOTFILES_DIR}/zsh/prompt_pure_setup
ln -sfv ${DOTFILES_DIR}/zsh/pure/async.zsh ${DOTFILES_DIR}/zsh/async