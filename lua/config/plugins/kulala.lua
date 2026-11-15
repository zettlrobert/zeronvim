--https://github.com/dont-be-evil-company/kulala.nvim
local kd = require("config.utils.keymap_desc")
local K, T = kd.KIND, kd.TOOL

-- The keys below only load the plugin; kulala then creates its global
-- <leader>R* keymaps itself (global_keymaps = true).
return {
  "dont-be-evil-company/kulala.nvim",
  keys = {
    { "<leader>Rs", desc = kd.format(K.RUN, T.Kulala, "send request") },
    { "<leader>Ra", desc = kd.format(K.RUN, T.Kulala, "send all requests") },
    { "<leader>Rb", desc = kd.format(K.OPEN, T.Kulala, "scratchpad") },
  },
  ft = { "http", "rest" },
  opts = {
    global_keymaps = true,
    global_keymaps_prefix = "<leader>R",
    kulala_keymaps_prefix = "",
  },
}
