#!/bin/bash

# Install MacVim as follows:
# $ brew install macvim --env-std --override-system-vim
#
# Install font with Powerline patches:
# https://github.com/Lokaltog/powerline-fonts/blob/master/InconsolataDz/Inconsolata-dz%20for%20Powerline.otf?raw=true

git clone git://github.com/timblair/vimfiles.git ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc && cd ~/.vim

if [[ $(uname) == 'Darwin' ]]; then
  mkdir -p ~/Library/Vim/{swap,backup,undo}
else
  mkdir -p ~/.local/share/vim/{swap,backup,undo}
fi

vim +PlugInstall +qall
