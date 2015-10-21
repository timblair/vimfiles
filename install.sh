#!/bin/bash

git clone git://github.com/timblair/vimfiles.git ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc && cd ~/.vim

if [[ $(uname) == 'Darwin' ]]; then
  mkdir -p ~/Library/Vim/{swap,backup,undo}
else
  mkdir -p ~/.local/share/vim/{swap,backup,undo}
fi

# Install CMake for YCMm (I'm on OS X, so we'll use Homebrew)
if hash brew 2>/dev/null; then
  $( hash cmake 2>/dev/null ) || brew install cmake
fi

vim +PlugInstall +qall
