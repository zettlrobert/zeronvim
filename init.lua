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

-- Disable remote-plugin providers before any plugin can probe them.
require("config.providers")

-- Filetype detection additions (.tofu, .env*). Must run before files open.
require("config.filetypes")

-- Options before plugins, so every plugin sees the final values when it loads.
require("config.options")

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { import = "config.plugins" },
    -- Own import: the directory has no init.lua, one spec file per theme.
    { import = "config.plugins.colorschemes" },
  },
  -- Colorscheme used while lazy.nvim installs missing plugins on a fresh
  -- clone. The catppuccin spec applies catppuccin-mocha once it is installed.
  install = { colorscheme = { "catppuccin", "habamax" } },
})

-- Require LSP
require("config.lsp")

-- Require keymaps
require("config.keymaps")

-- Require keymaps for sourcing
require("config.utils.source")

-- Editor-wide autocmds (yank highlight, presentation markdown)
require("config.autocmds")

-- :LintVersions and its startup check
require("config.utils.lint_versions")

-- :PatchColors and the catppuccin highlight patches
require("config.utils.patch_colorscheme")

-- Require window-title
require("config.window-title")

-- Require spellcheck
require("config.spellcheck")
