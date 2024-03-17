return {
    { 'tpope/vim-abolish', cmd = {"Subvert", "S"}, keys = {"cr",}, },
    { 'folke/neodev.nvim', lazy = true, ft = "lua", opts = {}, } ,
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
                show_end = false,
            },
        }
    },
    { 'famiu/bufdelete.nvim', cmd = { "Bdelete", "Bwipeout" }, },
    { 'kylechui/nvim-surround', version = "*",                   keys = { "ys", "ds", "cs" }, config = true, },
    { 'numToStr/Comment.nvim',  keys = { "gc", "gb" },           config = true, },
    { 'neovim/nvim-lspconfig', event = "VeryLazy", },
    {
        'lewis6991/gitsigns.nvim',
        event = "VeryLazy",
        opts = {
            on_attach = function(_)
                local wk = require("which-key")
                wk.register({
                    "Navigation",
                    ["]"] = {
                        "Navigate Next",
                        c = {"<cmd>Gitsigns next_hunk<CR>", "Hunk"},
                    },
                    ["["] = {
                        "Navigate Previous",
                        c = {"<cmd>Gitsigns prev_hunk<CR>", "Hunk"},
                    }
                })

                wk.register({
                    ["gb"] = { "<cmd>Gitsigns blame_line<CR>", "Toggle Git Blame" },
                    ["grh"] = { "<cmd>Gitsigns reset_hunk<CR>", "Reset Hunk" },
                    ["grb"] = { "<cmd>Gitsigns reset_buffer<CR>", "Reset File" },
                }, { prefix = "<leader>" })
            end,
            current_line_blame = false,
        }
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
        'folke/which-key.nvim',
        opts = {
            plugins = {
                registers = false,
                marks = false,
            },
            presets = {
                operators = false,
                motions = false,
                text_objects = false,
            },
            window = {
                border = "single", -- none, single, double, shadow
                position = "bottom", -- bottom, top
                margin = { 0, 0, 1, 0.7 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
                padding = { 0, 0, 0, -1 }, -- extra window padding [top, right, bottom, left]
                winblend = 20, -- value between 0-100 0 for fully opaque and 100 for fully transparent
                zindex = 1000, -- positive value to position WhichKey above other floating windows.
            },
            layout = {
                height = { min = 4, max = 40 }, -- min and max height of the columns
                spacing = 3, -- spacing between columns
                align = "left", -- align columns left, center or right
            },
        },
        config = function(_, opts)
            require("which-key").setup(opts)
            require("keymaps")
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
        'echasnovski/mini.completion',
        dependencies = { 'echasnovski/mini.pairs' },
        version = '*',
        config = function()
            require("completion")
            require("mini.pairs").setup()
            require("mini.completion").setup({ set_vim_settings = false, })
            vim.opt.shortmess:append('c')
            vim.opt.shortmess:append('C')
            vim.opt.completeopt = 'menuone,noinsert,popup'
        end
    },
}
