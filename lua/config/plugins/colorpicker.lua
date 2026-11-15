-- https://github.com/uga-rosa/ccc.nvim
return {
  "uga-rosa/ccc.nvim",
  -- The highlighter auto-enables on buffers, so load with the first real file
  -- buffer. The picker commands also load it from an empty start.
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  cmd = { "CccPick", "CccConvert", "CccHighlighterToggle", "CccHighlighterEnable", "CccHighlighterDisable" },
  opts = {
    highlighter = {
      auto_enable = true,
      lsp = true,
    },
  },
}
