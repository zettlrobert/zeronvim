-- https://github.com/numToStr/Comment.nvim
-- Context-aware commentstring is handled natively by Neovim 0.10+ via
-- :h vim.treesitter.commentstring, so the deprecated nvim-ts-context-commentstring
-- plugin is no longer required.

return {
  "numToStr/Comment.nvim",
  config = function()
    require("Comment").setup({
      padding = true,
      sticky = true,
      ignore = "nil",
      mappings = {
        basic = true,
        extra = true,
      },
      toggler = {
        block = "gbc",
        line = "gcc",
      },
      post_hook = function()
        return
      end,
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
