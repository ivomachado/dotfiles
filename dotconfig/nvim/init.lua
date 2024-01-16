local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.cmd("filetype plugin on")

vim.cmd([[
set titlestring=%{fnamemodify(getcwd(),':h:t')}/%{fnamemodify(getcwd(),':t')}
]])

vim.api.nvim_create_user_command('ClearNotifications', "lua require'notify'.dismiss()", {})
vim.api.nvim_create_user_command('RemoveIostream', 'g/iostream\\|cout/d', {})
vim.cmd([[set guifont=JetBrainsMono\ NF:h11]])

vim.api.nvim_set_keymap('s', 'jk', '<Esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true, silent = true })

require("opts")
require("lazy").setup("plugins")
