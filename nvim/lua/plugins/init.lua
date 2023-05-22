return {
    'tpope/vim-repeat',
    'tpope/vim-abolish',
    'jghauser/mkdir.nvim',
    "folke/neodev.nvim",
    { 'mfussenegger/nvim-dap', event = "VeryLazy" },
    'rcarriga/nvim-notify',
    'roryokane/detectindent',
    'michaeljsmith/vim-indent-object',
    'PeterRincker/vim-argumentative',
    {
        'johnfrankmorgan/whitespace.nvim',
        config = function ()
            require('whitespace-nvim').setup({
                -- configuration options and their defaults

                -- `highlight` configures which highlight is used to display
                -- trailing whitespace
                highlight = 'DiffDelete',

                -- `ignored_filetypes` configures which filetypes to ignore when
                -- displaying trailing whitespace
                ignored_filetypes = { 'TelescopePrompt', 'Trouble', 'help' },

                -- `ignore_terminal` configures whether to ignore terminal buffers
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
        end
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
        'nvim-lualine/lualine.nvim',
        dependencies =  'kyazdani42/nvim-web-devicons',
        config = function()
            require('lualine').setup{
                extensions = {'quickfix', 'neo-tree'},
                options = {
                    icons_enabled = true,
                    component_separators = { left = '', right = ''},
                    section_separators = { left = '', right = ''},
                    disabled_filetypes = {},
                    theme = 'auto',
                    always_divide_middle = true,
                    globalstatus = true,
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff'},
                    lualine_c = {{'filename', path = 1}, 'diagnostics'},
                    lualine_x = {'encoding', 'fileformat', 'filetype'},
                    lualine_y = {'progress', function()
                        if vim.bo.expandtab then
                            return [[Spaces: ]]..vim.bo.shiftwidth
                        else
                            return [[Tab size: ]]..vim.bo.tabstop
                        end
                    end, 'location'},
                    lualine_z = {'tabs'}
                },
                inactive_winbar = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {{'filename', path = 1}},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {}
                },
                winbar = {
                    lualine_a = {{'filename', path = 1}},
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {}
                },
            }

        end,
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
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        config = function()
            vim.fn.sign_define("DiagnosticSignError",
                {text = " ", texthl = "DiagnosticSignError"})
            vim.fn.sign_define("DiagnosticSignWarn",
                {text = " ", texthl = "DiagnosticSignWarn"})
            vim.fn.sign_define("DiagnosticSignInfo",
                {text = " ", texthl = "DiagnosticSignInfo"})
            vim.fn.sign_define("DiagnosticSignHint",
                {text = "", texthl = "DiagnosticSignHint"})

            require("neo-tree").setup({
                close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
                enable_git_status = true,
                enable_diagnostics = true,
                window = {
                    mappings = { ["<space>"] = "none",  ["<F2>"] = "rename", }
                },
                default_component_configs = {
                    git_status = {
                        symbols = {
                            -- Change type
                            added     = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
                            modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
                            deleted   = "✖",-- this can only be used in the git_status source
                            renamed   = "",-- this can only be used in the git_status source
                            -- Status type
                            untracked = "",
                            ignored   = "",
                            unstaged  = "",
                            staged    = "",
                            conflict  = "",
                        }
                    },
                },
                filesystem = {
                    use_libuv_file_watcher = true,
                    filtered_items = {
                        visible = true, -- when true, they will just be displayed differently than normal items
                        hide_dotfiles = true,
                        hide_gitignored = true,
                        hide_hidden = true, -- only works on Windows for hidden files/directories
                        hide_by_name = {
                        },
                        hide_by_pattern = { -- uses glob style patterns
                            --"*.meta"
                        },
                        never_show = { -- remains hidden even if visible is toggled to true
                            ".git",
                            ".clangd",
                            ".cache",
                            ".ccache",
                            "ccache",
                            ".vscode",
                            ".ccls-cache",
                            "Session.vim",
                        },
                    },
                },
            })


            require('telescope').load_extension('fzf')
            require('telescope').load_extension('notify')
        end
    },


    {
        'nvim-telescope/telescope.nvim',
        -- branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require('telescope').setup{
                defaults = {
                    mappings = {
                        i = {
                            ["<C-k>"] = "move_selection_previous",
                            ["<C-j>"] = "move_selection_next",
                            ["<C-p>"] = "cycle_history_prev",
                            ["<C-n>"] = "cycle_history_next",
                            ["<C-z>"] = "toggle_selection",
                            ["<C-o>"] = "smart_send_to_qflist",
                            ["<C-a>"] = "smart_add_to_qflist",
                            ["<esc>"] = "close",
                            ["<CR>"]  = "select_drop",
                        },
                        n = {
                            ["<C-k>"] = "move_selection_previous",
                            ["<C-j>"] = "move_selection_next",
                            ["<C-p>"] = "cycle_history_prev",
                            ["<C-n>"] = "cycle_history_next",
                            ["<C-z>"] = "toggle_selection",
                            ["<C-o>"] = "smart_send_to_qflist",
                            ["<C-a>"] = "smart_add_to_qflist",
                            ["<CR>"]  = "select_drop",
                        },
                    },
                    layout_strategy = "vertical",
                    fuzzy = true,                    -- false will only do exact matching
                    override_generic_sorter = true,  -- override the generic sorter
                    override_file_sorter = true,     -- override the file sorter
                    case_mode = "ignore_case",       -- or "ignore_case" or "respect_case" the default case_mode is "smart_case"
                    dynamic_preview_title = true,
                    layout_config = {
                        width = 0.75,
                    },
                },
                pickers = {
                    find_files = {
                        -- theme = "dropdown",
                        search_dirs = {
                            './',
                            'externals/certi_common_libs',
                            'externals/smart_platform',
                            'externals/certi_formatter',
                            'buildroot',
                            'externals/certi_libwpe',
                            'externals/certi_wpe',
                            'externals/wpebackend-certi',
                        },
                    },
                    live_grep = {
                        search_dirs = {
                            './',
                            'externals/certi_common_libs',
                            'externals/smart_platform',
                            'buildroot',
                            'externals/certi_libwpe',
                            'externals/certi_wpe',
                            'externals/wpebackend-certi',
                        },
                    },
                    lsp_document_symbols = {
                        fname_width = 50,
                    },
                    commands = {
                        theme = "dropdown",
                    },
                }
            }
        end
    },


    {'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },

    {
        'lewis6991/gitsigns.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
    },

    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
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
