-- https://github.com/MeanderingProgrammer/render-markdown.nvim
-- https://github.com/MeanderingProgrammer/render-markdown.nvim/wiki
return {
  "MeanderingProgrammer/render-markdown.nvim",
  -- Only renders markdown (the default file_types). :RenderMarkdown, used by
  -- the <leader>mr keymap, also loads it from other buffers.
  ft = "markdown",
  cmd = "RenderMarkdown",
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
      -- No LaTeX math in the notes, and the latex parser is not installed.
      -- Typst can't stand in: its math syntax differs and render-markdown only
      -- hands formulas to a LaTeX-to-unicode converter (utftex/latex2text).
      latex = { enabled = false },
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
