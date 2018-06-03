#!/bin/bash
cd ~/Workspace/dotfiles
git add --all
date=`date`
git commit -m "$date"
git push
