-- Access vim.fn with variable `fn`
local fn = vim.fn

-- Packer install path equals system user data directory
-- will be ~/.local/share/nvim/site/pack/packer/packer.nvim
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
  print "Installing packer, close and reopen nvim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads nvim when plugins.lua is saved
-- TODO: Write with neovim autocommand syntax
vim.cmd [[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- protected call to packer, to ensure we do not error out on first load
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("Error loading packer...")
  return
end

-- Popup window for packer
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- _Plugins to install
return packer.startup(function(use)
  -- Packer self management
  use { "wbthomason/packer.nvim" } -- Have packer manage itself

  -- Pleneary Lua Functions to use with neoviom
  use { "nvim-lua/plenary.nvim" }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  }
  use "JoosepAlviste/nvim-ts-context-commentstring"

  -- Colorscheme
  use { "catppuccin/nvim", as = "catppuccin" }

  -- Lualine
  use { "nvim-lualine/lualine.nvim" }

  -- NvimTree - Filemanager
  use { "nvim-tree/nvim-tree.lua" }

  -- Indentlines
  use { "lukas-reineke/indent-blankline.nvim" }

  -- Icons
  use { "nvim-tree/nvim-web-devicons" }

  -- Gitsigns
  use { "lewis6991/gitsigns.nvim" }

  -- Comments
  use { "numToStr/Comment.nvim" }

  -- Telescope Fuzzy Finder
  use { "nvim-telescope/telescope.nvim" }

  -- ToggleTerm
  use { "akinsho/toggleterm.nvim" }

  -- LSP
  use { "williamboman/mason.nvim" }
  use { "williamboman/mason-lspconfig.nvim" }
  use { "neovim/nvim-lspconfig" }

  -- Null-LS
  use { "jose-elias-alvarez/null-ls.nvim" }

  -- Winbar, breadcrumbs
  use { "SmiteshP/nvim-navic" }

  -- CMP Completion
  use { "hrsh7th/cmp-nvim-lsp" }
  use { "hrsh7th/cmp-path" }
  use { "hrsh7th/cmp-cmdline" }
  use { "hrsh7th/nvim-cmp" }
  use { "hrsh7th/cmp-nvim-lua" }
  use { "hrsh7th/cmp-buffer" }
  use { "saadparwaiz1/cmp_luasnip" }
  use { "hrsh7th/cmp-calc" }
  use { "f3fora/cmp-spell" }

  -- Snippet Engine
  use { "L3MON4D3/LuaSnip" }

  -- Snippets
  use { "rafamadriz/friendly-snippets" }

  -- Debugging
  use { "mfussenegger/nvim-dap" }
  use { "rcarriga/nvim-dap-ui" }
  use { "theHamsta/nvim-dap-virtual-text" }
  use { "mxsdev/nvim-dap-vscode-js" }

  -- Color Picker
  use { "uga-rosa/ccc.nvim" }

  -- Automatically setup configuration after cloning packer
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
