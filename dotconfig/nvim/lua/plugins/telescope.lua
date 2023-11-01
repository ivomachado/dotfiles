return {
    {
        'nvim-telescope/telescope-fzy-native.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim' },
        lazy = true,
    },
    {
        'nvim-telescope/telescope.nvim',
        cmd = "Telescope",
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        opts = {
            defaults = {
                preview = {
                    treesitter = false,
                },
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
                        -- ["<CR>"]  = "select_drop",
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
                -- layout_strategy = "horizontal",
                fuzzy = true,                    -- false will only do exact matching
                dynamic_preview_title = false,
                path_display = { "truncate" },
            },
            pickers = {
                find_files = {
                    preview = {
                        hide_on_startup = true,
                    },
                    hidden = true,
                    theme = "dropdown",
                    layout_config = { width = 0.80, height = 0.40, },
                }
            },
            extensions = {
                ["zf-native"] = {
                    -- options for sorting file-like items
                    file = {
                        -- override default telescope file sorter
                        enable = true,

                        -- highlight matching text in results
                        highlight_results = true,

                        -- enable zf filename match priority
                        match_filename = true,
                    },

                    -- options for sorting all other items
                    generic = {
                        -- override default telescope generic item sorter
                        enable = true,

                        -- highlight matching text in results
                        highlight_results = true,

                        -- disable zf filename match priority
                        match_filename = false,
                    },
                }
            }
        },
        config = function(_, opts)
            require("telescope").setup(opts)
            require("auto-session").setup_session_lens()
            require("telescope").load_extension "session-lens"
            require('telescope').load_extension('zf-native')
        end,
    }
}
