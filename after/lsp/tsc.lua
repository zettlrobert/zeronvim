-- tsc: the TypeScript 7 native language server (`tsc --lsp --stdio`)
-- https://github.com/microsoft/typescript-go
-- Settings: https://github.com/neovim/nvim-lspconfig/blob/master/lsp/tsc.lua
-- Install: Mason -> tsc (TypeScript 7), or the project's own typescript@7
--          in node_modules/.bin, which lspconfig prefers.
-- :h lsp-config
--
-- Default TypeScript/JavaScript server. In Vue workspaces it stays off and
-- vtsls + vue_ls take over (see lua/config/lsp/vue.lua): TypeScript 7 has no
-- plugin API yet, so @vue/typescript-plugin only runs in vtsls.
--
-- lspconfig's tsc config pairs cmd with root_dir through a shared binary
-- cache (root_dir finds the project's tsc, cmd starts it). Both are taken from
-- the same loaded copy of that file so the pair keeps working; root_dir is
-- only wrapped to skip Vue workspaces.

local upstream_path = vim.iter(vim.api.nvim_get_runtime_file("lsp/tsc.lua", true)):find(function(path)
  return path:find("nvim-lspconfig", 1, true) ~= nil
end)
local upstream = upstream_path and dofile(upstream_path) or {}

return {
  cmd = upstream.cmd,
  root_dir = function(bufnr, on_dir)
    if require("config.lsp.vue").is_vue_workspace(bufnr) then
      return -- vtsls handles Vue workspaces
    end
    if upstream.root_dir then
      return upstream.root_dir(bufnr, on_dir)
    end
  end,
}
