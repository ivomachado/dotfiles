#!/bin/bash

backupfolder=~/Workspace/dotfiles

nvimconfigfolder=~/.config/nvim
alacrittyconfdir=~/.config/alacritty/
zshrcpath=~/.zshrc
alacrittyconfpath=$alacrittyconfdir"alacritty.yml"

ln -sf $backupfolder/nvim $nvimconfigfolder

mkdir -p $alacrittyconfdir
ln -sf $backupfolder/alacritty.yml $alacrittyconfpath

ln -sf $backupfolder/.zshrc $zshrcpath
