-- https://github.com/numToStr/Comment.nvim
-- Context-aware commentstring is handled natively by Neovim 0.10+ via
-- :h vim.treesitter.commentstring, so the deprecated nvim-ts-context-commentstring
-- plugin is no longer required.
--
-- Kept over the native gc/gcc (0.10+) for what Neovim lacks: block comments
-- (gb/gbc), the gco/gcO/gcA extras, and nvim-navbuddy's comment action.
-- Loaded on the first comment keypress; navbuddy also pulls it in on LspAttach.

return {
  "numToStr/Comment.nvim",
  keys = {
    { "gc", mode = { "n", "x" }, desc = "Comment toggle linewise" },
    { "gb", mode = { "n", "x" }, desc = "Comment toggle blockwise" },
  },
  config = function()
    require("Comment").setup({
      padding = true,
      sticky = true,
      mappings = {
        basic = true,
        extra = true,
      },
      toggler = {
        block = "gbc",
        line = "gcc",
      },
      extra = {
        above = "gcO",
        below = "gco",
        eol = "gcA",
      },
      opleader = {
        block = "gb",
        line = "gc",
      },
    })
  end,
}
