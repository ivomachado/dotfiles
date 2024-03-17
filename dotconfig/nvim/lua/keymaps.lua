local wk = require("which-key")

wk.register({
    n = { "<cmd>Neotree float toggle=true<cr>", "Toggle Project Drawer" },
    N = { "<cmd>Neotree float focus reveal<cr>", "Open Project Drawer on Current File" },

    f = { "<cmd>FzfLua files<cr>", "Find Files"},
    b = { "<cmd>FzfLua buffers<cr>", "Buffers"},
    s = { "<cmd>FzfLua lsp_document_symbols<cr>", "Document Symbols"},
    S = { "<cmd>FzfLua lsp_workspace_symbols<cr>", "Workspace Symbols"},
    l = { "<cmd>FzfLua live_grep<cr>", "Live Grep"},
    p = { "<cmd>FzfLua commands<cr>", "Commands" },
    c = { "<cmd>FzfLua colorschemes<cr>", "Colorschemes" },
    w = { "<C-W>", "Windows", noremap = false,},

    q = { "<cmd>Bdelete<CR>", "Close Buffer"},
    Q = { "<cmd>bdelete<CR>", "Close Buffer and Window"},
    K = { "<cmd>lua require'dap.ui.widgets'.cursor_float()<CR>", "Show Debug Hover" },
    D = { "<cmd>lua require'dapui'.toggle()<CR>", "Toggle Debug UI" },
    e = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Show Diagnostic Hover" },
    h = { "<cmd>noh<CR>", "Disable Search Highlight"},
    k = { vim.lsp.buf.signature_help, "Toggle Signature Help" },
}, { prefix = "<leader>" })

wk.register({
    ["]"] = {
        b = { "<cmd>bn<CR>", "Buffer" },
        e = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Diagnostic" },
    },
    ["["] = {
        b = { "<cmd>bp<CR>", "Buffer" },
        e = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Diagnostic" },
    },
})
vim.keymap.set('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
vim.keymap.set('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })
vim.keymap.set('i', '<CR>', 'v:lua._Completion.cr_action()', { expr = true, replace_keycodes = false, })
vim.keymap.set('i', '<C-y>', 'v:lua._Completion.confirm_completion()', { expr = true, replace_keycodes = false, noremap = true })
