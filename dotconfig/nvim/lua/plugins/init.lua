return {
    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
        enabled = false,
    },
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
    { 'NMAC427/guess-indent.nvim', config = true},
    { 'michaeljsmith/vim-indent-object', event = "BufEnter", },
    { 'PeterRincker/vim-argumentative', event = "BufEnter", },
    {
        'johnfrankmorgan/whitespace.nvim',
        event = "VeryLazy",
        opts = {
            highlight = 'DiffDelete',
            ignored_filetypes = { 'TelescopePrompt', 'Trouble', 'help', 'lspinfo', 'toggleterm', 'neo-tree', 'lazy', 'mason', 'checkhealth'},
            ignore_terminal = true,
        },
        enabled = false,
    },
    {
        'lukas-reineke/indent-blankline.nvim',
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
    { 'folke/trouble.nvim', cmd = {"Trouble", "TroubleToggle"}, opts = { icons = false}},
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
        end,
        lazy = true,
    },
    {
        'numToStr/Comment.nvim',
        keys = {"gc", "gb"},
        config = true,
    },
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
        build = ':TSUpdate',
        opts = {
            auto_install = true,
            sync_install = false,
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
        "folke/which-key.nvim",
        -- keys = {"<leader>", "[", "]" , "<M-;>",},
        --
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
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
    {
        enabled = false,
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
        lazy = true,
        config = function()
            require('lint').linters_by_ft = {
                cpp = { 'cppcheck', },
            }
            vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
                callback = function()
                    require("lint").try_lint()
                end,
            })
        end,
        enabled = false,
    },
    {
        "j-hui/fidget.nvim",
        event = "LspAttach",
        opts = {},
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
    "wincent/ferret",
    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "ibhagwan/fzf-lua",
        config = function()
            vim.cmd("FzfLua register_ui_select")
            -- calling `setup` is optional for customization
            require("fzf-lua").setup({
                "telescope",
                fzf_opts = {
                    ["--layout"] = "reverse",
                },
                -- winopts = {
                --     height     = 0.85,       -- window height
                --     width      = 0.80,       -- window width
                --     row        = 0.35,       -- window row position (0=top, 1=bottom)
                --     col        = 0.50,       -- window col position (0=left, 1=right)
                --     border     = "single",
                -- },
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
}
