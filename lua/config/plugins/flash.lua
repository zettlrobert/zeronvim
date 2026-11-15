-- https://github.com/folke/flash.nvim
-- Hint-based motion: press `s`, type the chars you're looking for, hit the
-- label that appears over the match. Also enhances `f`/`t`/`F`/`T` (labels for
-- ambiguous matches) and `/`/`?` (search with live labels). Treesitter mode
-- (`S`) selects whole syntactic nodes.

-- Keymaps: config/keymaps.lua.

return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {},
}
