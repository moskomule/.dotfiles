#!/bin/bash

DOTFILES_DIR=${HOME}/.dotfiles

if [[ $@ == "" ]]; then
    git clone --recursive https://github.com/moskomule/.dotfiles.git ${DOTFILES_DIR}
    pushd ${DOTFILES_DIR}
fi

if [[ $1 == "test" ]]; then
    # circle CI environment
    DOTFILES_DIR=/home/circleci/project
    make echo
fi

make minimum
