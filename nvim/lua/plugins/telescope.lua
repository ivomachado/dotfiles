return {
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim' },
        build = 'make',
        config = function()
            require('telescope').load_extension('fzf')
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        opts = {
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
                layout_strategy = "vertical",
                fuzzy = true,                    -- false will only do exact matching
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
            },
            extensions = {
            }
        },
    }
}
