#!/bin/bash

backupfolder=~/Workspace/dotfiles

initvimpath=~/.config/nvim/init.vim
dotvimrcpath=~/.vimrc
tmuxconfpath=~/.tmux.conf
kittyconfpath=~/.config/kitty/kitty.conf

rm $initvimpath
ln -s $backupfolder/init.vim $initvimpath

rm $dotvimrcpath
ln -s $backupfolder/.vimrc $dotvimrcpath

rm $kittyconfpath
ln -s $backupfolder/kitty.conf $kittyconfpath

rm $tmuxconfpath
ln -s $backupfolder/.tmux.conf $tmuxconfpath
