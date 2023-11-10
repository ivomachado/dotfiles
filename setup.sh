#!/bin/bash

ls dotconfig/ | xargs -I {} ln -T -sf $PWD/dotconfig/{} ~/.config/{}

ln -sf $PWD/.zshrc ~
ln -sf $PWD/.clang-format ~

git config --global core.excludesFile $PWD/.gitignore_global
git config --global core.name "Ivo Machado"
