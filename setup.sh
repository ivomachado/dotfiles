#!/bin/bash

initvimpath=~/.config/nvim/init.vim
dotvimrcpath=~/.vimrc
kittyconfpath=~/.config/kitty/kitty.conf

rm $initvimpath
ln -s ~/Workspace/dotfiles/init.vim $initvimpath

rm $dotvimrcpath
ln -s ~/Workspace/dotfiles/.vimrc $dotvimrcpath

rm $kittyconfpath
ln -s ~/Workspace/dotfiles/kitty.conf $kittyconfpath
