local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("opts")
require("lazy").setup("plugins")

vim.cmd("filetype plugin on")

vim.cmd([[
augroup DetectIndent
autocmd!
autocmd BufReadPost *  DetectIndent
augroup END
]])

vim.cmd([[
set titlestring=%{fnamemodify(getcwd(),':h:t')}/%{fnamemodify(getcwd(),':t')}
]])

vim.api.nvim_create_user_command('ClearNotifications', "lua require'notify'.dismiss()", {})
vim.api.nvim_create_user_command('RemoveIostream', 'g/iostream\\|cout/d', {})

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
nmap("<leader>s", "<cmd>Autosession search<cr>")
nmap("<leader>l", "<cmd>Telescope live_grep<cr>")
nmap("<leader>p", "<cmd>Telescope commands<cr>")
nmap("<c-p>", "<cmd>Telescope find_files<cr>")
nmap("<leader>P", "<cmd>Telescope <cr>")

nmap("<leader>w", "<c-w>")
nmap("<leader>,", ":tabnew ~/.config/nvim/init.lua<CR>:vsplit ~/.config/nvim/lua/lazy_plugins.lua<CR>")

nmap("<leader>q", "<cmd>Bdelete<CR>")
nmap("<leader>Q", "<cmd>bdelete<CR>")
nmap("]b", "<cmd>bn<CR>")
nmap("[b", "<cmd>bp<CR>")

nmap("<leader>hftest", "p^ceFRIEND_TEST<esc>$r;X>>")
nmap("<leader>cs", "<cmd>'a,'bS#")

nmap("<C-w>M", "<cmd>Neotree close<CR><cmd>WindowsMaximize<CR>")
nmap("<C-w>=", "<cmd>WindowsEqualize<CR>")

tmap("<Esc>", "<C-\\><C-n>")

nmap("<F5>", "<cmd>lua require'dap'.continue()<CR>")
nmap("<F9>", "<cmd>lua require'dap'.toggle_breakpoint()<CR>")
nmap("<F10>", "<cmd>lua require'dap'.step_over()<CR>")
nmap("<F11>", "<cmd>lua require'dap'.step_into()<CR>")
nmap("<leader>K", "<cmd>lua require'dap.ui.widgets'.cursor_float()<CR>")
nmap("<leader>D", "<cmd>lua require'dapui'.toggle()<CR>")

nnoremap('<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>')
nnoremap('[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
nnoremap(']e', '<cmd>lua vim.diagnostic.goto_next()<CR>')

vim.keymap.set('n', '<Leader>t', require('whitespace-nvim').trim)

vim.cmd([[set guifont=FiraCode\ Nerd\ Font\ Font\ Mono:h11]])

require('gitsigns').setup{
    on_attach = function(bufnr)
        nnoremap(']c', '<cmd>Gitsigns next_hunk<CR>')
        nnoremap('[c', '<cmd>Gitsigns prev_hunk<CR>')
        nnoremap('<leader>hb', '<cmd>Gitsigns blame_line<CR>')
    end,
    current_line_blame = false,
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    nnoremap('gd', '<cmd>Telescope lsp_definitions<CR>')
    nnoremap('gs', '<cmd>ClangdSwitchSourceHeader<CR>')
    nnoremap('gi', '<cmd>Telescope lsp_implementations<CR>')
    nnoremap('<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    inoremap('<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    nnoremap('K', '<cmd>lua vim.lsp.buf.hover()<CR>')
    nnoremap('<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>')
    nnoremap('<leader>.', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    nnoremap('gr', '<cmd>Telescope lsp_references<CR>')
    nnoremap('<leader>o', '<cmd>Telescope lsp_document_symbols<CR>')
end

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
        -- { name = 'nvim_lsp_signature_help' },
        { name = 'vsnip' },
        { name = 'buffer', keyword_length = 2 },
        { name = 'path' },
    }),
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol',
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        })
    },
    experimental = {
        ghost_text = false,
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

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("mason").setup()
require("mason-lspconfig").setup(
{
    ensure_installed = {
        'clangd', 'cmake', 'html', 'lemminx', 'rust_analyzer',
        'svelte', 'tsserver', 'pylsp',
    },
    automatic_installation = true,
})
require("mason-lspconfig").setup_handlers{
    function (server_name)
        require("lspconfig")[server_name].setup{
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 150,
            }
        }
    end,
    ["clangd"] = function ()
        require("clangd_extensions").setup({
            server = {
                on_attach = on_attach,
                capabilities = capabilities,
                root_dir = require('lspconfig').util.root_pattern('compile_commands.json'),
                flags = {
                    debounce_text_changes = 150,
                }
            }
        })
    end
}
require("mason-nvim-dap").setup({
    automatic_setup = true,
    ensure_installed = {'cppdbg'},
    handlers = {}
})

