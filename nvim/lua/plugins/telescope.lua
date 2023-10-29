return {
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        lazy = true,
        dependencies = { 'nvim-telescope/telescope.nvim' },
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    },
    {
        'prochri/telescope-all-recent.nvim',
        lazy = true,
        dependencies = { 'nvim-telescope/telescope.nvim', 'kkharji/sqlite.lua' },
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
            extensions = { }
        },
        config = function(_, opts)
            require("telescope").setup(opts)
            require("auto-session").setup_session_lens()
            require("telescope").load_extension "session-lens"
            require'telescope-all-recent'.setup{}
            require('telescope').load_extension('fzf')
        end,
    }
}
