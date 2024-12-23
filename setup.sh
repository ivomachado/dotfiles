#!/bin/bash

ls dotconfig/ | xargs -I {} ln -sf $PWD/dotconfig/{} ~/.config/{}

ln -sf $PWD/.zshrc ~
ln -sf $PWD/.clangd ~
ln -sf $PWD/.clang-format ~
ln -sf $PWD/.gitmessage ~

git config --global core.excludesFile $PWD/.gitignore_global
git config --global commit.template ~/.gitmessage
git config --global core.name "Ivo Machado"
