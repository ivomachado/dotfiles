#!/bin/bash

backupfolder=~/Workspace/dotfiles

initluadir=~/.config/nvim/
initluapath=$initluadir"init.lua"
tmuxconfpath=~/.tmux.conf
kittyconfdir=~/.config/kitty/
tmuxinatorconfdir=~/.tmuxinator
zshrcpath=~/.zshrc
kittyconfpath=$kittyconfdir"kitty.conf"

rm $initluapath 2> /dev/null
mkdir -p $initluadir
ln -sf $backupfolder/init.lua $initluapath

rm $tmuxinatorconfdir -rf 2> /dev/null
ln -s $backupfolder/.tmuxinator $tmuxinatorconfdir

rm $kittyconfpath 2> /dev/null
mkdir -p $kittyconfdir
ln -s $backupfolder/kitty.conf $kittyconfpath

rm $tmuxconfpath 2> /dev/null
ln -s $backupfolder/.tmux.conf $tmuxconfpath

rm $zshrcpath 2> /dev/null
ln -s $backupfolder/.zshrc $zshrcpath
