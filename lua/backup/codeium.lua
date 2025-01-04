return {
  "Exafunction/codeium.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local utils = require("utils")
    local codeium = require("codeium")
    local config = vim.fn.stdpath("data") .. "/codeium/codeium.json"
    local codeium_binary = vim.fn.stdpath("data") .. "/codeium"
    local language_server = codeium_binary .. "language_server_linux_x64"
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
          language_server = language_server
        }
      }
    })
  end
}
