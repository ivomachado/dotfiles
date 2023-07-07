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
    { 'NMAC427/guess-indent.nvim', event = "BufEnter", config = true},
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
    {
        'stevearc/dressing.nvim',
        config = function()
            require("dressing").setup({
                select = {
                    telescope = require('telescope.themes').get_cursor({}),
                }
            })
        end,
    },
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
        "Mofiqul/vscode.nvim",
        lazy = false,
        priority = 1001,
        config = function(_, opts)
            require'vscode'.setup(opts)
            require'vscode'.load()
        end,
        enabled = false,
    },
    {
        "loctvl842/monokai-pro.nvim",
        lazy = false,
        priority = 1001,
        opts = {},
        config = function(_, opts)
            require'monokai-pro'.setup(opts)
            vim.cmd([[colorscheme monokai-pro-classic]])
        end,
        enabled = true,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        opts = {
            flavour = "frappe",
            background = {
                light = "latte",
                dark = "frappe",
            },
            integrations = {
                neotree = true,
                cmp = true,
                gitsigns = true,
            },
            color_overrides = {
                frappe = {
                    comment = "#ffffff",
                },
            },
        },
        config = function(_, opts)
            require'catppuccin'.setup(opts)
            vim.cmd([[colorscheme catppuccin]])
        end,
        priority = 1000,
        enabled = false,
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
        opts = {
            on_attach = function(bufnr)
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
                    ["hb"] = { "<cmd>Gitsigns blame_line<CR>", "Toggle Git Blame" },
                }, { prefix = "<leader>" })
            end,
            current_line_blame = false,
        }
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
        "akinsho/toggleterm.nvim",
        event = "VeryLazy",
        opts = {
            start_in_insert = true,
            shading_factor = '-40',
            size = 23,
        }
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
            callbacks = {
                should_block = function(argv)
                    -- Note that argv contains all the parts of the CLI command, including
                    -- Neovim's path, commands, options and files.
                    -- See: :help v:argv

                    -- In this case, we would block if we find the `-b` flag
                    -- This allows you to use `nvim -b file1` instead of `nvim --cmd 'let g:flatten_wait=1' file1`
                    return vim.tbl_contains(argv, "-b")

                    -- Alternatively, we can block if we find the diff-mode option
                    -- return vim.tbl_contains(argv, "-d")
                end,
                post_open = function(bufnr, winnr, ft, is_blocking)
                    if is_blocking then
                        -- Hide the terminal while it's blocking
                        require("toggleterm").toggle(0)
                    else
                        -- If it's a normal file, just switch to its window
                        vim.api.nvim_set_current_win(winnr)
                    end

                    -- If the file is a git commit, create one-shot autocmd to delete its buffer on write
                    -- If you just want the toggleable terminal integration, ignore this bit
                    if ft == "gitcommit" then
                        vim.api.nvim_create_autocmd(
                            "BufWritePost",
                            {
                                buffer = bufnr,
                                once = true,
                                callback = function()
                                    -- This is a bit of a hack, but if you run bufdelete immediately
                                    -- the shell can occasionally freeze
                                    vim.defer_fn(
                                        function()
                                            vim.api.nvim_buf_delete(bufnr, {})
                                        end,
                                        50
                                    )
                                end
                            }
                        )
                    end
                end,
                block_end = function()
                    -- After blocking ends (for a git commit, etc), reopen the terminal
                    require("toggleterm").toggle(0)
                end
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
    },
    {
        "echasnovski/mini.animate",
        version = false,
        opts = {
            cursor = { enable = false, },
            scroll = { enable = true, },
        },
        enabled = false,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 600
        end,
        opts = {
            plugins = {
                registers = false,
                marks = false,
            },
            presets = {
                operators = false,
                motions = false,
                text_objects = false,
            }
        }
    },
    -- { "windwp/nvim-autopairs", config = true, },
    {
        'Wansmer/treesj',
        keys = { '<space>m', '<space>j', '<space>s' },
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require('treesj').setup({--[[ your config ]]})
        end,
    },
}
