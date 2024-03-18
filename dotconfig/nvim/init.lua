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
vim.opt.scrolloff = 5
vim.opt.signcolumn = "yes"
vim.opt.guifont = "JetBrainsMono NF:h11"
vim.opt.showcmd = false
vim.cmd [[   hi NonText cterm=NONE ctermfg=NONE ]]
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.list = true
vim.opt.listchars:append("eol:\u{ebea}")
vim.opt.listchars:append("tab:\u{f0312}  ")
vim.opt.listchars:append("trail:·")
vim.opt.pumheight = 10
vim.opt.cinoptions = "N-s,0g,E-s,(0,j1,l1,:0,Ws"
vim.opt.shortmess:append('c')
vim.opt.shortmess:append('C')
vim.opt.completeopt = 'menuone,noinsert,popup'
vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.cmd([[let $ESCDELAY=0]])

vim.cmd("filetype plugin on")

vim.cmd([[ set titlestring=%{fnamemodify(getcwd(),':h:t')}/%{fnamemodify(getcwd(),':t')} ]])

--------------------------------------------------------------------------------
--------------------------------- Key Actions -----------------------------------
--------------------------------------------------------------------------------

local KeyAction = {}
KeyAction.cr_action = function()
  if vim.fn.pumvisible() ~= 0 then
    local has_item_selected = vim.fn.complete_info()['selected'] ~= -1
    if has_item_selected then
      return vim.api.nvim_replace_termcodes('<C-y>', true, true, true)
    end
  end
  return require('nvim-autopairs').autopairs_cr()
end

KeyAction.tab_action = function()
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

KeyAction.shift_tab_action = function()
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

-- ==============================================================================

vim.api.nvim_create_user_command('ClearNotifications', "lua require'mini.notify'.clear()", {})
vim.api.nvim_create_user_command('RemoveIostream', 'g/iostream\\|cout/d', {})

vim.keymap.set('n', '<leader>,', '<cmd>e ~/.config/nvim/init.lua<CR>', { noremap = true, silent = true })
vim.keymap.set('s', 'jk', '<Esc>', { noremap = true, silent = true })
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true, silent = true })

