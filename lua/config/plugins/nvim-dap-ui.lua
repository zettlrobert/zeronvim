-- https://github.com/rcarriga/nvim-dap-ui
--
-- Multi-pane debug UI. Auto-opens 3-5 splits arranged around the editor:
-- scopes on the left, breakpoints/stacks/watches on the right, REPL/console
-- on the bottom. More visually rich than nvim-dap-view; more windows to
-- manage. Installed alongside nvim-dap-view for side-by-side evaluation.
--
-- No auto-open on session start — <leader>bu toggles it explicitly.

return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
  },
  event = "VeryLazy",
  opts = {
    icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
    controls = {
      enabled = true,
      element = "repl",
    },
    floating = { border = "rounded" },
    render = {
      max_type_length = nil,
      max_value_lines = 100,
    },
  },
}
