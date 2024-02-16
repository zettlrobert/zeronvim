return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
  },
  config = function()
    local keymaps = vim.keymap.set
    local dap = require("dap")
    local dapui = require("dapui")

    -- Setup the plugins
    dapui.setup()

    -- Automatically open and close debuggin windows wen dap attaches
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    -- Keymaps TODO: look up in `dap-api`
    keymaps("n", "<F5>", dap.continue, { desc = "DAP: Continue" })
    keymaps("n", "<F10>", dap.step_over, { desc = "DAP: Step Over" })
    keymaps("n", "<F11>", dap.step_into, { desc = "DAP: Step Into" })
    keymaps("n", "<F12>", dap.step_out, { desc = "DAP: Step Out" })
    keymaps("n", "<Leader>b", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
    keymaps("n", "<Leader>B", dap.set_breakpoint, { desc = "DAP: Set Breakpoint" })
    keymaps("n", "<Leader>dr", dap.repl.open, { desc = "DAP: Open REPL" })
    keymaps("n", "<Leader>dl", dap.run_last, { desc = "DAP: Run Last" })
    --keymaps(
    --  "n",
    --  "<Leader>lp",
    --  dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")),
    --  { desc = "DAP: Set Log Point" }
    --)
    --keymaps({ "n", "v" }, "<Leader>dh", dapui.hover, { desc = "DAP: Hover" })
    --keymaps({ "n", "v" }, "<Leader>dp", dapui.preview, { desc = "DAP: Preview" })
    --keymaps("n", "<Leader>df", function()
    --  local widgets = require("dap.ui.widgets")
    --  widgets.centered_float(widgets.frames)
    --end, { desc = "DAP: Show Frames" })
    -- keymaps("n", "<Leader>ds", function()
    --   local widgets = require("dap.ui.widgets")
    --   widgets.centered_float(widgets.scopes)
    -- end, { desc = "DAP: Show Scopes" })
  end,
}
