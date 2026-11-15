-- vue_ls (Vue language server, @vue/language-server)
-- https://github.com/vuejs/language-tools/tree/master/packages/language-server
-- Neovim setup: https://github.com/vuejs/language-tools/wiki/Neovim
-- Install: Mason -> vue-language-server (auto-installed via lua/config/plugins/mason.lua)
-- :h lsp-config
--
-- Hybrid mode: vue_ls handles the template and style parts of .vue files and
-- forwards TypeScript requests to vtsls (after/lsp/vtsls.lua), which runs in
-- Vue workspaces with @vue/typescript-plugin. cmd, filetypes, root markers and
-- the request forwarding all come from nvim-lspconfig.

return {}
