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
vim.keymap.set({ 'n', 'i' }, '<C-k>', function()
  vim.lsp.buf.signature_help({
    close_events = { "InsertLeave", "CompleteDone", }
  })
end)

--------------------------------------------------------------------------------
----------------------------------- Plugins ------------------------------------
--------------------------------------------------------------------------------
if not LazySet then
  LazySet = true
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
      lazypath, })
  end
  vim.opt.rtp:prepend(lazypath)
  require("lazy").setup({
    git = { filter = false },
    { 'Bekaboo/dropbar.nvim',           config = true },
    { 'nvim-tree/nvim-tree.lua',        dependencies = { 'antosha417/nvim-lsp-file-operations' }, opts = {} },
    { 'mason-org/mason.nvim',           opts = {} },
    {
      'folke/lazydev.nvim',
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
    { 
      'neovim/nvim-lspconfig',
      event = { "BufReadPre", "BufNewFile" },
      dependencies = { 'folke/lazydev.nvim' },
      config = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        
        -- 1. Manual Overrides for specific servers
        local overrides = {
          clangd = { flags = { debounce_text_changes = 150 } },
          rust_analyzer = {
            settings = { ['rust-analyzer'] = { check = { command = "clippy" } } }
          },
          lua_ls = {},
        }

        -- 2. On-Demand Discovery
        -- This autocmd runs whenever you open a new filetype
        vim.api.nvim_create_autocmd('FileType', {
          group = vim.api.nvim_create_augroup('lsp-auto-enable', { clear = true }),
          callback = function(args)
            local ft = vim.bo[args.buf].filetype
            if ft == "" or ft == nil then return end

            -- Heuristic: search for servers in the 'lsp/' runtime path that might match
            -- We search for 'ft*.lua' and '*ft*.lua' to catch most servers.
            local potential_servers = {}
            local paths = vim.api.nvim_get_runtime_file('lsp/' .. ft .. '*.lua', true)
            vim.list_extend(paths, vim.api.nvim_get_runtime_file('lsp/*' .. ft .. '*.lua', true))
            
            for _, path in ipairs(paths) do
              local name = vim.fn.fnamemodify(path, ':t:r')
              potential_servers[name] = true
            end

            -- Always check overrides even if they don't match the filename heuristic
            for name, _ in pairs(overrides) do
              -- We could check if the override is relevant to this FT, 
              -- but it's safer to just let the loop handle it.
              potential_servers[name] = true
            end

            for name, _ in pairs(potential_servers) do
              -- Skip if already configured for this buffer or globally
              if not vim.lsp.get_config(name) then
                local config = vim.lsp.config[name]
                if config then
                  -- Verify this server actually supports the current filetype
                  local supports_ft = false
                  for _, sft in ipairs(config.filetypes or {}) do
                    if sft == ft then supports_ft = true; break end
                  end

                  if supports_ft then
                    local cmd = config.cmd
                    if cmd and cmd[1] and vim.fn.executable(cmd[1]) == 1 then
                      local opts = vim.tbl_deep_extend('force', { capabilities = capabilities }, overrides[name] or {})
                      vim.lsp.config(name, opts)
                      vim.lsp.enable(name)
                    end
                  end
                end
              end
            end
          end,
        })
      end
    },    { 'windwp/nvim-autopairs',          opts = { map_cr = false } },
    { 'kylechui/nvim-surround',         version = "*",            keys = { "ys", "ds", "cs" },           config = true, },
    { 'echasnovski/mini.notify',        version = false,          config = true },
    { 'lewis6991/gitsigns.nvim',        event = "VeryLazy",        opts = { current_line_blame = false, } },
    { 'Darazaki/indent-o-matic',        config = true },
    { 'tpope/vim-abolish' },
    {
      'nvim-treesitter/nvim-treesitter',
      branch = 'master',
      build = ':TSUpdate',
      lazy = false,
      main = 'nvim-treesitter.configs',
      opts = {
        auto_install = true,
        ensure_installed = { 
            'rust', 'cpp', 'lua', 'markdown', 'markdown_inline',
            'bash', 'python', 'json', 'toml', 'yaml', 'vim', 'vimdoc', 'regex',
            'git_config', 'git_rebase', 'gitcommit', 'gitignore', 'diff'
        },
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
    {
      "f-person/auto-dark-mode.nvim",
      opts = {
        update_interval = 1000,
        set_dark_mode = function()
          vim.api.nvim_set_option_value("background", "dark", {})
          vim.cmd("colorscheme catppuccin")
        end,
        set_light_mode = function()
          vim.api.nvim_set_option_value("background", "light", {})
          vim.cmd("colorscheme catppuccin")
        end,
      }
    },
    {
      "catppuccin/nvim",
      name = "catppuccin",
      lazy = false,
      priority = 1000,
      opts = {
        flavour = "auto",
        background = {
          light = "latte",
          dark = "macchiato",
        },
      },
      config = function(_, opts)
        require("catppuccin").setup(opts)
        vim.cmd.colorscheme "catppuccin"
      end,
    },
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

function get_mode_name()
  return mode_map[vim.api.nvim_get_mode().mode] or 'UNKNOWN'
end

local statusline = {
  ' %{luaeval(\'get_mode_name()\')}',
  '%=', '%f', '%r', '%m', '%=',
  ' %{&expandtab?"\u{f1050}":"\u{f0312} "} %{&shiftwidth}',
  ' %2p%%', ' %3l:%-2c', ' %{&filetype}',
}

vim.opt.statusline = table.concat(statusline, '')

--------------------------------------------------------------------------------
-------------------------------- Auto Commands ---------------------------------
--------------------------------------------------------------------------------

local autocmd_group = vim.api.nvim_create_augroup("user-autocommands", { clear = true })
vim.api.nvim_create_autocmd({ "BufHidden" }, {
  group = autocmd_group,
  desc = "Delete scratch buffers",
  pattern = { "*No Name*" },
  callback = function(ev)
    if vim.api.nvim_buf_is_valid(ev.buf) then
      vim.api.nvim_buf_delete(ev.buf, {force = false})
    end
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
  end,
})

vim.api.nvim_create_autocmd({ "WinEnter" }, {
  group = autocmd_group,
  desc = "Enable cursorline on current window",
  callback = function()
    vim.opt.cursorline = true
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = autocmd_group,
  desc = "Start treesitter",
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    if ft == nil or ft == "" then return end
    local lang = vim.treesitter.language.get_lang(ft)
    if not lang then return end

    local ok, parser = pcall(vim.treesitter.get_parser, args.buf, lang)
    if ok and parser then
      vim.treesitter.start(args.buf, lang)
    end
  end,
})

vim.api.nvim_create_autocmd('VimResized', {
  group = autocmd_group,
  desc = "Even Windows",
  callback = function() vim.cmd("wincmd =") end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

vim.cmd("FzfLua register_ui_select")
vim.notify = require('mini.notify').make_notify()
