vim.opt.showmode = false
vim.opt.backup = false
vim.opt.title = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.swapfile = false
vim.opt.wrap = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.scrolloff = 5
vim.opt.signcolumn = "yes"
vim.opt.guifont = "JetBrainsMono NF:h11"
vim.opt.showcmd = false
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.list = true
local default_listchars = "eol:\u{ebea},tab:\u{f0312}  ,trail:·"
vim.opt.listchars = default_listchars
vim.opt.fillchars:append({ eob=" " })
vim.opt.pumheight = 10
vim.opt.cinoptions = "N-s,0g,E-s,(0,j1,l1,:0,Ws"
vim.opt.shortmess:append('c')
vim.opt.shortmess:append('C')
vim.opt.completeopt = 'menuone,noselect,noinsert,popup'
vim.opt.laststatus = 3
vim.opt.background = "dark"
vim.diagnostic.config({
  virtual_text = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '⚠',
      [vim.diagnostic.severity.WARN] = '⚠',
      [vim.diagnostic.severity.INFO] = 'i',
      [vim.diagnostic.severity.HINT] = '󰌵',
    }
  }
})
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.cmd([[let $ESCDELAY=0]])

vim.cmd("filetype plugin on")

vim.cmd([[ set titlestring=%{fnamemodify(getcwd(),':h:t')}/%{fnamemodify(getcwd(),':t')} ]])

vim.cmd('colorscheme catppuccin-ivo')

--------------------------------------------------------------------------------
--------------------------------- Actions -----------------------------------
--------------------------------------------------------------------------------

local Action = {}
Action.cr_action = function()
  if vim.fn.pumvisible() ~= 0 then
    local has_item_selected = vim.fn.complete_info()['selected'] ~= -1
    if has_item_selected then
      return vim.api.nvim_replace_termcodes('<C-y>', true, true, true)
    end
  end
  return require('nvim-autopairs').autopairs_cr()
end

Action.tab_action = function()
  if vim.fn.pumvisible() ~= 0 then
    return "<C-n>"
  end
  if vim.snippet.active() then
    if vim.snippet.jumpable(1) then
      vim.snippet.jump(1)
      return ''
    end
  end
  return "<Tab>"
end

Action.shift_tab_action = function()
  if vim.fn.pumvisible() ~= 0 then
    return "<C-p>"
  end
  if vim.snippet.active() then
    if vim.snippet.jumpable(-1) then
      vim.snippet.jump(-1)
      return ''
    end
  end
  return "<Tab>"
end

Action.start_completion = function()
  if vim.bo.omnifunc == nil or vim.bo.omnifunc == '' then
    return "<C-x><C-n>"
  else
    return "<C-x><C-o>"
  end
end

-- ==============================================================================

vim.api.nvim_create_user_command('ClearNotifications', "lua require'mini.notify'.clear()", {})
vim.api.nvim_create_user_command('RemoveIostream', 'g/iostream\\|cout/d', {})

vim.keymap.set('n', '<leader>,', '<cmd>e ~/.config/nvim/init.lua<CR>', { noremap = true, silent = true })
vim.keymap.set('s', 'jk', '<Esc>', { noremap = true, silent = true })
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true, silent = true })

