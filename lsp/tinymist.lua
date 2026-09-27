-- tinymist (Typst language server)
-- https://github.com/Myriad-Dreamin/tinymist
-- Defaults (cmd, filetypes, root_markers, the LspTinymistExport* commands)
-- come from nvim-lspconfig; only the settings below are ours.
--
-- Formatting: typstyle and typstfmt are compiled into tinymist, so there is
-- no separate mason tool. conform.lua has no typst entry and falls through to
-- `lsp_format = "fallback"`, which means tinymist formats typst on save.
-- Widths mirror the prettierd config in conform.lua (printWidth 80, 2 spaces).

return {
  settings = {
    formatterMode = "typstyle",
    formatterPrintWidth = 80,
    formatterIndentSize = 2,
  },
}
