local M = {}
local utils = require "zeronvim.utils"
local codeium = utils.protected_plugin_call("codeium")
local codeium_api_key = vim.fn.expand("data") .. "/codeium/.api"
local codeium_directory = vim.fn.expand("data") .. "/codeium"
local language_server = codeium_directory .. "language-server-v1.1.32"
local tool_uname_binary = "/usr/bin/uname"
local tool_uuidgen_binary = "/usr/bin/uuidgen"
local tool_curl_binary = "/usr/bin/curl"
local tool_gzip_binary = "/usr/bin/gzip"

M.config = function()
  if codeium then
    return {
      config_path = codeium_api_key,
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
-- TODO: Create a toggle to enable disable AI
-- TODO: Create a statusline indicator combine with https://github.com/zettlrobert/zeronvim/issues/90
-- TODO: Create a funtion to quickly open the codeium log file in a new tab
-- TODO: Ensure _ALL_ keybinds work or are rebound
--[
--Defaults
-- Clear current suggestion     - codeium#Clear()               <C-]>
-- Next suggestion              - codeium#CycleCompletions(1)   <M-]>
-- Previous suggestion          - codeium#CycleCompletions(-1)  <M-[>
-- Insert suggestion            - codeium#Accept()              <Tab>
-- Manually trigger suggestion  - codeium#Complete()            <M-Bslash>
--]]--
