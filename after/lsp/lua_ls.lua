-- lua-language-server
-- https://github.com/LuaLS/lua-language-server
-- Settings: https://luals.github.io/wiki/settings/
-- :h lsp-config

-- cmd, filetypes and root_markers come from nvim-lspconfig (its markers are
-- grouped by priority and include .emmyrc.json). Override: settings only.

return {
  settings = {
    Lua = {
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
}
