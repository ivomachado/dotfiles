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
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.diagnostic.config({
  virtual_text = { current_line = true },
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
  if vim.snippet.active({ direction = 1 }) then
    return "<cmd> lua vim.snippet.jump(1)<cr>"
  end
  return "<Tab>"
end

Action.shift_tab_action = function()
  if vim.fn.pumvisible() ~= 0 then
    return "<C-p>"
  end
  if vim.snippet.active({ direction = -1 }) then
    return "<cmd> lua vim.snippet.jump(-1)<cr>"
  end
  return "<Tab>"
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
vim.keymap.set('n', '<leader>l', "<cmd>FzfLua live_grep_native<cr>")
vim.keymap.set('n', '<leader>L', "<cmd>FzfLua grep_last<cr>")
vim.keymap.set('n', '<leader>p', "<cmd>FzfLua commands<cr>")
vim.keymap.set('n', '<leader>c', "<cmd>FzfLua colorschemes<cr>")
vim.keymap.set('n', '<leader>\'', "<cmd>FzfLua resume<cr>")
--------------------------------------------------------------------------------
------------------------------------ Utils -------------------------------------
--------------------------------------------------------------------------------
vim.keymap.set('n', '<leader>e', "<cmd>NvimTreeToggle<cr>", { desc = "Open File Explorer" })
vim.keymap.set('n', '<leader>E', "<cmd>NvimTreeFindFile<cr>", { desc = "Open File Explorer on current file" })
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
vim.keymap.set('n', '[b', "<cmd>bp<CR>")
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
vim.keymap.set('i', '<C-Space>', "<C-x><C-o>")

--------------------------------------------------------------------------------
--------------------------- Language Server Protocol ---------------------------
--------------------------------------------------------------------------------
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
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
    vim.fn.system({ "git", "clone", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
      lazypath, })
  end
  vim.opt.rtp:prepend(lazypath)
  require("lazy").setup({
    git = { filter = false },
    { 'Bekaboo/dropbar.nvim',           config = true },
    { 'nvim-tree/nvim-tree.lua',        dependencies = { 'antosha417/nvim-lsp-file-operations' }, opts = {} },
    { 'mason-org/mason.nvim',           opts = {} },
    { 'folke/neodev.nvim',              config = true },
    { 'neovim/nvim-lspconfig',          event = "VeryLazy", },
    { 'windwp/nvim-autopairs',          opts = { map_cr = false } },
    { 'kylechui/nvim-surround',         version = "*",            keys = { "ys", "ds", "cs" },           config = true, },
    -- { 'numToStr/Comment.nvim',          keys = { "gc", "gb" },    config = true, },
    { 'echasnovski/mini.notify',        version = false,          config = true },
    { 'echasnovski/mini.ai',            version = false,          config = true },
    { 'lewis6991/gitsigns.nvim',        event = "VeryLazy",        opts = { current_line_blame = false, } },
    { 'Darazaki/indent-o-matic',        config = true },
    {
      enabled = false,
      'neanias/everforest-nvim',
      lazy = false,
      priority = 1000,
      opts = {},
      config = function(opts)
        require('everforest').setup(opts)
        vim.cmd[[colorscheme everforest]]
      end
    },
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
        winopts = { height = 0.85, width = 0.80, row = 0.35, col = 0.50, preview = { default = 'builtin' }, border = 'single', },
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
  return mode_map[vim.api.nvim_get_mode().mode] or 'UNKNOWN'
end

---@diagnostic disable-next-line: unused-function, unused-local, lowercase-global
function get_remote_status()
  if vim.env.PDE_REMOTE_PATH ~= nil then
    if PDE_REMOTE_PENDING > 0 then
      return "[PENDING]"
    else
      return "[SYNCED]"
    end
  end
  return ""
end

local statusline = {
  ' %{luaeval(\'get_mode_name()\')}',
  '%=', '%f', '%r', '%m', '%=',
  ' %{&expandtab?"\u{f1050}":"\u{f0312} "} %{&shiftwidth}',
  ' %2p%%', ' %3l:%-2c', ' %{&filetype} %{luaeval(\'get_remote_status()\')}',
}

vim.opt.statusline = table.concat(statusline, '')
-- local default_winbar = " %=%t%= "
-- local unfocused_winbar = "%#Whitespace#" .. default_winbar
-- vim.opt.winbar = default_winbar

--------------------------------------------------------------------------------
-------------------------------- Auto Commands ---------------------------------
--------------------------------------------------------------------------------

local autocmd_group = vim.api.nvim_create_augroup("user-autocommands", { clear = true })
vim.api.nvim_create_autocmd({ "BufHidden" }, {
  group = autocmd_group,
  desc = "Delete scratch buffers",
  pattern = { "*No Name*" },
  callback = function(ev)
    vim.api.nvim_buf_delete(ev.buf, {force = false})
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
    -- vim.wo.winbar = unfocused_winbar
  end,
})

vim.api.nvim_create_autocmd({ "WinEnter" }, {
  group = autocmd_group,
  desc = "Enable cursorline on current window",
  callback = function()
    vim.opt.cursorline = true
    -- vim.wo.winbar = default_winbar
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
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

--------------------------------------------------------------------------------
-------------------------------- Remote Editing --------------------------------
--------------------------------------------------------------------------------

local pde_remote_autocmd_group = vim.api.nvim_create_augroup("pde-remote", { clear = true })
PDE_REMOTE_PENDING = 0
if vim.env.PDE_REMOTE_PATH ~= nil then
  local function get_paths_for_remote(buffer)
    local absolute_path = vim.api.nvim_buf_get_name(buffer)
    local cwd = vim.uv.cwd()
    if cwd == nil then
      return nil
    end
    local relative_path = string.sub(absolute_path, string.len(cwd) + 2)
    return {
      absolute_path = absolute_path,
      relative_path = relative_path,
      remote_path = vim.fn.expand(vim.env.PDE_REMOTE_PATH.."/"..relative_path)
    }
  end
  local function bypass_remote_sync(paths)
    local match =  string.match(paths.absolute_path, "/compile_commands%.json$", 0)
    if match == "/compile_commands.json" then
      return true
    end
    match =  string.match(paths.absolute_path, "/CMakeLists%.txt$", 0)
    if match == "/CMakeLists.txt" then
      return true
    end
    return false
  end
  local function rsync_file(name, source, dest, callback)
    local args = {source, dest}
    PDE_REMOTE_PENDING = PDE_REMOTE_PENDING + 1
    local handler
    handler = vim.uv.spawn("rsync", {args = args}, function(code, signal)
      PDE_REMOTE_PENDING = PDE_REMOTE_PENDING - 1
      vim.defer_fn(function()
        if code ~= 0 then
          vim.notify("Failed to sync "..name)
          vim.notify("command: rsync "..args[1].." "..args[2])
        end
        vim.cmd([[redraws]])
      end, 0)
      if handler ~= nil then
        vim.uv.close(handler)
      end
      if callback ~= nil then vim.defer_fn(callback, 0) end
    end)
  end
  local function bufwrite_autocmd_handler(ev)
    local paths = get_paths_for_remote(ev.buf)
    if paths == nil then
      return
    end
    if bypass_remote_sync(paths) then
      vim.notify("remote-sync: bypassing this file")
    end

    rsync_file(paths.relative_path, paths.absolute_path, paths.remote_path)
  end
  local function read_file_from_remote()
    local paths = get_paths_for_remote(0)
    if paths == nil then
      return
    end
    rsync_file(paths.relative_path, paths.remote_path, paths.absolute_path, function() vim.cmd([[e! ]]..paths.relative_path) end)
  end
  vim.api.nvim_create_autocmd({ "BufWrite" }, {
    group = pde_remote_autocmd_group,
    desc = "Rsync file to server",
    callback = bufwrite_autocmd_handler,
  })
  vim.api.nvim_create_user_command('RemoteReloadFile', read_file_from_remote, {})
end

--------------------------------------------------------------------------------
----------------------- Language Server Protocol Setup -------------------------
--------------------------------------------------------------------------------

local capabilities = vim.lsp.protocol.make_client_capabilities()

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

vim.cmd[[colorscheme catppuccin-ivo]]
vim.cmd("FzfLua register_ui_select")
vim.notify = require('mini.notify').make_notify()