vim.fn.sign_define('DapBreakpoint', {text='🔴', texthl='', linehl='', numhl=''})

require'dap'.configurations.cpp = {
    {
        type = 'cppdbg';
        request = 'launch';
        name = "TPV Emulator GL";
        program = "${workspaceFolder}/output/tpv_mw_emulator_gl/debug/sandbox/bin/dtvplay-emulator";
        cwd = "${workspaceFolder}",
        environment = {
            { name =  "LC_ALL", value = "C" },
            { name =  "LD_LIBRARY_PATH", value = "${workspaceFolder}/output/tpv_mw_emulator_gl/debug/sandbox/lib/:${workspaceFolder}/output/tpv_mw_emulator_gl/debug/usr/lib:${workspaceFolder}/output/tpv_mw_emulator_gl/debug/usr/lib/pulseaudio" },
            { name =  "GIO_MODULE_DIR", value = "${workspaceFolder}/output/tpv_mw_emulator_gl/debug/usr/lib/gio/modules" },
            { name =  "GST_PLUGIN_PATH", value = "${workspaceFolder}/output/tpv_mw_emulator_gl/debug/usr/lib/gstreamer-1.0" },
            { name =  "LIBGL_DRIVERS_PATH", value = "${workspaceFolder}/output/tpv_mw_emulator_gl/debug/usr/lib/dri" }
        },
        setupCommands = {
            {
                text = '-enable-pretty-printing',
                description =  'enable pretty printing',
                ignoreFailures = false
            },
        },
    },
    {
        type = 'cppdbg';
        request = 'launch';
        name = "TPV Emulator GL DebugFull";
        program = "${workspaceFolder}/output/tpv_mw_emulator_gl/debugfull/sandbox/bin/dtvplay-emulator";
        cwd = "${workspaceFolder}",
        environment = {
            { name =  "LC_ALL", value = "C" },
            { name =  "LD_LIBRARY_PATH", value = "${workspaceFolder}/output/tpv_mw_emulator_gl/debugfull/sandbox/lib/:${workspaceFolder}/output/tpv_mw_emulator_gl/debugfull/usr/lib:${workspaceFolder}/output/tpv_mw_emulator_gl/debugfull/usr/lib/pulseaudio" },
            { name =  "GIO_MODULE_DIR", value = "${workspaceFolder}/output/tpv_mw_emulator_gl/debugfull/usr/lib/gio/modules" },
            { name =  "GST_PLUGIN_PATH", value = "${workspaceFolder}/output/tpv_mw_emulator_gl/debugfull/usr/lib/gstreamer-1.0" },
            { name =  "LIBGL_DRIVERS_PATH", value = "${workspaceFolder}/output/tpv_mw_emulator_gl/debugfull/usr/lib/dri" }
        },
        setupCommands = {
            {
                text = '-enable-pretty-printing',
                description =  'enable pretty printing',
                ignoreFailures = false
            },
        },
    },
}

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
