return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies =  'nvim-tree/nvim-web-devicons',
        opts = {
            extensions = { 'quickfix', 'neo-tree', 'nvim-dap-ui', 'mason', 'lazy' },
            options = {
                icons_enabled = false,
                component_separators = { left = "", right = ""},
                section_separators = { left = "", right = "" },
                disabled_filetypes = {},
                theme = 'auto',
                always_divide_middle = true,
                globalstatus = true,
            },
            sections = {
                lualine_a = {
                },
                lualine_b = {'mode'},
                lualine_c = {
                    'filetype',
                    { 'filename',    path = 1 },
                    { 'diagnostics', icons_enabled = true },
                },
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
                lualine_z = {
                    function()
                        return os.getenv("ZELLIJ_SESSION_NAME") or ''
                    end
                },
            },
            inactive_winbar = {
                lualine_c = {{'filename', path = 0, symbols = { modified = '●'}}},
                lualine_z = {
                    {
                        function ()
                            return [[]]
                        end,
                        draw_empty = true,
                    }
                },
            },
            winbar = {
                lualine_b = {{'filename', path = 0, symbols = { modified = '●'}}},
                lualine_z = {
                    {
                        function ()
                            return [[]]
                        end,
                        draw_empty = true,
                    }
                },
            },
        },
    },
}
