return {
    {
        'hrsh7th/nvim-cmp',
        event = "VeryLazy",
        config = function()
            require("confs/completion")
        end,
    },
    { 'hrsh7th/cmp-vsnip', event = "VeryLazy", },
    { 'hrsh7th/vim-vsnip', event = "VeryLazy", },
    { 'rafamadriz/friendly-snippets', event = "VeryLazy", },
    { 'hrsh7th/cmp-nvim-lsp', event = "VeryLazy", },
    { 'hrsh7th/cmp-nvim-lua', ft = "lua" },
    { 'FelipeLema/cmp-async-path', event = "VeryLazy", },
    { 'hrsh7th/cmp-buffer', event = "VeryLazy", },
    { 'hrsh7th/cmp-cmdline', keys = ":", },
    -- { 'hrsh7th/cmp-nvim-lsp-signature-help', event = "VeryLazy", },
    { 'hrsh7th/cmp-nvim-lsp-document-symbol', event = "VeryLazy", },
    -- { 'onsails/lspkind-nvim', event = "VeryLazy", },
}
