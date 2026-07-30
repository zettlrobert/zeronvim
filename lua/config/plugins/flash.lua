-- https://github.com/folke/flash.nvim
-- Hint-based motion: press `s`, type the chars you're looking for, hit the
-- label that appears over the match. Also enhances `f`/`t`/`F`/`T` (labels for
-- ambiguous matches) and `/`/`?` (search with live labels). Treesitter mode
-- (`S`) selects whole syntactic nodes.

local kd = require("config.utils.keymap_desc")
local K, T = kd.KIND, kd.TOOL

return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {},
  -- stylua: ignore
  keys = {
    { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = kd.format(K.JUMP, T.Flash, "hint-based") },
    { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = kd.format(K.JUMP, T.Flash, "treesitter node") },
    { "r",     mode = "o",               function() require("flash").remote() end,            desc = kd.format(K.JUMP, T.Flash, "remote (operator)") },
    { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = kd.format(K.SEARCH, T.Flash, "treesitter") },
    { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = kd.format(K.TOGGLE, T.Flash, "in cmdline search") },
  },
}
