-- bootstarap lazy.nvim
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

require("lazy").setup({
  -- Pleneary Lua Functions to use with neoviom
  "nvim-lua/plenary.nvim",

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    requires = "nvim-treesitter/nvim-treesitter",
  },

  "windwp/nvim-ts-autotag",

  -- commentstring based on cursor location
  "JoosepAlviste/nvim-ts-context-commentstring",

  -- context of current element
  "nvim-treesitter/nvim-treesitter-context",

  -- Colorscheme
  { "catppuccin/nvim",      name = "catppuccin" },
  { "rebelot/kanagawa.nvim" },
  { 'rose-pine/neovim',     name = 'rose-pine' },

  -- neorg
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {
            config = {
              icon_preset = 'diamond',
            },
          },                  -- Adds pretty icons to your documents
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                zettlrobert = "~/notes/zettl",
                zerodev = "~/notes/zerodev-solutions",
                mobilehead = "~/notes/mobilehead",
              },
              default_workspace = "zettlrobert",
            }
          },
          ["core.summary"] = {},
        },
      }
    end,
  },

  -- LSP Color Fix
  "folke/lsp-colors.nvim",

  -- Lualine
  "nvim-lualine/lualine.nvim",

  -- NvimTree - Filemanager
  "nvim-tree/nvim-tree.lua",

  -- Indentlines
  { "lukas-reineke/indent-blankline.nvim", main = "ibl",       opts = {} },

  -- Icons
  "nvim-tree/nvim-web-devicons",

  -- Gitsigns
  "lewis6991/gitsigns.nvim",

  -- Diffview
  "sindrets/diffview.nvim",

  -- Comments
  "numToStr/Comment.nvim",

  -- Telescope Fuzzy Finder
  "nvim-telescope/telescope.nvim",

  -- ToggleTerm
  "akinsho/toggleterm.nvim",

  -- LSP
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",

  -- Null-LS
  "jose-elias-alvarez/null-ls.nvim",

  -- Winbar, breadcrumbs
  "SmiteshP/nvim-navic",

  -- CMP Completion
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-buffer",
  "saadparwaiz1/cmp_luasnip",
  "hrsh7th/cmp-calc",
  "f3fora/cmp-spell",

  -- Snippet Engine
  "L3MON4D3/LuaSnip",

  -- Snippets
  "rafamadriz/friendly-snippets",

  -- Debugging
  "jayp0521/mason-nvim-dap.nvim",
  "mfussenegger/nvim-dap",
  "rcarriga/nvim-dap-ui",
  "theHamsta/nvim-dap-virtual-text",
  "mxsdev/nvim-dap-vscode-js",

  -- Quickfix and Location List
  "folke/trouble.nvim",
  "folke/todo-comments.nvim",

  -- Color Picker
  "uga-rosa/ccc.nvim",

  -- Syntax
  "jxnblk/vim-mdx-js",

  -- Zen
  {
    "folke/zen-mode.nvim",
    dependencies = {
      "folke/twilight.nvim",
    },
    opts = require("zeronvim.plugins.zen").config
  },

  -- AI Codeium
  {
    "jcdickinson/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup(
        require("codeium").config
      )
    end
  },
})
