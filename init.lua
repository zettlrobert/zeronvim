-- Define the path for lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- File for generic Neovim Keymaps - Lazy does require them to be loaded before the plugin, but keymaps contain plugin references
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Require Neovim Options
require('options')

-- Require Plugins
require("lazy").setup("plugins")

-- Require Autocommands
require("autocommands/conceallevel")

-- Require generic keymaps, plugin specific keymaps are located in the plugin file
require('keymaps')

-- Diagnostics Configuration
require('diagnostics')
