--[[
Remote-plugin language providers (:h provider).

Providers are Neovim's bridge to plugins written in Python, Ruby, Perl or
Node (remote plugins). They are unrelated to LSP: language servers live in
lsp/ and are wired up by lua/config/lsp/init.lua.

No installed plugin is a remote plugin (there is no rplugin.vim manifest),
so all four are disabled. That skips their host probes and the matching
:checkhealth warnings. Copilot and other Node-based tools spawn their own
`node` process and do not go through the Node provider.

To enable one: delete its line below and install its host package
(python3 -> pynvim, ruby -> neovim gem, perl -> Neovim::Ext, node -> neovim
npm package), then confirm with :checkhealth provider.
]]

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
