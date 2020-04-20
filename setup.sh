#!/bin/bash

DOTFILES_DIR=${HOME}/.dotfiles

if [[ $@ == "" ]]; then
    git clone --recursive https://github.com/moskomule/.dotfiles.git ${DOTFILES_DIR}
    pushd ${DOTFILES_DIR}
    make minimum
fi

if [[ $1 == "test" ]]; then
    # circle CI environment
    export DOTFILES_DIR=/home/circleci/project
    make test
fi


