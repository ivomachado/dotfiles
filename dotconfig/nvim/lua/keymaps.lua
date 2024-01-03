local function expanded_builtin_picker(builtin_picker)
    return function()
        local builtin = require("telescope.builtin")
        local cwDir = vim.fn.getcwd()
        local directories = vim.split(vim.fn.glob(cwDir.."/externals/*/"), '\n', {trimempty=true})
        table.insert(directories, 1, cwDir);
        return builtin[builtin_picker]({
            search_dirs = directories,
        })

        -- return builtin[builtin_picker]({
        --     search_dirs = { '',
        --         'externals/certi_common_libs',
        --         'externals/smart_platform',
        --         'externals/certi_formatter',
        --         'buildroot',
        --         'externals/certi_libwpe',
        --         'externals/certi_wpe',
        --         'externals/wpebackend-certi',
        --         'externals/surrogate',
        --         'externals/photoframe_cc',
        --     },
        -- })
    end
end

local wk = require("which-key")

wk.register({
    n = { "<cmd>Neotree float toggle=true<cr>", "Toggle Project Drawer" },
    N = { "<cmd>Neotree float focus reveal<cr>", "Open Project Drawer on Current File" },

    g = { "<cmd>Telescope git_files<cr>", "Find Git Files"},
    f = { expanded_builtin_picker("find_files"), "Find Files With Externals Subdir"},
    b = { "<cmd>Telescope buffers<cr>", "Buffers"},
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols"},
    -- S = { require("auto-session.session-lens").search_session, "Sessions" },
    l = { expanded_builtin_picker("live_grep"), "Live Grep with Externals" },
    p = { "<cmd>Telescope commands<cr>", "Commands" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorschemes" },
    w = { "<C-W>", "Windows", noremap = false,},

    q = { "<cmd>Bdelete<CR>", "Close Buffer"},
    Q = { "<cmd>bdelete<CR>", "Close Buffer and Window"},
    K = { "<cmd>lua require'dap.ui.widgets'.cursor_float()<CR>", "Show Debug Hover" },
    D = { "<cmd>lua require'dapui'.toggle()<CR>", "Toggle Debug UI" },
    e = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Show Diagnostic Hover" },
    -- ["<leader>"] = {"<cmd>Telekasten<CR>", "Notes"},
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
