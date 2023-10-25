vim.opt.compatible = false
vim.opt.mouse="a"
vim.opt.showmode = false
vim.opt.backup = false
vim.opt.title = true
vim.opt.hidden = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.swapfile = false
vim.opt.encoding="utf-8"
vim.opt.fileencoding="utf-8"
vim.opt.wrap = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.expandtab = true
vim.opt.fixendofline = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.showtabline = 0
vim.opt.scrolloff = 7
vim.opt.signcolumn = "yes"
vim.opt.guifont = "FiraCode Nerd Font Mono:h12"

vim.opt.termguicolors = true

vim.opt.list = true
vim.opt.listchars:append("eol:⏎")
-- vim.opt.listchars:append("tab:>- ")
-- vim.opt.listchars:append("lead:·")
-- vim.opt.listchars:append("trail:·")
-- vim.opt.listchars:append("extends:>")
-- vim.opt.listchars:append("precedes:<")
vim.opt.ffs="unix"

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
})

vim.o.sessionoptions="buffers,curdir,folds,help,tabpages,winsize"
