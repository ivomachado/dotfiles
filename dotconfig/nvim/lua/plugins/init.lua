return {
    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {}
    },
    { 'tpope/vim-repeat', event = "BufEnter", },
    { 'tpope/vim-abolish', cmd = {"Subvert", "S"}, keys = {"cr",}, },
    { 'jghauser/mkdir.nvim', event = "BufWritePre", },
    { 'mfussenegger/nvim-dap', lazy = true },
    { "folke/neodev.nvim", lazy = true, ft = "lua", opts = {}, } ,
    {
        'rcarriga/nvim-notify',
        lazy = true,
        init = function()
            vim.notify = function(msg, level, opts)
                vim.notify = require("notify")
                vim.notify(msg, level, opts)
           end
        end,
    },
    { 'NMAC427/guess-indent.nvim', event = "BufEnter", config = true},
    { 'michaeljsmith/vim-indent-object', event = "BufEnter", },
    { 'PeterRincker/vim-argumentative', event = "BufEnter", },
    {
        'johnfrankmorgan/whitespace.nvim',
        event = "VeryLazy",
        opts = {
            highlight = 'DiffDelete',
            ignored_filetypes = { 'TelescopePrompt', 'Trouble', 'help', 'lspinfo', 'toggleterm', 'neo-tree', 'lazy', 'mason'},
            ignore_terminal = true,
        },
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        event = "VeryLazy",
        config = function()
            -- local hooks = require "ibl.hooks"
            -- hooks.register(
            --     hooks.type.WHITESPACE,
            --     hooks.builtin.hide_first_space_indent_level
            -- )
            require("ibl").setup {
                indent = { char = "│" },
                scope = {
                    enabled = false,
                    show_start = false,
                    show_end = false,
                },
            }

            vim.cmd [[highlight IndentBlanklineSpaceChar guifg=nocombine]]
        end,
    },
    { 'folke/trouble.nvim', cmd = {"Trouble", "TroubleToggle"}, },
    {
        'stevearc/dressing.nvim',
        lazy = true,
        init = function()
            local setup_dressing = function()
                require("dressing").setup({
                    select = {
                        telescope = require('telescope.themes').get_cursor({}),
                    }
                })
            end
            vim.ui.select = function(items, opts, on_choice)
                setup_dressing()
                vim.ui.select(items, opts, on_choice)
            end

            vim.ui.input = function(opts, on_confirm)
                setup_dressing()
                vim.ui.input(opts, on_confirm)
            end
        end,
    },
    { 'kevinhwang91/nvim-bqf', event = "QuickFixCmdPre", },
    { 'CoatiSoftware/vim-sourcetrail', cmd = "SourcetrailStartServer"},
    { 'famiu/bufdelete.nvim', cmd = { "Bdelete", "Bwipeout" }, },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        keys = {"ys", "ds", "cs"},
        config = true,
    },
    {
        {
            'williamboman/mason.nvim',
            -- event = "VeryLazy",
            config = function()
                require("confs/mason-setup")
            end,
        },
        {
            'williamboman/mason-lspconfig.nvim',
            lazy = true,
        },
        {
            'jay-babu/mason-nvim-dap.nvim',
            keys = {"<F5>", "<F9>", "<F10>", "<F11>"},
            opts = {
                automatic_setup = true,
                ensure_installed = {'cppdbg'},
                handlers = {},
                automatic_installation = false,
            },
            config = function(_, opts)
                require("mason-nvim-dap").setup(opts)
                require("confs/dap")
            end,
        },
    },
    {
        'rcarriga/nvim-dap-ui',
        config = function ()
            require("dapui").setup()
            local dap, dapui = require("dap"), require("dapui")

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            -- dap.listeners.before.event_terminated["dapui_config"] = function()
            --     dapui.close()
            -- end
            -- dap.listeners.before.event_exited["dapui_config"] = function()
            --     dapui.close()
            -- end
        end,
        lazy = true,
    },
    {
        'numToStr/Comment.nvim',
        keys = {"gc", "gb"},
        config = true,
    },
    -- {
    --     "anuvyklack/windows.nvim",
    --     event = "VeryLazy",
    --     dependencies = {
    --         "anuvyklack/middleclass",
    --     },
    --     opts = {
    --         ignore = {
    --             buftype = { "quickfix", "terminal", "neo-tree"}
    --         }
    --     },
    -- },
    {
        'neovim/nvim-lspconfig',
        event = "VeryLazy",
        dependencies = "williamboman/mason.nvim",
    },
    {
        'p00f/clangd_extensions.nvim',
        lazy = true,
        dependencies = "neovim/nvim-lspconfig"
    },
    {
        'lewis6991/gitsigns.nvim',
        event = "VeryLazy",
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
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
                    ["hb"] = { "<cmd>Gitsigns blame_line<CR>", "Toggle Git Blame" },
                }, { prefix = "<leader>" })
            end,
            current_line_blame = false,
        }
    },
    {
        'nvim-treesitter/nvim-treesitter',
        -- version = "main",
        enabled = true,
        build = ':TSUpdate',
        opts = {
            -- A list of parser names, or "all"
            -- ensure_installed = { "c", "svelte", "cpp", "lua", "rust" , "typescript", "css", "html", "javascript", "vim"},
            auto_install = true,

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- List of parsers to ignore installing (for "all")
            --
            -- indent = {
            --     enable = disable,
            -- },

            highlight = {
                enable = true,
                -- disable = {
                --     "bash",
                --     "cmake",
                -- },
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
            auto_session_suppress_dirs = {'~/', '~/projects'},
            session_lens = {
                load_on_setup = false,
            },
        },
    },
    {
        "akinsho/toggleterm.nvim",
        enabled = false,
        cmd = "ToggleTerm",
        init = function ()
            require("which-key").register({
                name = "Terminal",
                ["<M-;>"] = {"<cmd>ToggleTerm direction=horizontal<cr>", "Toggle Terminal"},
                ["<M-j><M-k>"] = {"<C-\\><C-n>", "Exit Terminal Mode"},
                ["<M-f>"] = {"<cmd>ToggleTerm direction=float<cr>", "Toggle Float Terminal"},
                ["<M-1>"] = {"<cmd>1ToggleTerm<cr>", "Toggle Terminal 1"},
                ["<M-2>"] = {"<cmd>2ToggleTerm<cr>", "Toggle Terminal 2"},
                ["<M-3>"] = {"<cmd>3ToggleTerm<cr>", "Toggle Terminal 3"},
                ["<M-4>"] = {"<cmd>4ToggleTerm<cr>", "Toggle Terminal 4"},
                ["<M-5>"] = {"<cmd>5ToggleTerm<cr>", "Toggle Terminal 5"},
            }, { mode = {"t", "n"} })
        end,
        opts = {
            start_in_insert = true,
            shading_factor = '-55',
            auto_scroll = false,
            size = 23,
        }
    },
    {
        'dstein64/nvim-scrollview',
        enabled = false,
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
        enabled = false,
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
                pre_open = function()
                    local term = require("toggleterm.terminal")
                    local termid = term.get_focused_id()
                    SavedTerminal = term.get(termid)
                end,
                post_open = function(bufnr, winnr, ft, is_blocking)
                    if is_blocking and SavedTerminal then
                        SavedTerminal:close()
                    else
                        -- If it's a normal file, just switch to its window
                        vim.api.nvim_set_current_win(winnr)
                    end

                    -- If the file is a git commit, create one-shot autocmd to delete its buffer on write
                    -- If you just want the toggleable terminal integration, ignore this bit
                    if ft == "gitcommit" or ft == "gitrebase" then
                        vim.api.nvim_create_autocmd(
                            "BufWritePost",
                            {
                                buffer = bufnr,
                                once = true,
                                callback = vim.schedule_wrap(function()
                                    -- This is a bit of a hack, but if you run bufdelete immediately
                                    -- the shell can occasionally freeze
                                    require('bufdelete').bufdelete(bufnr)
                                end
                                )
                            }
                        )
                    end
                end,
                block_end = function()
                    -- After blocking ends (for a git commit, etc), reopen the terminal
                    vim.schedule(function()
                        if SavedTerminal then
                            SavedTerminal:open()
                            SavedTerminal = nil
                        end
                    end)
                end,
            },
        },
        lazy = false, priority = 1001,
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
        -- keys = {"<leader>", "[", "]" , "<M-;>",},
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 3000
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
        },
        config = function(_, opts)
            require("which-key").setup(opts)
            require("keymaps")
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function ()
            require("nvim-autopairs").setup{}

            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            local cmp = require('cmp')
            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done()
            )
        end
    },
    -- { "bfrg/vim-cpp-modern", ft = {"c", "cpp",}, },
    {
        "nvimdev/hlsearch.nvim",
        event = "BufRead",
        opts = {},
    },
    {
        "kdheepak/lazygit.nvim",
        enabled = false,
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        'mfussenegger/nvim-lint',
        event = "VeryLazy",
        config = function ()
            require('lint').linters_by_ft = {
                cpp = {'cppcheck',}
            }
            vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
                callback = function()
                    require("lint").try_lint()
                end,
            })
        end,
    },
}
