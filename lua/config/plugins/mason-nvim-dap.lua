-- https://github.com/jay-babu/mason-nvim-dap.nvim
--
-- Bridges Mason-installed adapter binaries (see lua/config/lsp/tools.lua)
-- to nvim-dap by auto-registering them in dap.adapters. Without this, each
-- adapter would need manual `dap.adapters.<name> = { ... }` boilerplate.
--
-- ensure_installed is intentionally left empty because mason-tool-installer
-- (see lua/config/plugins/mason.lua) already installs `delve` and
-- `js-debug-adapter`. We just want mason-nvim-dap for the auto-registration.

return {
  "jay-babu/mason-nvim-dap.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "mfussenegger/nvim-dap",
  },
  event = "VeryLazy",
  opts = {
    automatic_installation = false, -- adapters install via mason-tool-installer
    handlers = {}, -- default handler registers all adapters
  },
}
