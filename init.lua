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

-- Require Neovim Options
require('options')

-- Require generic keymaps, plugin specific keymaps are located in the plugin file
require('keymaps')

-- Require Plugins
require("lazy").setup("plugins")
