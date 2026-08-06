--[[
Python launch configs via debugpy. Adapter registration is handled by
mason-nvim-dap.lua (debugpy is Mason-installed and mason-nvim-dap registers
it under `dap.adapters.python`).

Interpreter selection: prefers an active venv (VIRTUAL_ENV / CONDA_PREFIX)
or a common venv folder in cwd (`venv`, `.venv`, `env`). Falls back to
system `python3`. This ensures the debugger runs in the project's env, not
Mason's isolated debugpy env — critical for imports to resolve.

Configs cover the everyday cases: launch the file, launch as a module,
debug pytest at cursor or over the whole file, attach to a running process.
]]

local dap = require("dap")

---Return the Python interpreter that should execute the debugged code.
---@return string
local function get_python_path()
  local venv = os.getenv("VIRTUAL_ENV")
  if venv then
    return venv .. "/bin/python"
  end
  local conda = os.getenv("CONDA_PREFIX")
  if conda then
    return conda .. "/bin/python"
  end
  local cwd = vim.fn.getcwd()
  for _, name in ipairs({ "venv", ".venv", "env" }) do
    local candidate = cwd .. "/" .. name .. "/bin/python"
    if vim.fn.executable(candidate) == 1 then
      return candidate
    end
  end
  return vim.fn.exepath("python3") ~= "" and "python3" or "python"
end

dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch current file",
    program = "${file}",
    pythonPath = get_python_path,
    console = "integratedTerminal",
    justMyCode = true,
  },
  {
    type = "python",
    request = "launch",
    name = "Launch current file (with args)",
    program = "${file}",
    args = function()
      local input = vim.fn.input("Args: ")
      return vim.split(input, " +")
    end,
    pythonPath = get_python_path,
    console = "integratedTerminal",
    justMyCode = true,
  },
  {
    type = "python",
    request = "launch",
    name = "Launch module (python -m ...)",
    module = function()
      return vim.fn.input("Module: ")
    end,
    pythonPath = get_python_path,
    console = "integratedTerminal",
    justMyCode = true,
  },
  {
    type = "python",
    request = "launch",
    name = "Debug pytest (current file)",
    module = "pytest",
    args = { "${file}", "-vv", "-s" },
    pythonPath = get_python_path,
    console = "integratedTerminal",
    justMyCode = false, -- pytest often imports helper libs worth stepping into
  },
  {
    type = "python",
    request = "launch",
    name = "Debug pytest at cursor",
    module = "pytest",
    args = { "${file}::${selectedText}", "-vv", "-s" },
    pythonPath = get_python_path,
    console = "integratedTerminal",
    justMyCode = false,
  },
  {
    type = "python",
    request = "attach",
    name = "Attach to running process",
    processId = require("dap.utils").pick_process,
    pythonPath = get_python_path,
    justMyCode = true,
  },
}
