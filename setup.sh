#!/bin/bash

backupfolder=~/Workspace/dotfiles

nvimconfigfolder=~/.config/nvim
kittyconfdir=~/.config/kitty/
zshrcpath=~/.zshrc
kittyconfpath=$kittyconfdir"kitty.conf"

ln -sf $backupfolder/nvim $nvimconfigfolder

mkdir -p $kittyconfdir
ln -sf $backupfolder/kitty.conf $kittyconfpath

ln -sf $backupfolder/.zshrc $zshrcpath