--------------------------------------------------------------------------------
--------------------------------- Fuzzy Finder ---------------------------------
--------------------------------------------------------------------------------
vim.keymap.set('n', '<leader>n', "<cmd>Neotree float toggle=true<cr>")
vim.keymap.set('n', '<leader>N', "<cmd>Neotree float focus reveal<cr>")
vim.keymap.set('n', '<leader>f', "<cmd>FzfLua files<cr>")
vim.keymap.set('n', '<leader>b', "<cmd>FzfLua buffers<cr>")
vim.keymap.set('n', '<leader>s', "<cmd>FzfLua lsp_document_symbols<cr>")
vim.keymap.set('n', '<leader>S', "<cmd>FzfLua lsp_workspace_symbols<cr>")
vim.keymap.set('n', '<leader>l', "<cmd>FzfLua live_grep<cr>")
vim.keymap.set('n', '<leader>p', "<cmd>FzfLua commands<cr>")
vim.keymap.set('n', '<leader>c', "<cmd>FzfLua colorschemes<cr>")
--------------------------------------------------------------------------------
------------------------------------ Utils -------------------------------------
--------------------------------------------------------------------------------
vim.keymap.set('n', '<leader>w', "<C-W>", { noremap = false })
vim.keymap.set('n', '<leader>q', "<cmd>Bdelete<CR>")
vim.keymap.set('n', '<leader>Q', "<cmd>bdelete<CR>")
vim.keymap.set('n', '<leader>e', "<cmd>lua vim.diagnostic.open_float()<CR>")
--------------------------------------------------------------------------------
---------------------------------- Navigation ----------------------------------
--------------------------------------------------------------------------------
vim.keymap.set('n', ']c', "<cmd>Gitsigns next_hunk<CR>")
vim.keymap.set('n', '[c', "<cmd>Gitsigns prev_hunk<CR>")
vim.keymap.set('n', ']b', "<cmd>bn<CR>")
vim.keymap.set('n', ']e', "<cmd>lua vim.diagnostic.goto_next()<CR>")
vim.keymap.set('n', '[b', "<cmd>bp<CR>")
vim.keymap.set('n', '[e', "<cmd>lua vim.diagnostic.goto_prev()<CR>")
--------------------------------------------------------------------------------
------------------------------------- Git --------------------------------------
--------------------------------------------------------------------------------
vim.keymap.set('n', 'gb', "<cmd>Gitsigns blame_line<CR>")
vim.keymap.set('n', 'grh', "<cmd>Gitsigns reset_hunk<CR>")
vim.keymap.set('n', 'grb', "<cmd>Gitsigns reset_buffer<CR>")
--------------------------------------------------------------------------------
---------------------------------- Completion -----------------------------------
--------------------------------------------------------------------------------
vim.keymap.set({ 'i', 's' }, '<Tab>', KeyAction.tab_action, { expr = true })
vim.keymap.set({ 'i', 's' }, '<S-Tab>', KeyAction.shift_tab_action, { expr = true })
vim.keymap.set('i', '<CR>', KeyAction.cr_action, { expr = true, replace_keycodes = false, })
vim.keymap.set('i', '<C-Space>', '<C-x><C-o>', {})
--------------------------------------------------------------------------------
--------------------------- Language Server Protocol ---------------------------
--------------------------------------------------------------------------------
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'gi', "<cmd>FzfLua lsp_implementations<CR>")
vim.keymap.set('n', 'gi', "<cmd>FzfLua lsp_references<CR>")
vim.keymap.set('n', 'K', vim.lsp.buf.hover)
vim.keymap.set('n', '<F2>', vim.lsp.buf.rename)
vim.keymap.set('n', '<leader>.', vim.lsp.buf.code_action)
vim.keymap.set({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help)

-- ==============================================================================


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
    { 'tpope/vim-abolish',               cmd = { "Subvert", "S" },        keys = { "cr", }, },
    { 'folke/neodev.nvim',               config = true },
    { 'neovim/nvim-lspconfig',           event = "VeryLazy", },
    { 'NMAC427/guess-indent.nvim',       config = true },
    { 'michaeljsmith/vim-indent-object', event = "BufEnter", },
    { 'PeterRincker/vim-argumentative',  event = "BufEnter", },
    { 'windwp/nvim-autopairs',           opts = { map_cr = false } },
    { 'famiu/bufdelete.nvim',            cmd = { "Bdelete", "Bwipeout" }, },
    { 'kylechui/nvim-surround',          version = "*",                   keys = { "ys", "ds", "cs" }, config = true, },
    { 'numToStr/Comment.nvim',           keys = { "gc", "gb" },           config = true, },
    { 'echasnovski/mini.notify',         version = false,                 config = true },
    {
      'lukas-reineke/indent-blankline.nvim',
      name = 'ibl',
      opts = {
        indent = { char = "│" },
        scope = { enabled = false, show_start = false, show_end = false, },
      }
    },
    { 'lewis6991/gitsigns.nvim', event = "VeryLazy", opts = { current_line_blame = false, } },
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
          preview = { default = 'builtin' }
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
    {
      "catppuccin/nvim",
      name = "catppuccin",
      lazy = false,
      opts = {
        flavour = "frappe",
        background = { light = "latte", dark = "frappe", },
        integrations = {
          neotree = true,
          cmp = true,
          gitsigns = true,
        },
        color_overrides = {
          frappe = {
            comment = "#ffffff",
          },
        },
      },
      config = function(_, opts)
        require 'catppuccin'.setup(opts)
      end,
      priority = 1000,
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      cmd = "Neotree",
      dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim", },
      opts = {
        enable_diagnostics = false,
        sources = { "filesystem", "buffers", },
        window = {
          mappings = { ["<space>"] = "none", ["<F2>"] = "rename", }
        },
        filesystem = {
          use_libuv_file_watcher = true,
          filtered_items = {
            visible = true, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = true,
            hide_gitignored = true,
            hide_hidden = true, -- only works on Windows for hidden files/directories
          },
        },
      },
    },
    {
      'nvim-lualine/lualine.nvim',
      opts = {
        extensions = { 'quickfix', 'neo-tree', 'nvim-dap-ui', 'mason', 'lazy' },
        options = {
          icons_enabled = false,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {},
          theme = 'auto',
          always_divide_middle = true,
          globalstatus = true,
        },
        sections = {
          lualine_a = {
          },
          lualine_b = { 'mode' },
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
                return "\u{f1050} " .. vim.bo.shiftwidth
              else
                return "\u{f0312} " .. vim.bo.tabstop
              end
            end,
          },
          lualine_z = {
            function() return os.getenv("ZELLIJ_SESSION_NAME") or '' end
          },
        },
        inactive_winbar = {
          lualine_c = { { 'filename', path = 0, symbols = { modified = '●' } } },
          lualine_z = {
            { function() return "" end, draw_empty = true, }
          },
        },
        winbar = {
          lualine_c = { { 'filename', path = 0, symbols = { modified = '●' } } },
          lualine_z = {
            { function() return "" end, draw_empty = true, }
          },
        },
      },
    },
  })

end


--------------------------------------------------------------------------------
-------------------------------- Auto Commands ---------------------------------
--------------------------------------------------------------------------------

local autocmd_group = vim.api.nvim_create_augroup("user-autocommands", {})
vim.api.nvim_create_autocmd({ "BufHidden" }, {
  group = autocmd_group,
  desc = "Delete scratch buffers",
  pattern = { "*No Name*" },
  callback = function(ev)
    vim.api.nvimm_buf_delete(ev.buf)
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
  pattern = { 'cpp', 'rust', 'lua' },
  callback = function() vim.treesitter.start() end,
})

vim.api.nvim_create_autocmd('VimResized', {
  group = autocmd_group,
  desc = "Even Windows",
  callback = function() vim.cmd("wincmd =") end,
})

-- local CompletionTimer = vim.uv.new_timer()
vim.api.nvim_create_autocmd('InsertCharPre', {
  group = autocmd_group,
  desc = "Start AutoComplete",
  callback = function ()
    -- CompletionTimer:stop()
    -- CompletionTimer:start(100, 0, vim.schedule_wrap(function()
      if vim.fn.pumvisible() == 0 then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-x><C-o>', true, false, true), 'n', false)
      end
    -- end))
  end
})

vim.api.nvim_create_autocmd('CompleteDone', {
  group = autocmd_group,
  desc = 'Expand LSP snippet',
  callback = function(opts)
    local comp = vim.v.completed_item
    local item = vim.tbl_get(comp, 'user_data', 'nvim', 'lsp', 'completion_item')

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

    CmpItem = vim.v.completed_item
    CmpSecondItem = item

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

vim.cmd.colorscheme("catppuccin")
vim.cmd("FzfLua register_ui_select")
vim.notify = require('mini.notify').make_notify()
