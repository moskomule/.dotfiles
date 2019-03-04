#!/bin/bash

if [ "$(uname)" == 'Darwin' ]; then
    URL=https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh 
else
    URL=https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh 
fi
wget $URL -O miniconda.sh
bash miniconda.sh -b -p $HOME/.miniconda
touch $HOME/.zshrc_
echo export PATH="$HOME/.miniconda/bin:$PATH" >> $HOME/.zshrc_
