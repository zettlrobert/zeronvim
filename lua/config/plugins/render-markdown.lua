-- https://github.com/MeanderingProgrammer/render-markdown.nvim
-- https://github.com/MeanderingProgrammer/render-markdown.nvim/wiki
return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local markdown = require("render-markdown")

    local code_block = "#222235"

    vim.api.nvim_set_hl(0, "CodeBlock", { bg = code_block })

    markdown.setup({
      enabled = true,
      render_modes = { "n" },
      completions = {
        lsp = {
          enabled = true,
        },
      },
      heading = {
        sign = false,
        width = "block",
        min_width = 120,
      },
      code = {
        position = "right",
        width = "block",
        border = "thick",
        highlight = "CodeBlock",
      },
    })
  end,
}
