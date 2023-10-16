local M = {}
local utils = require "zeronvim.utils"
local codeium = utils.protected_plugin_call("codeium")
local codeium_config = vim.fn.stdpath("data") .. "/codeium/codeium.json"
local codeium_directory = vim.fn.stdpath("data") .. "/codeium"
local language_server = codeium_directory .. "language_server_linux_x64"

local tool_uname_binary = utils.get_system_binary("uname")
local tool_uuidgen_binary = utils.get_system_binary("uuidgen")
local tool_curl_binary = utils.get_system_binary("curl")
local tool_gzip_binary = utils.get_system_binary("gzip")

-- Autocommand to disable codeium by default on neovim startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    utils.toggle_codeium.disable()
  end
}
)

M.config = function()
  if codeium then
    return {
      config_path = codeium_config,
      bin_path = codeium_directory,
      tools = {
        uname = tool_uname_binary,
        uuidgen = tool_uuidgen_binary,
        curl = tool_curl_binary,
        gzip = tool_gzip_binary,
        language_server = language_server,
      }
    }
  else
    vim.notify("codeium ai could not connect to servers")
  end
end

return M

-- TODO: Download Script for offical language server https://github.com/Exafunction/codeium/releases/tag/language-server-v1.1.32
-- create utility that checks if server binary is avialable and downloads it if not

-- TODO: Create a statusline indicator combine with https://github.com/zettlrobert/zeronvim/issues/90

-- TODO: Ensure _ALL_ keybinds work or are rebound

-- TODO: Unfortunately the plugin does not respect the global codeium_enabled variable

--[
--Defaults
-- Clear current suggestion     - codeium#Clear()               <C-]>
-- Next suggestion              - codeium#CycleCompletions(1)   <M-]>
-- Previous suggestion          - codeium#CycleCompletions(-1)  <M-[>
-- Insert suggestion            - codeium#Accept()              <Tab>
-- Manually trigger suggestion  - codeium#Complete()            <M-Bslash>
--]]--
