-- Access vim.fn with variable `fn`
local fn = vim.fn

-- Packer install path equals system user data directory
-- will be ~/.local/share/nvim/site/pack/packer/packer.nvim
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
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

  -- Colorscheme
  use { "catppuccin/nvim", as = "catppuccin"}


  -- Automatically setup configuration after cloning packer
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
