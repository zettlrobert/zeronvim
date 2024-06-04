-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#go-using-delve-directly
return {
  "leoluz/nvim-dap-go",
  config = function()
    local dap_go = require("dap-go")

    dap_go.setup({})
  end,
}

-- Manual Setup Go
-- dap.adapters.delve = {
--   type = "server",
--   port = "${port}",
--   executable = {
--     command = "dlv",
--     args = { "dap", "-l", "127.0.0.1:${port}" },
--   },
-- }
--
-- -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
-- dap.configurations.go = {
--   {
--     type = "delve",
--     name = "Debug",
--     request = "launch",
--     program = "${file}",
--   },
--   {
--     type = "delve",
--     name = "Debug test", -- configuration for debugging test files
--     request = "launch",
--     mode = "test",
--     program = "${file}",
--   },
--   -- works with go.mod packages and sub packages
--   {
--     type = "delve",
--     name = "Debug test (go.mod)",
--     request = "launch",
--     mode = "test",
--     program = "./${relativeFileDirname}",
--   },
-- }