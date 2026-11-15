-- https://github.com/neovim/nvim-lspconfig
--
-- Only supplies data: its lsp/<name>.lua files hold the default cmd,
-- filetypes and root markers for each server. Our own after/lsp/<name>.lua
-- files (see lua/config/lsp/init.lua) are merged on top and win on conflicts
-- (:h lsp-config-merge); most only override settings, so they rely on these
-- defaults for `cmd`.
--
-- Must be eager: vim.lsp.enable() in lua/config/lsp/init.lua resolves configs
-- from the runtimepath, so lspconfig has to be on it at startup. It used to be
-- loaded only as a dependency of nvim-navbuddy, which broke every server
-- without its own cmd once navbuddy became lazy.
return {
  "neovim/nvim-lspconfig",
  lazy = false,
}
