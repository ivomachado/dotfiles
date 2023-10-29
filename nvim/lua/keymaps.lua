local function expanded_builtin_picker(builtin_picker)
    return function()
        local builtin = require("telescope.builtin")
        return builtin[builtin_picker]({
            search_dirs = {
                '',
                'externals/certi_common_libs',
                'externals/smart_platform',
                'externals/certi_formatter',
                'buildroot',
                'externals/certi_libwpe',
                'externals/certi_wpe',
                'externals/wpebackend-certi',
                'externals/surrogate',
                'externals/photoframe_cc',
            },
        })
    end
end

local wk = require("which-key")

wk.register({
    b = {
        name = "Neotree",
        b = { "<cmd>Neotree left toggle=true<cr>", "Toggle Project Drawer" },
        B = { "<cmd>Neotree float focus reveal<cr>", "Open Project Drawer on Current File" },
        a = { "<cmd>Neotree left float buffers<cr>", "Show Opened Buffers" },
    },
    f = {
        name = "Telescope",
        f = { "<cmd>Telescope find_files<cr>", "Find Files"},
        g = { "<cmd>Telescope git_files<cr>", "Git Files"},
        F = { expanded_builtin_picker("find_files"), "Find Files With Externals"},
        b = { "<cmd>Telescope buffers<cr>", "Buffers"},
        O = { "<cmd>Telescope oldfiles<cr>", "Recent Files"},
        o = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols"},
        s = { require("auto-session.session-lens").search_session, "Sessions" },
        l = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
        L = { expanded_builtin_picker("live_grep"), "Live Grep with Externals" },
        p = { "<cmd>Telescope commands<cr>", "Commands" },
        c = { "<cmd>Telescope colorscheme<cr>", "Colorschemes" },
        t = { "<cmd>Telescope builtin<cr>", "Builtin Pickers" },
    },
    w = { "<C-W>", "Windows", noremap = false,},
    q = { "<cmd>Bdelete<CR>", "Close Buffer"},
    Q = { "<cmd>bdelete<CR>", "Close Buffer and Window"},
    K = { "<cmd>lua require'dap.ui.widgets'.cursor_float()<CR>", "Show Debug Hover" },
    D = { "<cmd>lua require'dapui'.toggle()<CR>", "Toggle Debug UI" },
    e = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Show Diagnostic Hover" },
    t = { require('whitespace-nvim').trim, "Trim Whitespace" },
}, { prefix = "<leader>" })

wk.register({
    "Navigation",
    ["]"] = {
        "Navigate Next",
        b = { "<cmd>bn<CR>", "Buffer" },
        e = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Diagnostic" },
    },
    ["["] = {
        "Navigate Previous",
        b = { "<cmd>bp<CR>", "Buffer" },
        e = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Diagnostic" },
    },
    ["<F5>"] = { "<cmd>lua require'dap'.continue()<CR>", "Continue Debugging" },
    ["<F9>"] = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "Toggle Breakpoint" },
    ["<F10>"] = { "<cmd>lua require'dap'.step_over()<CR>", "Step Over" },
    ["<F11>"] = { "<cmd>lua require'dap'.step_into()<CR>", "Step Into" },
})
