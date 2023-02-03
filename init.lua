require('plugins')

vim.opt.compatible = false
vim.opt.mouse="a"
vim.opt.showmode = false
vim.opt.backup = false
vim.opt.title = true
vim.opt.hidden = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.swapfile = false
vim.opt.encoding="utf-8"
vim.opt.fileencoding="utf-8"
vim.opt.wrap = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.expandtab = true
vim.opt.fixendofline = true
vim.opt.lazyredraw = false
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.showtabline = 0

vim.opt.termguicolors = true

vim.cmd("filetype plugin on")

vim.opt.list = true
vim.opt.listchars:append("eol:↴")
vim.opt.listchars:append("tab:<->")
vim.opt.listchars:append("lead:·")
vim.opt.listchars:append("trail:·")
vim.opt.listchars:append("extends:>")
vim.opt.listchars:append("precedes:<")
vim.opt.ffs="unix"

vim.cmd([[
augroup DetectIndent
autocmd!
autocmd BufReadPost *  DetectIndent
augroup END

command! RemoveIostream g/iostream\|cout/d
]])

vim.cmd([[
set titlestring=%{fnamemodify(getcwd(),':t')}
]])

local function noremap(mode, shortcut, command)
    vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

local function map(mode, shortcut, command)
    vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = false, silent = true })
end

local function nnoremap(shortcut, command)
    noremap('n', shortcut, command)
end

local function nmap(shortcut, command)
    map('n', shortcut, command)
end

local function vmap(shortcut, command)
    map('v', shortcut, command)
end

local function tmap(shortcut, command)
    map('t', shortcut, command)
end

local function inoremap(shortcut, command)
    noremap('i', shortcut, command)
end

local function snoremap(shortcut, command)
    noremap('s', shortcut, command)
end

inoremap('jk', '<Esc>')
snoremap('jk', '<Esc>')

-- Alterna a exibição do project drawer
nmap('<leader>b', "<cmd>Neotree left toggle=true<cr>")
nmap('<leader>B', "<cmd>Neotree left focus reveal<cr>")
nmap("<leader>a", "<cmd>Neotree float buffers<cr>")

nmap("<leader>o", "<cmd>Telescope lsp_document_symbols theme=ivy<cr>")
nmap("<leader>s", "<cmd>Telescope session-lens search_session<cr>")
nmap("<leader>l", "<cmd>Telescope live_grep<cr>")
nmap("<leader>p", "<cmd>Telescope commands<cr>")

nmap("<leader>w", "<c-w>")
nmap("<leader>,", ":tabnew ~/.config/nvim/init.lua<CR>:vsplit ~/.config/nvim/lua/plugins.lua<CR>")

nmap("<leader>q", "<cmd>Bdelete<CR>")
nmap("<leader>Q", "<cmd>bdelete<CR>")
nmap("]b", "<cmd>bn<CR>")
nmap("[b", "<cmd>bp<CR>")

nmap("<leader>hftest", "p^ceFRIEND_TEST<esc>$r;X>>")
nmap("<leader>cs", "<cmd>'a,'bS#")

nmap("<C-w>M", "<cmd>Neotree close<CR><cmd>FocusMaximise<CR>")
nmap("<C-w>m", "<cmd>Neotree close<CR><cmd>FocusToggle<CR>")
nmap("<C-w>=", "<cmd>FocusEqualise<CR>")

nmap("<c-p>", "<cmd>Telescope find_files<cr>")
nmap("<leader>P", "<cmd>Telescope <cr>")

nnoremap("<space>", "<Nop>")
nmap("<space>", "<leader>")
vmap("<space>", "<leader>")
tmap("<Esc>", "<C-\\><C-n>")

nmap("<F9>", "<cmd>lua require'dap'.toggle_breakpoint()<CR>")

nnoremap('<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>')
nnoremap('[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
nnoremap(']e', '<cmd>lua vim.diagnostic.goto_next()<CR>')

vim.cmd([[set guifont=FiraCode\ Nerd\ Font\ Font\ Mono:h11]])

vim.cmd([[colorscheme ayu-mirage]])

vim.o.sessionoptions="buffers,curdir,folds,help,tabpages,winsize"

require("indent_blankline").setup {
    show_end_of_line = true,
    show_current_context = true,
    indent_blankline_show_first_indent_level = false,
}

require('dressing').setup()

vim.notify = require("notify")

require('gitsigns').setup{
    on_attach = function(bufnr)
        local function key_map(mode, lhs, rhs, opts)
            opts = vim.tbl_extend('force', {noremap = true, silent = true}, opts or {})
            vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
        end

        -- Navigation
        key_map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
        key_map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})
    end,
    current_line_blame = true,
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    nnoremap('gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
    nnoremap('gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
    nnoremap('gs', '<cmd>ClangdSwitchSourceHeader<CR>')
    nnoremap('K', '<cmd>lua vim.lsp.buf.hover()<CR>')
    nnoremap('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
    nnoremap('<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    nnoremap('<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    nnoremap('<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>')
    nnoremap('<leader>.', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    nnoremap('gr', '<cmd>Telescope lsp_references<CR>')
    nnoremap('<leader>o', '<cmd>Telescope lsp_document_symbols<CR>')
end

-- Setup nvim-cmp.
local cmp = require'cmp'
local lspkind = require('lspkind')

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
        ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif vim.fn["vsnip#available"](1) == 1 then
                feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_words_before() then
                cmp.complete()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                feedkey("<Plug>(vsnip-jump-prev)", "")
            end
        end, { "i", "s" }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'vsnip' },
        { name = 'nvim_lua' },
        { name = 'buffer', keyword_length = 5 },
        { name = 'path' },
    }),
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        })
    },
    experimental = {
        ghost_text = true,
    },
    sorting = {
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.recently_used,
            require("clangd_extensions.cmp_scores"),
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
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
    sources = cmp.config.sources({
        { name = 'path' },
        { name = 'cmdline' },
    })
})

require("clangd_extensions").setup()

require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
    ensure_installed = { "c", "svelte", "cpp", "lua", "rust" , "typescript", "css", "html", "javascript"},
    auto_install = true,

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- List of parsers to ignore installing (for "all")
    --
    indent = {
        enable = false,
    },

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

require'nvim-lsp-installer'.setup({
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

local servers = {
    'clangd',
    'cmake',
    'html',
    'lemminx',
    'rust_analyzer',
    'svelte',
    'tsserver',
    'pylsp',
    -- 'sumneko_lua',
}

require('lspconfig')['sumneko_lua'].setup{
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 150,
    },
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    }
}

for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup{
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 150,
        }
    }
end

_G.vimrc = _G.vimrc or {}
_G.vimrc.cmp = _G.vimrc.cmp or {}
_G.vimrc.cmp.lsp = function()
    cmp.complete({
        config = {
            sources = {
                { name = 'nvim_lsp' }
            }
        }
    })

    vim.cmd([[
    inoremap <C-x><C-o> <Cmd>lua vimrc.cmp.lsp()<CR>
    inoremap <C-x><C-s> <Cmd>lua vimrc.cmp.snippet()<CR>
    ]])
end
