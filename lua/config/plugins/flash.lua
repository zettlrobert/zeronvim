-- https://github.com/folke/flash.nvim
-- Hint-based motion: press `s`, type the chars you're looking for, hit the
-- label that appears over the match. Also enhances `f`/`t`/`F`/`T` (labels for
-- ambiguous matches) and `/`/`?` (search with live labels). Treesitter mode
-- (`S`) selects whole syntactic nodes.

return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {},
  -- stylua: ignore
  keys = {
    { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
    { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
    { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
    { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
  },
}
