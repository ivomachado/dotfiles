return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies =  'nvim-tree/nvim-web-devicons',
        opts = {
            extensions = {'quickfix'},
            options = {
                icons_enabled = true,
                component_separators = { left = '\u{E0B9}', right = '\u{E0BB}'},
                section_separators = { left = "\u{E0B8}", right = "\u{E0BA}" },
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
                lualine_y = {
                    {
                        'lsp_progress',
                        spinner_symbols = {
                            '🌑 ',
                            '🌒 ',
                            '🌓 ',
                            '🌔 ',
                            '🌕 ',
                            '🌖 ',
                            '🌗 ',
                            '🌘 ',
                        },
                    },
                    'progress',
                    function()
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
                lualine_c = {{'filename', path = 0}},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {}
            },
            winbar = {
                lualine_a = {{'filename', path = 0}},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {}
            },
        },
    },
    {"arkav/lualine-lsp-progress", event = "VeryLazy"},
}