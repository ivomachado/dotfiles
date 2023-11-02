return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies =  'nvim-tree/nvim-web-devicons',
        opts = {
            extensions = {'quickfix'},
            options = {
                icons_enabled = true,
                component_separators = { left = "", right = ""},
                section_separators = { left = "", right = "" },
                -- component_separators = { left = '\u{E0B9}', right = '\u{E0BB}'},
                -- section_separators = { left = "\u{E0B8}", right = "\u{E0BA}" },
                disabled_filetypes = {},
                theme = 'auto',
                always_divide_middle = true,
                globalstatus = true,
            },
            sections = {
                lualine_a = {'mode'},
                -- lualine_b = {'branch', 'diff'},
                lualine_b = {},
                lualine_c = {'filetype', {'filename', path = 1}, 'diagnostics'},
                lualine_y = {},
                lualine_x = {
                    'fileformat',
                    'progress',
                    'location',
                    function()
                        if vim.bo.expandtab then
                            return "\u{f1050} "..vim.bo.shiftwidth
                        else
                            return "\u{f0312} "..vim.bo.tabstop
                        end
                    end,
                },
                lualine_z = {'tabs'}
            },
            inactive_winbar = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {{'filename', path = 0}},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {}
            },
            winbar = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {{'filename', path = 0}},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {}
            },
        },
    },
}
