#!/bin/bash

DOTFILES_DIR=${HOME}/.dotfiles

cd ${HOME}
if [[ $@ == "" ]]; then
    git clone --recursive https://github.com/moskomule/.dotfiles.git ${DOTFILES_DIR}
fi

if [[ $1 == "test" ]]; then
# circle CI environment
    DOTFILES_DIR=/home/circleci/project
fi


pushd ${DOTFILES_DIR}

make minimum
