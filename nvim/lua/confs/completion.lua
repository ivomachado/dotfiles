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
    keyword_length = 3,
    matching = {
        disallow_fuzzy_matching = true,
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
        max_view_entries = 20,
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
        ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                    cmp.select_next_item()
            else
                fallback()
            end
        end, {"i","s","c",}),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                    cmp.select_prev_item()
            else
                fallback()
            end
        end, {"i","s","c",}),
        ['<C-Space>'] = function ()
            if cmp.visible() then
                cmp.confirm({select = true})
            else
                cmp.complete()
            end
        end,
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = function(fallback)
            if cmp.visible() then
                local entry = cmp.get_selected_entry()
                if not entry then
                    fallback()
                else
                    cmp.confirm()
                cmp.confirm({select = false})
                end
            else
                fallback() -- If you use vim-endwise, this fallback will behave the same as vim-endwise.
            end
        end,
    },
    sources = {
        { name = 'nvim_lsp', group_index = 1 },
        { name = 'nvim_lsp_signature_help' },
        { name = 'buffer', group_index = 2 },
        { name = 'async_path' },
        { name = 'vsnip' },
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
                    luasnip = "[LuaSnip]",
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
        ghost_text = false,
    },
    sorting = {
        comparators = {
            cmp.config.compare.exact,
            cmp.config.compare.recently_used,
            require("clangd_extensions.cmp_scores"),
            cmp.config.compare.offset,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.order,
            cmp.config.compare.length,
        },
    },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    sources = {
        { name = 'nvim_lsp_document_symbol'},
        { name = 'buffer'},
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    sources = {
        -- { name = 'async_path' },
        { name = 'cmdline' },
    }
})
