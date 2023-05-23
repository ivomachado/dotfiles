return {
    'tpope/vim-repeat',
    'tpope/vim-abolish',
    'jghauser/mkdir.nvim',
    "folke/neodev.nvim",
    { 'mfussenegger/nvim-dap', event = "VeryLazy" },
    {
        'rcarriga/nvim-notify', config = function()
            vim.notify = require("notify")
        end
    },
    'roryokane/detectindent',
    'michaeljsmith/vim-indent-object',
    'PeterRincker/vim-argumentative',
    {
        'johnfrankmorgan/whitespace.nvim',
        opts = {
            highlight = 'DiffDelete',
            ignored_filetypes = { 'TelescopePrompt', 'Trouble', 'help' },
            ignore_terminal = true,
        },
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require("indent_blankline").setup {
                show_end_of_line = true,
                show_current_context = true,
                indent_blankline_show_first_indent_level = false,
            }
            vim.cmd [[highlight IndentBlanklineSpaceChar guifg=nocombine]]
        end,
    },
    'folke/trouble.nvim',
    {
        'stevearc/dressing.nvim',
    },
    'kevinhwang91/nvim-bqf',
    { 'CoatiSoftware/vim-sourcetrail', event = "VeryLazy"},
    'moll/vim-bbye',
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
        end
    },
    {
        "lewis6991/hover.nvim",
        opts = {
            init = function()
                require("hover.providers.lsp")
            end,
            preview_opts = {
                border = nil
            },
            preview_window = false,
            title = true
        },
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
                enable = false,
            },

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        },
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
        opts = {
            window_height_change_amount = 10,
        },
    },

    {
        'dstein64/nvim-scrollview',
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
        config = true,
        lazy = false, priority = 1001,
    },
    {
        "andrewferrier/debugprint.nvim",
        opts = {},
        dependencies = {
            "nvim-treesitter/nvim-treesitter"
        },
        version = "*"
    }
}
