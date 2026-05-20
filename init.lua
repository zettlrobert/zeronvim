-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })

  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

-- Put lazy into the runtimepath for neovim
vim.opt.runtimepath:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { import = "config.plugins" },
  },
})

-- pcall so a missing colorscheme (e.g. mid-Lazy-sync, fresh clone) doesn't
-- abort init.lua and cascade into "loop or previous error" on later requires
pcall(vim.cmd.colorscheme, "catppuccin-mocha")

-- Require Neovim Options
require("config.options")

-- Require LSP
require("config.lsp")

-- Require keymaps
require("config.keymaps")

-- Require keymaps for sourcing
require("config.utils.source")

-- Require ALL custom utilities
require("config.utils")

-- Require window-title
require("config.window-title")

-- Require quickfix/loclist window heading
require("config.qf_heading")

-- Require spellcheck
require("config.spellcheck")
