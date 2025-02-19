# dotfiles

This repository contains configuration files for various tools and applications to enhance your development environment. Below is an overview of the configurations included:

## Alacritty
Configuration for the Alacritty terminal emulator.
- Font: JetBrainsMono NF, size 14
- Window dimensions: 80 columns, 25 lines
- Padding: 5 pixels
- Dynamic padding and resize increments enabled
- Theme: Monokai Charcoal

## fd
Ignore file patterns for the `fd` command-line tool.
- Ignores common build artifacts, cache directories, and version control directories.

## Helix
Configuration for the Helix text editor.
- Theme: Kanagawa
- Relative line numbers, cursor line, and indent guides enabled
- Custom keybindings for normal, insert, and select modes
- LSP settings for Rust Analyzer

## Lazygit
Configuration for Lazygit, a simple terminal UI for Git commands.
- Custom service for GitLab integration

## Neovim
Configuration for Neovim, a highly configurable text editor.
- Custom colorscheme: Catppuccin Ivo
- Various editor settings for better usability
- Keybindings for common actions and plugins
- Plugin management using Lazy.nvim
- Language Server Protocol (LSP) setup for multiple languages
- Fuzzy finder integration with FzfLua
- Git integration with Gitsigns

## Ripgrep
Configuration for Ripgrep, a line-oriented search tool.
- Searches hidden files and directories by default
- Ignores common build artifacts and version control directories
- Smart case sensitivity

## Yazi
Configuration for Yazi, a terminal file manager.
- Custom layout ratios
- Integration with Zellij for opening files in Helix

## Zed
Configuration for Zed, a code editor.
- Vim mode enabled
- Custom keybindings for navigation and file management
- SSH connections for remote development
- Various UI and editor settings

## Zellij
Configuration for Zellij, a terminal workspace manager.
- Custom keybindings for pane and tab management
- Multiple floating layout configurations
- Default layout for development environment

## Layouts
Custom layouts for Zellij.
- PDE (Programming Development Environment) layout with predefined pane and tab configurations
