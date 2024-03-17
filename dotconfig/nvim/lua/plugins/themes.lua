return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
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
            vim.cmd.colorscheme("catppuccin")
        end,
        priority = 1000,
        enabled = true,
    },
}
