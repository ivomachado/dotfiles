local cmp = require("cmp")

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
    },
    -- keyword_length = 3,
    autocomplete = false,
    matching = {
        disallow_fuzzy_matching = true,
        disallow_fullfuzzy_matching = true,
        disallow_partial_fuzzy_matching = true,
        disallow_partial_matching = false,
        disallow_prefix_unmatching = false,
    },
    window = {
        completion = {
            -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            col_offset = -3,
            side_padding = 0,
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
    },
    performance = {
        max_view_entries = 150,
    },
    view = {
        docs = {
            auto_open = true,
        },
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Select}), { 'i', 'c' }),
        ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Select}), { 'i', 'c' }),
        ['<C-l>'] = cmp.mapping.complete({config = {sources = {{name = 'vsnip'}}}}),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if vim.fn["vsnip#jumpable"](-1) == 1 then
                feedkey("<Plug>(vsnip-jump-prev)", "")
            elseif cmp.visible() and has_words_before() then
                cmp.select_prev_item({behavior = cmp.SelectBehavior.Insert})
            else
                fallback()
            end
        end, {"i","s","c",}),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if vim.fn["vsnip#jumpable"](1) == 1 then
                feedkey("<Plug>(vsnip-jump-next)", "")
            elseif cmp.visible() and has_words_before() then
                cmp.select_next_item({behavior = cmp.SelectBehavior.Insert})
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, {"i","s","c",}),
        ['<C-Space>'] = cmp.mapping(function()
            if cmp.visible()  then
                if not cmp.get_selected_entry() then
                    cmp.select_next_item({behavior = cmp.SelectBehavior.Select})
                end
                cmp.confirm({behavior = cmp.ConfirmBehavior.Replace, select = true})
            else
                cmp.complete()
            end
        end),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = function(fallback)
            if cmp.visible() and cmp.get_active_entry() then
                cmp.confirm({behavior = cmp.ConfirmBehavior.Replace, select = false})
            else
                fallback() -- If you use vim-endwise, this fallback will behave the same as vim-endwise.
            end
        end,
    },
    sources = {
        {
            name = 'nvim_lsp',
            -- priority_weight = 15,
            group_index = 1,
        },
        { name = 'buffer', max_item_count = 3, group_index = 2},
        { name = 'nvim_lsp_signature_help', dup = 0, },
        { name = 'async_path', dup = 0, },
        { name = 'vsnip', max_item_count = 3, priority_weight = 1, dup = 0, },
    },
    formatting = {
        fields = { "kind", "abbr", "menu", },
        format = function(entry, vim_item)
            local kind = require('lspkind').cmp_format({
                mode = 'symbol_text',
                maxwidth = 80, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                menu = ({
                    buffer = "[Buffer]",
                    nvim_lsp = "[LSP]",
                    vsnip = "[VSnip]",
                    nvim_lua = "[Lua]",
                    latex_symbols = "[Latex]",
                })
            })(entry, vim_item)

            local strings = vim.split(kind.kind, "%s", { trimempty = true})
            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = "    (" .. (strings[2] or "") .. ")"

            return kind
        end,
    },
    experimental = {
        ghost_text = true,
    },
    sorting = {
        comparators = {
            require("clangd_extensions.cmp_scores"),
            cmp.config.compare.sort_text,
            cmp.config.compare.offset,
            cmp.config.compare.kind,
            cmp.config.compare.recently_used,
            cmp.config.compare.exact,
            cmp.config.compare.order,
            cmp.config.compare.length,
        },
    },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        -- { name = 'nvim_lsp_document_symbol'},
        { name = 'buffer'},
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        -- { name = 'async_path' },
        { name = 'cmdline' },
    }
})