--------------------------------------------------------------------------------
--------------------------------- Fuzzy Finder ---------------------------------
--------------------------------------------------------------------------------
vim.keymap.set('n', '<leader>f', "<cmd>FzfLua files<cr>")
vim.keymap.set('n', '<leader>b', "<cmd>FzfLua buffers<cr>")
vim.keymap.set('n', '<leader>s', "<cmd>FzfLua lsp_document_symbols<cr>")
vim.keymap.set('n', '<leader>S', "<cmd>FzfLua lsp_workspace_symbols<cr>")
vim.keymap.set('n', '<leader>l', "<cmd>FzfLua live_grep<cr>")
vim.keymap.set('n', '<leader>L', "<cmd>FzfLua grep_last<cr>")
vim.keymap.set('n', '<leader>p', "<cmd>FzfLua commands<cr>")
vim.keymap.set('n', '<leader>c', "<cmd>FzfLua colorschemes<cr>")
--------------------------------------------------------------------------------
------------------------------------ Utils -------------------------------------
--------------------------------------------------------------------------------
vim.keymap.set('n', '<leader>e', "<cmd>Oil .<cr>", { desc = "Open File Explorer" })
vim.keymap.set('n', '<leader>E', "<cmd>Oil<cr>", { desc = "Open File Explorer on current file" })
vim.keymap.set('n', '<leader>w', "<C-W>", { noremap = false })
vim.keymap.set('n', '<leader>q', function()
  local current_buf = vim.api.nvim_get_current_buf()
  local windows = vim.api.nvim_list_wins()
  local recent_buf = nil
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current_buf and vim.api.nvim_buf_is_loaded(buf)
        and vim.api.nvim_get_option_value('buflisted', { buf = buf }) then
      recent_buf = buf
      break
    end
  end
  if not recent_buf then
    recent_buf = vim.api.nvim_create_buf(true, false)
  end
  for _, win in ipairs(windows) do
    if vim.api.nvim_win_get_buf(win) == current_buf then
      vim.api.nvim_win_set_buf(win, recent_buf)
    end
  end
  vim.api.nvim_buf_delete(current_buf, { force = true })
end, { desc = "Close Buffer and Maintain Layout"})
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)
--------------------------------------------------------------------------------
---------------------------------- Navigation ----------------------------------
--------------------------------------------------------------------------------
vim.keymap.set('n', ']c', "<cmd>Gitsigns next_hunk<CR>")
vim.keymap.set('n', '[c', "<cmd>Gitsigns prev_hunk<CR>")
vim.keymap.set('n', ']b', "<cmd>bn<CR>")
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '[b', "<cmd>bp<CR>")
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
--------------------------------------------------------------------------------
------------------------------------- Git --------------------------------------
--------------------------------------------------------------------------------
vim.keymap.set('n', '<leader>gb', "<cmd>Gitsigns blame_line<CR>")
vim.keymap.set('n', 'grh', "<cmd>Gitsigns reset_hunk<CR>")
vim.keymap.set('n', 'grb', "<cmd>Gitsigns reset_buffer<CR>")
--------------------------------------------------------------------------------
---------------------------------- Completion -----------------------------------
--------------------------------------------------------------------------------
vim.keymap.set({ 'i', 's' }, '<Tab>', Action.tab_action, { expr = true })
vim.keymap.set({ 'i', 's' }, '<S-Tab>', Action.shift_tab_action, { expr = true })
vim.keymap.set('i', '<CR>', Action.cr_action, { expr = true, replace_keycodes = false, })
vim.keymap.set('i', '<C-Space>', Action.start_completion, { expr = true })
--------------------------------------------------------------------------------
--------------------------- Language Server Protocol ---------------------------
--------------------------------------------------------------------------------
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'gi', "<cmd>FzfLua lsp_implementations<CR>")
vim.keymap.set('n', 'gR', "<cmd>FzfLua lsp_references<CR>")
-- vim.keymap.set('n', 'K', vim.lsp.buf.hover)
vim.keymap.set('n', '<F2>', vim.lsp.buf.rename)
vim.keymap.set('n', 'ga', vim.lsp.buf.code_action)
vim.keymap.set({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help)

-- ==============================================================================

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  close_events = { "InsertLeave", "CompleteDone", }
})

