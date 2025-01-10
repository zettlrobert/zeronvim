-- local icons = require("assets.icons")

-- Global Diagnostics Keybinds
vim.keymap.set("n", "<space>d", vim.diagnostic.open_float, { desc = "Diagnostics open floating window" })
vim.keymap.set("n", "[d", vim.diagnostic.get_next, { desc = "Diagnostics get_next" })
vim.keymap.set("n", "]d", vim.diagnostic.get_prev, { desc = "Diagnostics get_prev" })
vim.keymap.set("n", "<space>lq", vim.diagnostic.setloclist, { desc = "Diagnostics set loclist" })

-- Diagnostics Configuration
local diagnostic_config = {
  virtual_text = false,
  signs = {
    text = {
      -- [vim.diagnostic.severity.ERROR] = icons.diagnostics.ERROR,
      -- [vim.diagnostic.severity.WARN] = icons.diagnostics.WARN,
      -- [vim.diagnostic.severity.INFO] = icons.diagnostics.INFO,
      -- [vim.diagnostic.severity.HINT] = icons.diagnostics.HINT,
    },
  },
  source = true,
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    border = "rounded",
    source = "always",
  },
}

vim.diagnostic.config(diagnostic_config)
