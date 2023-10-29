#!/bin/bash

backupdir=~/Workspace/dotfiles

nvimconfigdir=~/.config/nvim
helixconfigdir=~/.config/helix
zellijconfigdir=~/.config/zellij

zshrcpath=~/.zshrc

alacritryconfigdir=~/.config/alacritty/
alacrittyconfigpath=$alacritryconfigdir"alacritty.yml"

ln -sf $backupdir/nvim $nvimconfigdir
ln -sf $backupdir/helix $helixconfigdir
ln -sf $backupdir/zellij $zellijconfigdir

mkdir -p $alacritryconfigdir
ln -sf $backupdir/alacritty.yml $alacrittyconfigpath

ln -sf $backupdir/.zshrc $zshrcpath
