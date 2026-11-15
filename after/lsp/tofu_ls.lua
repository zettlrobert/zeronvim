-- tofu-ls (OpenTofu language server)
-- https://github.com/opentofu/tofu-ls
-- Install: Mason -> tofu-ls (auto-installed via lua/config/plugins/mason.lua)
-- :h lsp-config
--
-- cmd (`tofu-ls serve`) and filetypes come from nvim-lspconfig. `.tofu` files
-- are detected as terraform in lua/config/filetypes.lua. Override: also treat
-- a directory with main.tf as a root.

return {
  root_markers = { ".terraform", ".git", "main.tf" },
}