--------------------------------------------------------------------------------
----------------------------------- Plugins ------------------------------------
--------------------------------------------------------------------------------
if not LazySet then
  LazySet = true
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
      lazypath, })
  end
  vim.opt.rtp:prepend(lazypath)
  require("lazy").setup({
    { 'stevearc/oil.nvim',              cmd = "Oil",              opts = {} },
    { 'folke/neodev.nvim',              config = true },
    { 'neovim/nvim-lspconfig',          event = "VeryLazy", },
    -- { 'NMAC427/guess-indent.nvim',       config = true },
    { 'PeterRincker/vim-argumentative', event = "BufEnter", },
    { 'windwp/nvim-autopairs',          opts = { map_cr = false } },
    { 'kylechui/nvim-surround',         version = "*",            keys = { "ys", "ds", "cs" },           config = true, },
    { 'numToStr/Comment.nvim',          keys = { "gc", "gb" },    config = true, },
    { 'echasnovski/mini.notify',        version = false,          config = true },
    { 'lewis6991/gitsigns.nvim',        event = "VeryLazy",       opts = { current_line_blame = false, } },
    { 'Darazaki/indent-o-matic',        config = true },
    {
      'nvim-treesitter/nvim-treesitter',
      branch = 'main',
      build = ':TSUpdate',
      opts = {
        auto_install = true,
        ensure_install = { 'rust', 'cpp', 'lua' },
        sync_install = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      },
    },
    {
      'stevearc/conform.nvim',
      opts = {
        formatters_by_ft = {
          cpp = { "clang_format", },
          rust = { "rustfmt", },
        }
      },
      init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
      end,
    },
    {
      "ibhagwan/fzf-lua",
      opts = {
        "telescope",
        fzf_opts = { ["--layout"] = "reverse", },
        winopts = {
          height = 0.85,
          width = 0.80,
          row = 0.35,
          col = 0.50,
          preview = { default = 'builtin' },
          border = 'single',
        },
        files = {
          fd_opts =
          "--color=never --type f --hidden --no-ignore-vcs --follow --exclude .git --exclude .ccache --exclude .cache --exclude *.o",
          prompt = '',
          cwd_prompt = false,
          actions = { ["ctrl-g"] = false, }
        },
      },
    },
    -- { 'echasnovski/mini.colors', version = false },
    -- { "catppuccin/nvim", name = "catppuccin", config = true, priority = 1000, },
  })
end


--------------------------------------------------------------------------------
--------------------------------- Status Line ----------------------------------
--------------------------------------------------------------------------------

local mode_map = {
  ['n'] = 'NORMAL',
  ['no'] = 'OP-PENDING',
  ['nov'] = 'OP-PENDING CHAR',
  ['noV'] = 'OP-PENDING LINE',
  ['no\22'] = 'OP-PENDING BLOCK',
  ['niI'] = 'NORMAL INSERT',
  ['niR'] = 'NORMAL REPLACE',
  ['niV'] = 'NORMAL V-REPLACE',
  ['v'] = 'VISUAL',
  ['V'] = 'V-LINE',
  ['\22'] = 'V-BLOCK',
  ['s'] = 'SELECT',
  ['S'] = 'S-LINE',
  ['\19'] = 'S-BLOCK',
  ['i'] = 'INSERT',
  ['ic'] = 'INSERT COMPLETION',
  ['ix'] = 'INSERT CTRL-X',
  ['R'] = 'REPLACE',
  ['Rc'] = 'REPLACE COMPLETION',
  ['Rv'] = 'V-REPLACE',
  ['Rx'] = 'REPLACE CTRL-X',
  ['c'] = 'COMMAND',
  ['cv'] = 'EX',
  ['ce'] = 'NORMAL EX',
  ['r'] = 'HIT-ENTER',
  ['rm'] = 'MORE',
  ['r?'] = 'CONFIRM',
  ['!'] = 'SHELL',
  ['t'] = 'TERMINAL'
}

---@diagnostic disable-next-line: unused-function, unused-local, lowercase-global
function get_mode_name()
  local mode_info = vim.api.nvim_get_mode()
  local mode = mode_info.mode
  return mode_map[mode] or 'UNKNOWN'
end

local statusline = {
  ' %{luaeval(\'get_mode_name()\')}',
  '%=',
  '%f',
  '%r',
  '%m',
  '%=',
  ' %{&expandtab?"\u{f1050}":"\u{f0312} "} %{&shiftwidth}',
  ' %2p%%',
  ' %3l:%-2c',
  ' %{&filetype} ',
}

vim.opt.statusline = table.concat(statusline, '')
local default_winbar = " %=%t%= "
local unfocused_winbar = "%#Whitespace#" .. default_winbar
vim.opt.winbar = default_winbar

--------------------------------------------------------------------------------
-------------------------------- Auto Commands ---------------------------------
--------------------------------------------------------------------------------

