return {
  "trunk-io/neovim-trunk",
  lazy = false,
  -- optionally pin the version
  -- tag = "v0.1.1",
  -- these are optional config arguments (defaults shown)
  config = function()
    local utils = require("config.utils")
    local binary_status_ok, binary_path = pcall(utils.get_system_binary, "trunk")

    -- Check if trunk is in the repo via the `.trunk`
    local function is_trunk_repository()
      local cwd = vim.fn.getcwd()
      local trunk_path = cwd .. "/.trunk"

      local file = io.open(trunk_path, "r")
      if file ~= nil then
        io.close(file)
        return true
      else
        return false
      end
    end

    -- vim.notify("is_trunk_repository(): " .. tostring(is_trunk_repository()))

    if not binary_status_ok then
      vim.notify("Trunk binary not found, please install Trunk from https://trunk.io", vim.log.levels.ERROR)
      return
    else
      if not is_trunk_repository() then
        -- vim.notify("Current repository is not a Trunk repository.", )
        return
      else
        return {
          trunkPath = binary_path,
          -- lspArgs = {},
          -- formatOnSave = true,
          -- formatOnSaveTimeout = 10, -- seconds
          -- logLevel = "info"
        }
      end
    end
  end,
  main = "trunk",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
}
