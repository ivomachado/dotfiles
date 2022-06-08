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

    use {'dracula/vim', as = 'dracula', disable = true}
    use {'sainnhe/everforest', disable = true}
    use {'marko-cerovac/material.nvim', disable = true}
    use {'folke/tokyonight.nvim', disable = true}
    use {
        'sonph/onehalf',
        rtp = 'vim',
        config = function()
            vim.cmd("colorscheme onehalflight")
        end
    }

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

    use 'brooth/far.vim'
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

    use {
        "beauwilliams/focus.nvim",
        config = function()
            require("focus").setup{
                bufnew =  false,
                hybridnumber = false,
                number = false,
                autoresize = false,
                signcolumn = false,
                compatible_filetrees = {"neo-tree"}
            }
        end,
    }

  use {
      'neovim/nvim-lspconfig', -- Collection of configurations for the built-in LSP client
      'williamboman/nvim-lsp-installer' -- Install LSP clients
  }
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

  use {
      'ms-jpq/chadtree',
      branch = 'chad',
      run =  'python3 -m chadtree deps',
      disable = true
  }

  use {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      requires = { 
          "nvim-lua/plenary.nvim",
          "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
          "MunifTanjim/nui.nvim",
      },
  }


  use 'dstein64/vim-startuptime'

  use 'CoatiSoftware/vim-sourcetrail'

  use 'moll/vim-bbye' -- Buffer management

  use {
      'nvim-telescope/telescope.nvim',
      requires = {
          'nvim-lua/plenary.nvim'
      }
  }

  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

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