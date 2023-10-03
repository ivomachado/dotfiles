return {
    {
        "polirritmico/monokai-nightasty.nvim",
        lazy = false,
        priority = 1000,
        terminal_colors = false,
        opts = {
            hl_styles = {
                -- Background styles for sidebars (panels) and floating windows:
                floats = "dark", -- default, dark, transparent
                sidebars = "dark", -- default, dark, transparent
            },
            sidebars = { "qf", "help", "neo-tree"},
            lualine_bold = false,
            on_colors = function(colors)
                colors.border = colors.black
                colors.comment = "#2d7e79"
            end,
            on_highlights = function(highlights, colors)
                -- highlights.TelescopeNormal = { fg = colors.magenta, bg = colors.charcoal }
                highlights.WinSeparator = { fg = "#444444" }
            end,
        },
        config = function(_, opts)
            require("monokai-nightasty").setup(opts)
            vim.cmd[[colorscheme monokai-nightasty]]
        end,
    },
    {
        "RRethy/nvim-base16",
        lazy = true,
        priority = 1000,
        config = function()
            require('base16-colorscheme').with_config({
                telescope = false,
            })
            vim.cmd[[colorscheme base16-monokai]]
        end,
    },
    {
        "sainnhe/sonokai",
        lazy = true,
        -- event = "VeryLazy",
        priority = 1000,
        config = function ()
            vim.cmd([[]])
            vim.cmd([[
                " let g:sonokai_style="espresso"
                colorscheme sonokai
                ]])
        end,
        enabled = true,
    },
    {
        "EdenEast/nightfox.nvim",
        lazy = true,
        priority = 1000,
        opts = {},
        config = function ()
            vim.cmd([[colorscheme nightfox]])
        end,
        enabled = true,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = true,
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
        enabled = true,
    },
}
