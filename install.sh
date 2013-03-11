#!/bin/bash

git clone git://github.com/timblair/vimfiles.git ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc && cd ~/.vim

if [[ $(uname) == 'Darwin' ]]; then
  mkdir -p ~/Library/Vim/{swap,backup,undo}
else
  mkdir -p ~/.local/share/vim/{swap,backup,undo}
fi

git submodule init && git submodule update
