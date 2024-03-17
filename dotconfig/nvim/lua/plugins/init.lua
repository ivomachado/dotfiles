return {
    { 'tpope/vim-abolish', cmd = {"Subvert", "S"}, keys = {"cr",}, },
    { 'folke/neodev.nvim', config = true},
    { 'neovim/nvim-lspconfig', event = "VeryLazy", },
    { 'NMAC427/guess-indent.nvim', config = true},
    { 'michaeljsmith/vim-indent-object', event = "BufEnter", },
    { 'PeterRincker/vim-argumentative', event = "BufEnter", },
    {
        'lukas-reineke/indent-blankline.nvim',
        name = 'ibl',
        opts = {
            indent = { char = "│" },
            scope = {
                enabled = false,
                show_start = false,
                show_end = false, },
        }
    },
    { 'famiu/bufdelete.nvim', cmd = { "Bdelete", "Bwipeout" }, },
    { 'kylechui/nvim-surround', version = "*",                   keys = { "ys", "ds", "cs" }, config = true, },
    { 'numToStr/Comment.nvim',  keys = { "gc", "gb" },           config = true, },
    {
        'lewis6991/gitsigns.nvim',
        event = "VeryLazy",
        opts = { current_line_blame = false, }
    },
    {
        'nvim-treesitter/nvim-treesitter',
        enabled = true,
        branch = 'main',
        build = ':TSUpdate',
        opts = {
            auto_install = true,
            ensure_install = { 'rust', 'cpp', 'lua' },
            sync_install = false,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        },
        config = function(_, opts)
            require('nvim-treesitter').setup(opts)
            vim.api.nvim_create_autocmd('FileType', {
                pattern = { 'cpp', 'rust', 'lua' },
                callback = function() vim.treesitter.start() end,
            })
        end,
    },
    {
        'stevearc/conform.nvim',
        opts = {
            formatters_by_ft = {
                cpp = { "clang_format", },
                rust = { "rustfmt", },
            }
        },

        init = function()
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
    },
    {
        "ibhagwan/fzf-lua",
        config = function()
            vim.cmd("FzfLua register_ui_select")
            require("fzf-lua").setup({
                "telescope",
                fzf_opts = {
                    ["--layout"] = "reverse",
                },
                winopts = {
                    height     = 0.85,       -- window height
                    width      = 0.80,       -- window width
                    row        = 0.35,       -- window row position (0=top, 1=bottom)
                    col        = 0.50,       -- window col position (0=left, 1=right)
                    border     = "single",
                    preview={
                        default='builtin'
                    }
                },
                files = {
                    fd_opts =
                    "--color=never --type f --hidden --no-ignore-vcs --follow --exclude .git --exclude .ccache --exclude .cache --exclude *.o",
                    prompt = '',
                    cwd_prompt = false,
                    actions = {
                        ["ctrl-g"] = false,
                    }
                },
            })
        end
    },
    {
        'echasnovski/mini.notify',
        version = false,
        config = function()
            require('mini.notify').setup({})
            vim.notify = require('mini.notify').make_notify()
        end
    },
    {
        'echasnovski/mini.pairs',
        version = '*',
        config = true
    },
}
