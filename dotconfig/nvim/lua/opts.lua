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
-- vim.opt.scrolloff = 5
vim.opt.signcolumn = "yes"
vim.opt.guifont = "FiraCode Nerd Font Mono:h12"
-- vim.opt.cmdheight = 0

vim.opt.termguicolors = true

vim.opt.list = true
vim.opt.listchars:append("eol:\u{ebea}")
vim.opt.listchars:append("tab:\u{f0312}  ")
-- vim.opt.listchars:append("lead:·")
vim.opt.listchars:append("trail:·")
-- vim.opt.listchars:append("extends:>")
-- vim.opt.listchars:append("precedes:<")
vim.opt.ffs="unix"

vim.opt.cinoptions = "N-s,0g,E-s,(0,j1,l1,:0,Ws"

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
})

vim.o.sessionoptions="buffers,curdir,folds,help,tabpages,winsize"

vim.api.nvim_create_autocmd({ "BufHidden" }, {
    pattern = {"*No Name*"},
    callback = function(ev)
        vim.api.nvimm_buf_delete(ev.buf)
    end,
})

vim.api.nvim_create_autocmd({ "WinLeave" }, {
    callback = function()
        vim.opt.cursorline = false
    end,
})

vim.api.nvim_create_autocmd({ "WinEnter" }, {
    callback = function()
        vim.opt.cursorline = true
    end,
})

local links = {
    ['@lsp.type.namespace'] = '@namespace',
    ['@lsp.type.type'] = '@type',
    ['@lsp.type.class'] = '@type',
    ['@lsp.type.enum'] = '@type',
    ['@lsp.type.interface'] = '@type',
    ['@lsp.type.struct'] = '@structure',
    ['@lsp.type.parameter'] = '@parameter',
    ['@lsp.type.variable'] = '@variable',
    ['@lsp.type.property'] = '@property',
    ['@lsp.type.enumMember'] = '@constant',
    ['@lsp.type.function'] = '@function',
    ['@lsp.type.method'] = '@method',
    ['@lsp.type.macro'] = '@macro',
    ['@lsp.type.decorator'] = '@function',
}
for newgroup, oldgroup in pairs(links) do
    vim.api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true })
end
