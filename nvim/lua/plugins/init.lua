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
        config = function ()
            require('whitespace-nvim').setup({
                highlight = 'DiffDelete',
                ignored_filetypes = { 'TelescopePrompt', 'Trouble', 'help' },
                ignore_terminal = true,
            })

            -- remove trailing whitespace with a keybinding
            vim.keymap.set('n', '<Leader>t', require('whitespace-nvim').trim)
        end
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
        enabled = true,
    },
    'kevinhwang91/nvim-bqf',
    { 'CoatiSoftware/vim-sourcetrail', event = "VeryLazy"},
    'moll/vim-bbye',
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
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
        config = function()
            require("hover").setup {
                init = function()
                    require("hover.providers.lsp")
                end,
                preview_opts = {
                    border = nil
                },
                preview_window = false,
                title = true
            }

            -- Setup keymaps
            vim.keymap.set("n", "K", require("hover").hover, {desc = "hover.nvim"})
            vim.keymap.set("n", "gK", require("hover").hover_select, {desc = "hover.nvim (select)"})
        end
    },
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },
    {
        "beauwilliams/focus.nvim",
        config = function()
            require("focus").setup{
                bufnew =  false,
                hybridnumber = false,
                number = false,
                autoresize = false,
                signcolumn = false,
                compatible_filetrees = {"neo-tree"},
                excluded_filetypes = {'TelescopePrompt'}
            }
        end,
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
        config = function()
            require'nvim-treesitter.configs'.setup {
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
            }
        end
    },

    {
        'rmagatti/auto-session',
        config = function()
            require('auto-session').setup {
                log_level = 'error',
                auto_session_suppress_dirs = {'~/', '~/projects'}
            }
        end,
    },

    {
        's1n7ax/nvim-terminal',
        config = function()
            vim.o.hidden = true
            require('nvim-terminal').setup({
                window_height_change_amount = 10,
            })
        end,
    },

    {
        'dstein64/nvim-scrollview',
        config = function()
            require('scrollview').setup({
                excluded_filetypes = {'nerdtree'},
                current_only = true,
                winblend = 50,
                scrollview_base = 'right',
                scrollview_column = 1
            })
        end
    },
}
