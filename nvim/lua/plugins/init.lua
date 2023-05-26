return {
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {}
    },
    { 'tpope/vim-repeat', event = "VeryLazy", },
    { 'tpope/vim-abolish', event = "VeryLazy", },
    { 'jghauser/mkdir.nvim', event = "VeryLazy", },
    { "folke/neodev.nvim", event = "VeryLazy", },
    { 'mfussenegger/nvim-dap', event = "VeryLazy" },
    {
        'rcarriga/nvim-notify',
        event = "VeryLazy",
        config = function()
            vim.notify = require("notify")

            require('telescope').load_extension('notify')
        end
    },
    { 'roryokane/detectindent', event = "BufEnter", },
    { 'michaeljsmith/vim-indent-object', event = "VeryLazy", },
    { 'PeterRincker/vim-argumentative', event = "VeryLazy", },
    {
        'johnfrankmorgan/whitespace.nvim',
        event = "VeryLazy",
        opts = {
            highlight = 'DiffDelete',
            ignored_filetypes = { 'TelescopePrompt', 'Trouble', 'help' },
            ignore_terminal = true,
        },
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        event = "VeryLazy",
        config = function()
            require("indent_blankline").setup {
                show_end_of_line = true,
                show_current_context = true,
                indent_blankline_show_first_indent_level = false,
            }
            vim.cmd [[highlight IndentBlanklineSpaceChar guifg=nocombine]]
        end,
    },
    { 'folke/trouble.nvim', event = "VeryLazy", },
    { 'stevearc/dressing.nvim', },
    { 'kevinhwang91/nvim-bqf', event = "VeryLazy", },
    { 'CoatiSoftware/vim-sourcetrail', cmd = "SourcetrailStartServer"},
    { 'moll/vim-bbye', cmd = "Bdelete", },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = true,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
            require'catppuccin'.setup({
                integrations = {
                    neotree = {
                        enabled = true
                    },
                },
            })
            vim.cmd([[colorscheme catppuccin-frappe]])
        end,
        priority = 1000,
    },
    {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'jay-babu/mason-nvim-dap.nvim',
    },
    {
        'rcarriga/nvim-dap-ui',
        event = "VeryLazy",
        config = function ()
            require("dapui").setup()
            local dap, dapui = require("dap"), require("dapui")

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end,
        lazy = true,
    },
    {
        'numToStr/Comment.nvim',
        config = true,
    },
    {
        "anuvyklack/windows.nvim",
        dependencies = {
            "anuvyklack/middleclass",
        },
        opts = {
            ignore = {
                buftype = { "quickfix", "terminal" }
            }
        },
    },
    {
        'neovim/nvim-lspconfig',
        'p00f/clangd_extensions.nvim',
    },
    {
        'lewis6991/gitsigns.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        opts = {
            -- A list of parser names, or "all"
            ensure_installed = { "c", "svelte", "cpp", "lua", "rust" , "typescript", "css", "html", "javascript", "vim"},
            auto_install = true,

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- List of parsers to ignore installing (for "all")
            --
            indent = {
                enable = true,
            },

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        },
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)
        end,
    },

    {
        'rmagatti/auto-session',
        opts = {
            log_level = 'error',
            auto_session_suppress_dirs = {'~/', '~/projects'}
        },
    },

    {
        's1n7ax/nvim-terminal',
        event = "VeryLazy",
        opts = {
            window_height_change_amount = 10,
        },
    },

    {
        'dstein64/nvim-scrollview',
        event = "VeryLazy",
        opts = {
            excluded_filetypes = {'nerdtree'},
            current_only = true,
            winblend = 50,
            scrollview_base = 'right',
            scrollview_column = 1
        },
    },
    {
        'willothy/flatten.nvim',
        opts = {
            window = {
                open = "alternate",
            },
        },
        lazy = false, priority = 1001,
    },
    {
        "andrewferrier/debugprint.nvim",
        opts = {},
        event = "VeryLazy",
        dependencies = {
            "nvim-treesitter/nvim-treesitter"
        },
        version = "*"
    }
}
