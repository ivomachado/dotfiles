local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'tpope/vim-sensible'
    use 'tpope/vim-abolish'

    use 'mattn/emmet-vim'

    use {
        'Shatur/neovim-ayu',
        config = function ()
            require('ayu').setup({
                mirage = false,
                overrides = {},
            })
        end
    }

    use {
        'nvim-lualine/lualine.nvim',
        require = { 'kyazdani42/nvim-web-devicons', opt = true },
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
        disable = false
    }

    use {
        "folke/twilight.nvim",
        config = function()
            require("twilight").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end,
        disable = true
    }

    use {
        "feline-nvim/feline.nvim",
        config = function()
            require("feline").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end,
        disable = true,
    }

    use {'dracula/vim', as = 'dracula', disable = false}
    use {'sainnhe/everforest', disable = false}
    use {'marko-cerovac/material.nvim', disable = true}
    use {'folke/tokyonight.nvim', disable = false}
    use {"adisen99/codeschool.nvim", requires = {"rktjmp/lush.nvim"}}
    use({
        "catppuccin/nvim",
        as = "catppuccin",
        config = function()
            vim.g.catppuccin_flavour = "macchiato"
            require'catppuccin'.setup({
                integrations = {
                    neotree = {
                        enabled = true
                    },
                },
            })
        end
    })
    use 'Mofiqul/vscode.nvim'
    use 'Th3Whit3Wolf/onebuddy'
    use {
        'EdenEast/nightfox.nvim',
        config = function()
            require('nightfox').setup({
                options = {
                    terminal_colors = true,
                    dim_inactive = false,
                },
            })
        end
    }

    use 'Th3Whit3Wolf/space-nvim'
    use ({ 'projekt0n/github-nvim-theme' })
    use {
        'sonph/onehalf',
        rtp = 'vim',
        config = function()
            vim.cmd("colorscheme onehalfdark")
        end,
        disable = true
    }

    use {
        "mcchrish/zenbones.nvim",
        -- Optionally install Lush. Allows for more configuration or extending the colorscheme
        -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
        -- In Vim, compat mode is turned on as Lush only works in Neovim.
        requires = "rktjmp/lush.nvim"
    }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use 'brooth/far.vim'
    use 'rcarriga/nvim-notify'

    use 'roryokane/detectindent'
    use 'michaeljsmith/vim-indent-object'
    use 'PeterRincker/vim-argumentative'
    use 'lukas-reineke/indent-blankline.nvim' -- Adiciona guidelines e mostra os espaços

    use {
        "beauwilliams/focus.nvim",
        config = function()
            require("focus").setup{
                bufnew =  false,
                hybridnumber = false,
                number = false,
                autoresize = false,
                signcolumn = false,
                compatible_filetrees = {"neo-tree"}
            }
        end,
    }

    use {
        'neovim/nvim-lspconfig', -- Collection of configurations for the built-in LSP client
        'williamboman/nvim-lsp-installer', -- Install LSP clients
        'p00f/clangd_extensions.nvim',
    }
    use 'hrsh7th/nvim-cmp' -- Plugin de AutoComplete
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/cmp-nvim-lsp' -- Fonte de LSP para autocomplete
    use 'hrsh7th/cmp-nvim-lua' -- Fonte de LSP para autocomplete
    use 'hrsh7th/cmp-path' -- Fonte de paths para autocomplete
    use 'hrsh7th/cmp-buffer' -- Fonte de palavras de buffer para autocomplete
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'hrsh7th/cmp-nvim-lsp-document-symbol'
    use 'onsails/lspkind-nvim' -- Mostra ícones no autocomplete

    use {
        -- Aquelas janelas flutuantes para mostrar previews com gpd, gpp, gP
        'rmagatti/goto-preview',
        config = function()
            require('goto-preview').setup {
                default_mappings = true,
            }
        end
    }

    use {
        'ms-jpq/chadtree',
        branch = 'chad',
        run =  'python3 -m chadtree deps',
        disable = true
    }

    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = { 
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
    }

    use 'CoatiSoftware/vim-sourcetrail'

    use 'moll/vim-bbye' -- Buffer management

    use {
        'nvim-telescope/telescope.nvim',
        requires = {
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
                        },
                        n = {
                            ["<C-k>"] = "move_selection_previous",
                            ["<C-j>"] = "move_selection_next",
                            ["<C-p>"] = "cycle_history_prev",
                            ["<C-n>"] = "cycle_history_next",
                            ["<C-z>"] = "toggle_selection",
                            ["<C-o>"] = "smart_send_to_qflist",
                            ["<C-a>"] = "smart_add_to_qflist",
                        },
                    },
                    layout_strategy = "vertical",
                    fuzzy = true,                    -- false will only do exact matching
                    override_generic_sorter = true,  -- override the generic sorter
                    override_file_sorter = true,     -- override the file sorter
                    case_mode = "ignore_case",       -- or "ignore_case" or "respect_case" the default case_mode is "smart_case"
                    dynamic_preview_title = true,
                },
                pickers = {
                    find_files = {
                        theme = "dropdown",
                        -- search_dirs = {'externals/'},
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
    }

    use {'stevearc/dressing.nvim'}

    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

    use {'kevinhwang91/nvim-bqf'} -- Better quickfix windows

    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
    }

    use {
        'nvim-treesitter/nvim-treesitter-context',
        config = function ()
            require'treesitter-context'.setup{
                default = {
                    'class',
                    'function',
                    'method',
                }
            }
        end,
        disable = true
    }

    use 'rmagatti/session-lens'
    use {
        'rmagatti/auto-session',
        config = function()
            require('auto-session').setup {
                log_level = 'info',
                auto_session_suppress_dirs = {'~/', '~/projects'}
                -- post_restore_cmd = 
            }
        end
    }

    use {
        's1n7ax/nvim-terminal',
        config = function()
            vim.o.hidden = true
            require('nvim-terminal').setup({
                window_height_change_amount = 10,
            })
        end,
    }

    use 'folke/trouble.nvim'

    use {
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
    }

    use {
        'weirongxu/plantuml-previewer.vim',
        requires = { {'tyru/open-browser.vim'}, {'aklt/plantuml-syntax'} },
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
