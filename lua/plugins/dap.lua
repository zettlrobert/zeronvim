-- TODO:
-- [ ] add close toggle for dapui
-- [ ] dap telescope -- how to use appropriately
-- [ ] dapui - setup (icons, pretty, etc)
-- [ ] jest setup dap-vscode-js

-- Every language needs it's adapter and own configuration
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      local keymaps = vim.keymap.set
      local dap = require("dap")
      local dapui = require("dapui")
      local nvim_dap_virtual_text = require("nvim-dap-virtual-text")

      -- There are useful extensions for dap
      -- https://github.com/mfussenegger/nvim-dap/wiki/Extensions

      -- Setup the plugins
      -- dap ui is built on the idea of 'elements'
      -- elements are windows which provide different features
      -- elements are grouped into layouts
      -- there can be any number of layouts containing whichever elements configured
      -- each element has a set of mappings for element-specific possible actions
      -- edit: e
      -- expand: <CR> or left click
      -- open: o
      -- remove: d
      -- repl: r
      -- toggle: t
      dapui.setup()

      -- Virtual Text Support for nvim-dap via nvim-treesitter
      nvim_dap_virtual_text.setup({})

      -- Toggle nvim-dap-ui
      keymaps("n", "<leader>du", dapui.toggle, { desc = "DAP: Toggle UI" })
      -- Toggle hover doc for expression or selection under cursor
      keymaps({ "n", "v" }, "<leader>de", function()
        dapui.eval()
      end, { desc = "DAP: Eval" })

      -- Automatically open and close debugging windows wen dap attaches
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

      --
      keymaps("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
      keymaps("n", "<leader>dc", dap.continue, { desc = "DAP: Continue" })
      keymaps("n", "<leader>dO", dap.step_over, { desc = "DAP: Step Over" })
      keymaps("n", "<leader>di", dap.step_into, { desc = "DAP: Step Into" })
      keymaps("n", "<leader>do", dap.step_out, { desc = "DAP: Step Out" })
      keymaps("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "DAP: Set Breakpoint" })
      keymaps("n", "<leader>dl", dap.run_last, { desc = "DAP: Run Last" })
      keymaps("n", "<leader>dr", dap.repl.toggle, { desc = "DAP: Toggle REPL" })
      -- keymaps("n", "<leader>da", function() dap.continue({ before = get_args }) end, { desc= "DAP: Run with Args" })
      keymaps("n", "<leader>dC", function()
        dap.run_to_cursor()
      end, { desc = "DAP: Run to Cursor" })
      keymaps("n", "<leader>dg", dap.goto_, { desc = "DAP: Go to Line" })
      keymaps("n", "<leader>dj", dap.down, { desc = "DAP: Down" })
      keymaps("n", "<leader>dk", dap.up, { desc = "DAP: Up" })
      keymaps("n", "<leader>dp", dap.pause, { desc = "DAP: Pause" })
      keymaps("n", "<leader>ds", function()
        dap.session()
      end, { desc = "DAP: Session" })
      keymaps("n", "<leader>dt", dap.terminate, { desc = "DAP: Terminate" })
      keymaps("n", "<leader>dw", function()
        dap.ui.widgets.hover()
      end, { desc = "DAP: Widget Hover" })
    end,
  },
}
