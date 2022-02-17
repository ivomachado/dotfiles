#!/bin/bash

backupfolder=~/Workspace/dotfiles

initluadir=~/.config/nvim/
pluginsluadir=~/.config/nvim/lua/
initluapath=$initluadir"init.lua"
pluginsluapath=$pluginsluadir"plugins.lua"
tmuxconfpath=~/.tmux.conf
kittyconfdir=~/.config/kitty/
tmuxinatorconfdir=~/.tmuxinator
zshrcpath=~/.zshrc
kittyconfpath=$kittyconfdir"kitty.conf"

mkdir -p $initluadir
ln -sf $backupfolder/init.lua $initluapath

mkdir -p $pluginsluadir
ln -sf $backupfolder/plugins.lua $pluginsluapath

rm $tmuxinatorconfdir -rf 2> /dev/null
ln -s $backupfolder/.tmuxinator $tmuxinatorconfdir

mkdir -p $kittyconfdir
ln -sf $backupfolder/kitty.conf $kittyconfpath

ln -sf $backupfolder/.tmux.conf $tmuxconfpath

ln -sf $backupfolder/.zshrc $zshrcpath
