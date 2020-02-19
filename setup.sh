#!/bin/bash

backupfolder=~/Workspace/dotfiles

initvimdir=~/.config/nvim/
initvimpath=$initvimdir"init.vim"
dotvimrcpath=~/.vimrc
tmuxconfpath=~/.tmux.conf
kittyconfdir=~/.config/kitty/
zshrcpath=~/.zshrc
kittyconfpath=$kittyconfdir"kitty.conf"
dotscriptspath=~/.scripts

rm $initvimpath 2> /dev/null
mkdir -p $initvimdir
ln -s $backupfolder/init.vim $initvimpath

rm $dotvimrcpath 2> /dev/null
ln -s $backupfolder/.vimrc $dotvimrcpath

rm $kittyconfpath 2> /dev/null
mkdir -p $kittyconfdir
ln -s $backupfolder/kitty.conf $kittyconfpath

rm $tmuxconfpath 2> /dev/null
ln -s $backupfolder/.tmux.conf $tmuxconfpath

rm $zshrcpath 2> /dev/null
ln -s $backupfolder/.zshrc $zshrcpath

rm -r $dotscriptspath 2> /dev/null
ln -s $backupfolder/.scripts $dotscriptspath
