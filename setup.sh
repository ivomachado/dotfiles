#!/bin/bash

backupfolder=~/Workspace/dotfiles

initvimpath=~/.config/nvim/init.vim
dotvimrcpath=~/.vimrc
tmuxconfpath=~/.tmux.conf
kittyconfpath=~/.config/kitty/kitty.conf
dotscriptspath=~/.scripts

rm $initvimpath
ln -s $backupfolder/init.vim $initvimpath

rm $dotvimrcpath
ln -s $backupfolder/.vimrc $dotvimrcpath

rm $kittyconfpath
ln -s $backupfolder/kitty.conf $kittyconfpath

rm $tmuxconfpath
ln -s $backupfolder/.tmux.conf $tmuxconfpath

rm -r $dotscriptspath
ln -s $backupfolder/.scripts $dotscriptspath
