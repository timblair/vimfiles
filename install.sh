#!/bin/bash

git clone git://github.com/timblair/vimfiles.git ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc && cd ~/.vim
mkdir -p ~/.cache/vim/{swap,backup,undo}
git submodule init && git submodule update
