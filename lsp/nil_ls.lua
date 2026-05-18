-- nil — incremental Nix language server
-- https://github.com/oxalica/nil
-- Settings: https://github.com/oxalica/nil/blob/main/docs/configuration.md
-- :h lsp-config

return {
  cmd = { "nil" },
  filetypes = { "nix" },
  settings = {
    ["nil"] = {
      flake = {
        autoArchive = vim.NIL,
      },
    },
  },
}
