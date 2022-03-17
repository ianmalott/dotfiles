--[[ Packer quick reference

Whenever you make changes to your plugin configuration,
you must run `PackerCompile` or `PackerSync`.

:PackerCompile        -- Regenerate compiled loader file
:PackerClean          -- Remove any disabled or unused plugins
:PackerInstall        -- Clean, then install missing plugins
:PackerUpdate         -- Clean, then update and install plugins
:PackerSync           -- Perform `PackerUpdate` and then `PackerCompile`
:PackerLoad foo bar   -- Loads opt plugin(s) immediately

--]]

function config(name)
  return string.format([[require("config/%s")]], name)
end

return require('packer').startup(function (use)
  -- Manage packer with packer
  use 'wbthomason/packer.nvim'

  -- Appearance
  use { 'embark-theme/vim', as = 'embark', branch = 'main' }
  use { 'itchyny/lightline.vim' }

  -- IDE functionality
  use { 'DataWraith/auto_mkdir' }
  use { 'christoomey/vim-tmux-navigator' }
  use { 'scrooloose/nerdtree' }
  use { 'tpope/vim-fugitive' }

  -- Editing enhancements
  use { 'tommcdo/vim-exchange' }
  use { 'tpope/vim-commentary' }
  use { 'tpope/vim-endwise' }
  use { 'tpope/vim-repeat' }
  use { 'tpope/vim-surround' }

  -- Elixir
  use { 'elixir-lang/vim-elixir' }

  -- Go
  use { 'fatih/vim-go' }

  -- Ruby & Rails
  use { 'nelstrom/vim-textobj-rubyblock',
    requires = { 'kana/vim-textobj-user' },
    ft = 'ruby'
  }

  use { 'tpope/vim-bundler', ft = 'ruby' }
  use { 'tpope/vim-rails', ft = 'ruby' }
  use { 'tpope/vim-rbenv', ft = 'ruby' }
  use { 'vim-ruby/vim-ruby', ft = 'ruby' }

  -- Neovim
  use { 'neovim/nvim-lspconfig' }
  use { 'williamboman/nvim-lsp-installer',
    config = config('nvim-lsp-installer'),
    requires = {
      { 'neovim/nvim-lspconfig' }
    },
  }
  use { 'nvim-telescope/telescope.nvim',
    requires = {
      { 'BurntSushi/ripgrep' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      { 'sharkdp/fd' },
    }
  }
  use { 'nvim-treesitter/nvim-treesitter',
    config = config('nvim-treesitter'),
    run = ':TSUpdate'
  }
end)
