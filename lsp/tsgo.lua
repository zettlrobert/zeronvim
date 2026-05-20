-- tsgo (TypeScript Go port — experimental native TypeScript compiler)
-- https://github.com/microsoft/typescript-go
-- Install: external — `npm i -g @typescript/native-preview` (not in Mason registry)
--
-- Not auto-attached. vtsls is the default TS server (see lsp/vtsls.lua);
-- tsgo overlaps on every filetype, so we keep it registered but inert.
-- Toggle on-demand for the current buffer via <leader>tt
-- (uses config.utils.toggle_lsp_server — same mechanism as <leader>tv for vale).

return {
  cmd = { "tsgo", "--stdio" },
  root_markers = { "tsconfig.base.json", "nx.json", "package.json", ".git" },
  filetypes = {},
}
