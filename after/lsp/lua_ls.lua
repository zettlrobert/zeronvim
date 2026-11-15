-- lua-language-server
-- https://github.com/LuaLS/lua-language-server
-- Settings: https://luals.github.io/wiki/settings/
-- :h lsp-config

-- cmd, filetypes and root_markers come from nvim-lspconfig (its markers are
-- grouped by priority and include .emmyrc.json).
--
-- No workspace.library here: lazydev.nvim (lua/config/plugins/lazydev.lua)
-- adds the Neovim runtime and every required plugin, only inside Neovim
-- config/plugin projects. A static nvim_get_runtime_file("", true) library
-- loaded the whole runtimepath into every Lua project as well.
return {}
