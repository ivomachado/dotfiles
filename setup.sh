#!/bin/bash

mkdir -p ~/.config

# Symlink all items in dotconfig to ~/.config
for item in dotconfig/*; do
  target="$HOME/.config/$(basename "$item")"
  # herdr stores runtime state (logs, session.json) in its config dir,
  # so symlink only the config file and keep the rest local.
  if [ "$(basename "$item")" = "herdr" ]; then
    mkdir -p "$target"
    ln -sfn "$PWD/dotconfig/herdr/config.toml" "$target/config.toml"
    continue
  fi
  # Use -n (no-dereference) and -f (force) to replace existing links/files 
  # without nesting them inside directories.
  ln -sfn "$PWD/$item" "$target"
done

ln -sfn "$PWD/.zshrc" "$HOME/.zshrc"
ln -sfn "$PWD/.p10k.zsh" "$HOME/.p10k.zsh"
ln -sfn "$PWD/.clangd" "$HOME/.clangd"
ln -sfn "$PWD/.clang-format" "$HOME/.clang-format"
ln -sfn "$PWD/.gitmessage" "$HOME/.gitmessage"

git config --global core.excludesFile $PWD/.gitignore_global
git config --global commit.template ~/.gitmessage
git config --global core.name "Ivo Machado"
