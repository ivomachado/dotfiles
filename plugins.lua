local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    use {'dracula/vim', as = 'dracula'}
    use 'sainnhe/everforest'
    use 'marko-cerovac/material.nvim'
    use 'folke/tokyonight.nvim'

    use {
      'weirongxu/plantuml-previewer.vim',
      requires = { 'aklt/plantuml-syntax', 'tyru/open-browser.vim' }
    }

    use {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end
    }
 
    use 'rcarriga/nvim-notify'

    use 'tpope/vim-obsession'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'tpope/vim-sensible'
    use 'tpope/vim-abolish'
    use 'roryokane/detectindent'
    use 'michaeljsmith/vim-indent-object'
    use 'PeterRincker/vim-argumentative'
    use 'lukas-reineke/indent-blankline.nvim' -- Adiciona guidelines e mostra os espaços

    use { "beauwilliams/focus.nvim",
      config = function() require("focus").setup{
        bufnew =  false,
        hybridnumber = true,
        number = true,
        cursorline = false,
      }
    end }

    use 'neovim/nvim-lspconfig' -- Collection of configurations for the built-in LSP client
    use 'hrsh7th/nvim-cmp' -- Plugin de AutoComplete
    use 'hrsh7th/cmp-nvim-lsp' -- Fonte de LSP para autocomplete
    use 'hrsh7th/cmp-path' -- Fonte de paths para autocomplete
    use 'hrsh7th/cmp-buffer' -- Fonte de palavras de buffer para autocomplete
    use 'hrsh7th/cmp-cmdline' -- Fonte de palavras de buffer para autocomplete
    use 'onsails/lspkind-nvim' -- Mostra ícones no autocomplete

    use {
      -- Aquelas janelas flutuantes para mostrar previews com gpd, gpp, gP
      'rmagatti/goto-preview',
      config = function()
        require('goto-preview').setup {
          default_mappings = true,
        }
      end
    }

    use { 'ms-jpq/chadtree', branch = 'chad', run =  'python3 -m chadtree deps'}

    use 'dstein64/vim-startuptime'

    use 'moll/vim-bbye' -- Buffer management

    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/plenary.nvim'
      }
    }
    use {'kevinhwang91/nvim-bqf'} -- Better quickfix windows

    use {
      'lewis6991/gitsigns.nvim',
      requires = {
        'nvim-lua/plenary.nvim'
      },
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
    }

    use 'ray-x/lsp_signature.nvim'

end)
