-- https://github.com/igorlfs/nvim-dap-view
--
-- Keyboard-first single-pane debug UI. Tabs between sections (breakpoints,
-- scopes, watches, threads, exceptions, repl) inside one split. No auto-open;
-- toggle explicitly via <leader>bv so it stays out of the way.
--
-- Installed alongside nvim-dap-ui (rcarriga) for side-by-side evaluation.

return {
  "igorlfs/nvim-dap-view",
  dependencies = { "mfussenegger/nvim-dap" },
  event = "VeryLazy",
  opts = {
    winbar = {
      show = true,
      sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "repl", "console" },
      default_section = "scopes",
    },
    windows = {
      -- Absolute row count when > 1, percentage when <= 1.
      size = 12,
      terminal = {
        position = "right",
      },
    },
    auto_toggle = false, -- explicit toggle only via <leader>bv
  },
}
