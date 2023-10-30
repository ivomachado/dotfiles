#!/bin/bash

backupdir=~/Workspace/dotfiles

configdir=~/.config

zshrcpath=~/.zshrc

ls dotconfig/ | xargs -I {} ln -T -sf $backupdir/dotconfig/{} $configdir/{}

ln -sf $backupdir/.zshrc $zshrcpath
