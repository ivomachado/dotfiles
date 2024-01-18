local wk = require("which-key")

wk.register({
    n = { "<cmd>Neotree float toggle=true<cr>", "Toggle Project Drawer" },
    N = { "<cmd>Neotree float focus reveal<cr>", "Open Project Drawer on Current File" },

    f = { "<cmd>Telescope find_files no_ignore=true hidden=true<cr>", "Find Files"},
    b = { "<cmd>Telescope buffers<cr>", "Buffers"},
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols"},
    p = { "<cmd>Telescope commands<cr>", "Commands" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorschemes" },
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
wk.register({
    ["<F5>"] = { "<cmd>lua require'dap'.continue()<CR>", "Continue Debugging" },
    ["<F9>"] = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "Toggle Breakpoint" },
    ["<F10>"] = { "<cmd>lua require'dap'.step_over()<CR>", "Step Over" },
    ["<F11>"] = { "<cmd>lua require'dap'.step_into()<CR>", "Step Into" },
})
