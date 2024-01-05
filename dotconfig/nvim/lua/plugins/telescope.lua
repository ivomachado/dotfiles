return {
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake install build --prefix build',
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
                    treesitter = true,
                },
                file_ignore_patterns = {
                    "toolchains",
                    ".build*",
                    "build",
                    ".git",
                    "node_modules",
                    "third_party",
                    ".ccache",
                    ".cache",
                },
                mappings = {
                    i = {
                        -- ["<C-k>"] = "move_selection_previous",
                        -- ["<C-j>"] = "move_selection_next",
                        -- ["<C-p>"] = "cycle_history_prev",
                        -- ["<C-n>"] = "cycle_history_next",
                        ["<S-Tab>"] = "move_selection_previous",
                        ["<Tab>"] = "move_selection_next",
                        ["<C-k>"] = "cycle_history_prev",
                        ["<C-j>"] = "cycle_history_next",
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
                layout_strategy = "horizontal",
                layout_config = {
                    prompt_position = "top",
                    width = 0.9,
                },
                sorting_strategy = "ascending",
                dynamic_preview_title = false,
                path_display = { "truncate" },
            },
            pickers = {
                find_files = {
                    preview = {
                        hide_on_startup = false,
                    },
                    hidden = true,
                    -- theme = "horizontal",
                    layout_config = {
                        width = 0.90,
                        height = 0.80,
                        prompt_position = "top",
                    },
                },
                colorscheme = {
                    enable_preview = true,
                    treesitter = true,
                }
            },
            extensions = {
                fzf = {
                    fuzzy = true,                    -- false will only do exact matching
                    override_generic_sorter = true,  -- override the generic sorter
                    override_file_sorter = true,     -- override the file sorter
                    case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                }
            },
        },
        config = function(_, opts)
            require("telescope").setup(opts)
            -- require("auto-session").setup_session_lens()
            -- require("telescope").load_extension "session-lens"
            require("telescope").load_extension("fzf")
        end,
    }
}
