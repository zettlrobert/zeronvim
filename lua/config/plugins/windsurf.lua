---https://github.com/Exafunction/windsurf.nvim
return {
  "Exafunction/windsurf.nvim",
  -- Loaded only when enabled through config.utils.ai_toggle (<leader>aw or
  -- <leader>aA in config/keymaps.lua), never at startup.
  lazy = true,
  -- dir = "~/repositories/codeium.nvim/",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    -- Imports
    local utils = require("config.utils")
    local codeium = require("codeium")

    -- Paths
    local config = vim.fn.stdpath("data") .. "/codeium/codeium.json"
    local codeium_binary = vim.fn.stdpath("data") .. "/codeium"
    local language_server = codeium_binary .. "language_server_linux_x64"

    -- System binaries
    local uname = utils.get_system_binary("uname")
    local uuidgen = utils.get_system_binary("uuidgen")
    local curl = utils.get_system_binary("curl")
    local gzip = utils.get_system_binary("gzip")

    codeium.setup({
      config = {
        config_path = config,
        bin_path = codeium_binary,
        tools = {
          uname = uname,
          uuidgen = uuidgen,
          curl = curl,
          gzip = gzip,
          language_server = language_server,
        },
      },
      enable_cmp_source = true,
    })

    -- Default off on every load path. ai_toggle queues its enable after this.
    -- Deferred so codeium.setup has finished populating `codeium.s`.
    vim.schedule(function()
      require("config.utils.ai_toggle").disable_windsurf({ silent = true })
    end)
  end,
}
