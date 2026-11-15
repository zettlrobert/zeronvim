---https://github.com/echasnovski/mini.diff
return {
  "echasnovski/mini.diff",
  -- Loads with the first real file buffer; codecompanion also requires it as
  -- its diff provider.
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  ---https://github.com/echasnovski/mini.diff?tab=readme-ov-file#default-config
  opts = {},
}
