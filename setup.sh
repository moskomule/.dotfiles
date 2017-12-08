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
