return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies =  'nvim-tree/nvim-web-devicons',
        opts = {
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
        },
    }
}
