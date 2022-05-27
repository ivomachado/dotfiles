require('plugins')

local filename_symbols = { modified = ' ●',}

require('lualine').setup{
  extensions = {'quickfix', 'chadtree'},
  options = {
    icons_enabled = true,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  tabline = {
    lualine_a = {'tabs'},
    lualine_b = {
      {'filetype', icon_only = true},
      {'filename', path = 1, symbols = filename_symbols, shorting_target = 40},
      'diagnostics'
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {'buffers'}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {{'filename', path = 1, symbols = filename_symbols}, 'diagnostics'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {{'filename', symbols = filename_symbols}, 'diagnostics'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
}

require("indent_blankline").setup {
  show_end_of_line = true,
  indent_blankline_show_first_indent_level = false,
}

require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-k>"] = "move_selection_previous",
        ["<C-j>"] = "move_selection_next",
        ["<C-p>"] = "cycle_history_prev",
        ["<C-n>"] = "cycle_history_next",
        ["<C-z>"] = "toggle_selection",
        ["<C-o>"] = "smart_send_to_qflist",
        ["<C-a>"] = "smart_add_to_qflist",
        ["<esc>"] = "close",
      },
      n = {
        ["<C-k>"] = "move_selection_previous",
        ["<C-j>"] = "move_selection_next",
        ["<C-p>"] = "cycle_history_prev",
        ["<C-n>"] = "cycle_history_next",
        ["<C-z>"] = "toggle_selection",
        ["<C-o>"] = "smart_send_to_qflist",
        ["<C-a>"] = "smart_add_to_qflist",
      },
    },
    layout_strategy = "horizontal",
    path_display = { truncate = 3 },
    fuzzy = true,                    -- false will only do exact matching
    override_generic_sorter = true,  -- override the generic sorter
    override_file_sorter = true,     -- override the file sorter
    case_mode = "smart_case",        -- or "ignore_case" or "respect_case" the default case_mode is "smart_case"
  }
}

-- To get fzf loaded and working with telescope, you need to call
-- -- load_extension, somewhere after setup function:
-- require('telescope').load_extension('fzf')

require('gitsigns').setup{
  on_attach = function(bufnr)
    local function map(mode, lhs, rhs, opts)
      opts = vim.tbl_extend('force', {noremap = true, silent = true}, opts or {})
      vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
    end

    current_line_blame = true,

    -- Navigation
    map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
    map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})

    map('n', '<leader>g', '<cmd>Gitsigns blame_line<CR>', {expr=true})
  end
}

local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs', '<cmd>ClangdSwitchSourceHeader<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wf', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>.', '<cmd>Telescope lsp_code_actions<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>o', '<cmd>Telescope lsp_document_symbols<CR>', opts)
end

-- Setup nvim-cmp.
local cmp = require'cmp'
local lspkind = require('lspkind')

cmp.setup({
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
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
    { name = 'buffer' },
    { name = 'path' },
  }),
  formatting = {
    format = lspkind.cmp_format({
      with_text = false, -- do not show text alongside icons
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
    })
  }
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
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
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local servers = {
  'clangd',
  'cmake',
}

require "lsp_signature".setup({})

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

vim.notify = require("notify")

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
vim.opt.lazyredraw = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
-- vim.opt.wildignore+=*/tmp/*,*.swp,*.zip,*.exe,*/node_modules/*,*/build/*,*/.ccls-cache/*,*/.clangd/*,*/.build/*,*gradle*,*/.build*/*,*/output/*



vim.opt.termguicolors = true

vim.cmd("filetype plugin on")
vim.cmd("colorscheme tokyonight")

vim.g.tokyonight_style = "night"
vim.opt.background="dark"

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

function noremap(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = false, silent = true })
end

function nnoremap(shortcut, command)
  noremap('n', shortcut, command)
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function vmap(shortcut, command)
  map('v', shortcut, command)
end

function inoremap(shortcut, command)
  noremap('i', shortcut, command)
end

inoremap('jk', '<Esc>')

-- Alterna a exibição do project drawer
nmap('<leader>b', "<cmd>CHADopen<cr>")

nmap("<leader>o", "<cmd>Telescope current_buffer_tags<cr>")
nmap("<leader>l", "<cmd>Telescope live_grep<cr>")

nmap("<leader>w", "<c-w>")
nmap("<leader>,", ":tabnew ~/.config/nvim/init.lua<CR>:vsplit ~/.config/nvim/lua/plugins.lua<CR>")

nmap("<leader>q", "<cmd>Bdelete<CR>")
nmap("<leader>Q", "<cmd>bdelete<CR>")
nmap("]b", "<cmd>bn<CR>")
nmap("[b", "<cmd>bp<CR>")
nmap("]q", "<cmd>cn<CR>")
nmap("[q", "<cmd>cp<CR>")

nmap("<leader>hftest", "p^ceFRIEND_TEST<esc>$r;X>>")
nmap("<leader>cs", ":'a,'bS#")

nmap("<C-w>M", "<cmd>FocusMaximise<CR>")
nmap("<C-w>=", "<cmd>FocusEqualise<CR>")

nmap("<c-p>", "<cmd>Telescope find_files<cr>")
nmap("<leader>p", "<cmd>Telescope <cr>")


nnoremap("<space>", "<Nop>")
nmap("<space>", "<leader>")
vmap("<space>", "<leader>")
