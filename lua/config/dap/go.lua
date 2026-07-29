--[[
Go launch configs via delve. Adapter registration is handled by
mason-nvim-dap.lua (delve is Mason-installed).

Three canonical modes:
  - debug         run the current package/file
  - debug_test    run the test at cursor
  - attach        attach to a running process
]]

local dap = require("dap")

dap.configurations.go = {
  {
    type = "delve",
    name = "Debug current file",
    request = "launch",
    program = "${file}",
  },
  {
    type = "delve",
    name = "Debug package",
    request = "launch",
    program = "./${relativeFileDirname}",
  },
  {
    type = "delve",
    name = "Debug test (at cursor)",
    request = "launch",
    mode = "test",
    program = "${file}",
  },
  {
    type = "delve",
    name = "Debug test package (all)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}",
  },
  {
    type = "delve",
    name = "Attach to process",
    request = "attach",
    mode = "local",
    processId = require("dap.utils").pick_process,
  },
}
