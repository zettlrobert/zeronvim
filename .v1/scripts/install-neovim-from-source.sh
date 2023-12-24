#!/bin/bash

cd "$HOME" || exit

if [ -d "neovim" ]; then rm -Rf neovim; fi

git clone https://github.com/neovim/neovim

cd "$HOME"/neovim || exit

make CMAKE_BUILD_TYPE=Release install
