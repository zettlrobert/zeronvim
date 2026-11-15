--https://github.com/dont-be-evil-company/kulala.nvim
local keymap_desc = require("config.utils.keymap_desc")
local KIND, TOOL = keymap_desc.KIND, keymap_desc.TOOL

-- The keys below only load the plugin; kulala then creates its global
-- <leader>R* keymaps itself (global_keymaps = true).
return {
  "dont-be-evil-company/kulala.nvim",
  keys = {
    { "<leader>Rs", desc = keymap_desc.format(KIND.RUN, TOOL.Kulala, "send request") },
    { "<leader>Ra", desc = keymap_desc.format(KIND.RUN, TOOL.Kulala, "send all requests") },
    { "<leader>Rb", desc = keymap_desc.format(KIND.OPEN, TOOL.Kulala, "scratchpad") },
  },
  ft = { "http", "rest" },
  opts = {
    global_keymaps = true,
    global_keymaps_prefix = "<leader>R",
    kulala_keymaps_prefix = "",
  },
}