local autocmd_group = vim.api.nvim_create_augroup("user-autocommands", { clear = true })
vim.api.nvim_create_autocmd({ "BufHidden" }, {
  group = autocmd_group,
  desc = "Delete scratch buffers",
  pattern = { "*No Name*" },
  callback = function(ev)
    vim.api.nvimm_buf_delete(ev.buf)
  end,
})

vim.api.nvim_create_autocmd({ "VimEnter", "OptionSet", "BufEnter" }, {
  group = autocmd_group,
  desc = "Enable Indent Lines",
  callback = function()
    local n_spaces = vim.api.nvim_get_option_value('shiftwidth', {}) - 1
    vim.api.nvim_set_option_value('listchars', default_listchars..',leadmultispace:│'..string.rep(' ', n_spaces), {scope = 'local'})
  end,
})

vim.api.nvim_create_autocmd({ "WinLeave" }, {
  group = autocmd_group,
  desc = "Disable cursorline",
  callback = function()
    vim.opt.cursorline = false
    vim.wo.winbar = unfocused_winbar
  end,
})

vim.api.nvim_create_autocmd({ "WinEnter" }, {
  group = autocmd_group,
  desc = "Enable cursorline on current window",
  callback = function()
    vim.opt.cursorline = true
    vim.wo.winbar = default_winbar
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = autocmd_group,
  desc = "Start treesitter",
  pattern = { 'cpp', 'rust', 'lua' },
  callback = function() vim.treesitter.start() end,
})

vim.api.nvim_create_autocmd('VimResized', {
  group = autocmd_group,
  desc = "Even Windows",
  callback = function() vim.cmd("wincmd =") end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = autocmd_group,
  desc = "Enable autocomplete on lsp enabled buffers",
  callback = function(args)
    vim.api.nvim_create_autocmd('InsertCharPre', {
      group = autocmd_group,
      desc = "Start AutoComplete",
      buffer = args.buf,
      callback = function()
        vim.defer_fn(function()
          if vim.fn.pumvisible() == 0 and vim.fn.mode() == 'i' then
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(Action.start_completion(), true, false, true), 'm', false)
          end
        end, 100)
      end
    })
  end
})

vim.api.nvim_create_autocmd('CompleteDone', {
  group = autocmd_group,
  desc = 'Expand LSP snippet',
  callback = function(opts)
    local comp = vim.v.completed_item
    local item = vim.tbl_get(comp, 'user_data', 'nvim', 'lsp', 'completion_item')

    if item and item.additionalTextEdits then
      local clients = vim.lsp.get_clients({bufnr = opts.buf})
      if #clients > 0 then
        vim.lsp.util.apply_text_edits(item.additionalTextEdits, opts.buf, clients[1].offset_encoding)
      end
    end

    if (not item or not item.insertTextFormat or item.insertTextFormat == 1 or vim.snippet.active()) then
      return
    end

    local snip_text = vim.tbl_get(item, 'textEdit', 'newText') or item.insertText or ''

    local startPos, _ = string.find(snip_text, "%$")
    if not startPos then
      return
    end

    local cursor = vim.api.nvim_win_get_cursor(0)
    local lnum = cursor[1] - 1
    local start_char = cursor[2] - #comp.word
    vim.api.nvim_buf_set_text(opts.buf, lnum, start_char, lnum, #comp.word + start_char, { '' })

    assert(snip_text, "Language server indicated it had a snippet, but no snippet text could be found!")
    vim.snippet.expand(snip_text)
  end
})

--------------------------------------------------------------------------------
----------------------- Language Server Protocol Setup -------------------------
--------------------------------------------------------------------------------

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lspconfig = require("lspconfig")

lspconfig.clangd.setup {
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  }
}

lspconfig.rust_analyzer.setup {
  capabilities = capabilities,
  settings = {
    ['rust-analyzer'] = {
      check = {
        command = "clippy"
      }
    }
  }
}

lspconfig['lua_ls'].setup({})

vim.cmd("FzfLua register_ui_select")
vim.notify = require('mini.notify').make_notify()
