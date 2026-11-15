---https://github.com/echasnovski/mini.diff
return {
  "echasnovski/mini.diff",
  -- Loads with the first real file buffer; codecompanion also requires it as
  -- its diff provider.
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  config = function()
    local mini_diff = require("mini.diff")

    ---https://github.com/echasnovski/mini.diff?tab=readme-ov-file#default-config
    mini_diff.setup()
  end,
}
