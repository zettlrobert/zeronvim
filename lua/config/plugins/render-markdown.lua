-- https://github.com/MeanderingProgrammer/render-markdown.nvim
-- https://github.com/MeanderingProgrammer/render-markdown.nvim/wiki
return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    local markdown = require("render-markdown")
    markdown.setup({
      render_modes = true,
      completions = {
        blink = {
          enabled = true
        }
      }
    })
  end,
}
