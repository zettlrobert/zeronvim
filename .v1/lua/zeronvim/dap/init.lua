local utils = require "zeronvim.utils"
local nvim_dap = utils.protected_plugin_call("dap")
local nvim_dap_ui = require "zeronvim.dap.nvim_dap_ui"
local nvim_dap_virtual_text = require "zeronvim.dap.nvim_dap_virtual_text"
local dap_vscode_js = require "zeronvim.dap.dap-vscode-js"
local dap_chrome_adapater = require "zeronvim.dap.language.chrome-debug-adapter"
local dap_firefox_adapter = require "zeronvim.dap.language.firefox-debug-adapter"

local description = {
  toggle_breakpoint = "Toggle Breakpoint",
  conditional_breakpoint = "Set conditional Breakpoint",
  step_into = "Step into the code and execute the next function, stop at the next line",
  step_over = "Step into the code and execute the next function, stop at the line after the function call",
  continue = "Will resume execution of the program until the next Breakpoint is reaced",
  step_out = "This command will execute the remaining lines of code in the current function and then stop at the line after the function call",
  set_logpoint_message = "Breakpoint that logs a message to the console rather than halting the execution of the program",
  repl_open = "Interactive shell, enter expressions, execute them and see the result",
}

local map = function(lhs, rhs, desc)
  if desc then
    desc = "[  DAP] " .. desc
  end

  vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
end

nvim_dap_ui.setup()
nvim_dap_virtual_text.setup()

if nvim_dap then
  nvim_dap.set_log_level('INFO') -- Helps when configuring DAP, see logs with :DapShowLog

  -- Set conditional Breakpoint
  local conditional_breakpoint = function()
    local prompt = "Breakpoint condition: "
    nvim_dap.set_breakpoint(vim.fn.input(prompt))
  end

  -- Set logpoint message
  local set_logpoint_message = function()
    local prompt = "Log point message: "
    nvim_dap.set_breakpoint(nil, nil, vim.fn.input(prompt))
  end

  -- Keymaps
  map("<leader>b", nvim_dap.toggle_breakpoint, description.toggle_breakpoint)
  map("<leader>B", conditional_breakpoint, description.conditional_breakpoint)
  map("<F2>", nvim_dap.step_into, description.step_into)
  map("<F3>", nvim_dap.step_over, description.step_over)
  map("<F5>", nvim_dap.continue, description.continue)
  map("<F12>", nvim_dap.step_out, description.step_out)
  map("<leader>lp", set_logpoint_message, description.set_logpoint_message)
  map("<leader>dr", nvim_dap.repl.open, description.repl_open)

  -- Open and close dap ui conditionally
  nvim_dap.listeners.after.event_initialized["dapui_config"] = function()
    nvim_dap_ui.instance.open()
  end

  nvim_dap.listeners.before.event_terminated["dapui_config"] = function()
    nvim_dap_ui.instance.close()
  end

  nvim_dap.listeners.before.event_exited["dapui_config"] = function()
    nvim_dap_ui.instance.close()
  end

  dap_vscode_js.setup()
  --[[ dap_chrome_adapater.setup() ]]
  --[[ dap_firefox_adapter.setup() ]]
end
