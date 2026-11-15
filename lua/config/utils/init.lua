--[[
Barrel for the helpers in lua/config/utils/. Only functions and tables, no side
effects: each module is required on first access, so `require("config.utils")`
costs nothing until a helper is used.

Modules with side effects (commands, autocmds, keymaps) are required explicitly
from init.lua instead: source, lint_versions, patch_colorscheme.
]]

---Barrel key -> { module, field }. Without a field the whole module is returned.
---@type table<string, { [1]: string, [2]: string? }>
local exports = {
  get_current_realtive_buffer_path = { "get_buffer_paths", "get_current_relative_buffer_path" },
  get_current_absolute_buffer_path = { "get_buffer_paths", "get_current_absolute_buffer_path" },
  get_current_absolute_buffer_path_with_cwd = { "get_buffer_paths", "get_current_absolute_buffer_path_with_cwd" },
  get_current_working_directory = { "get_current_working_directory", "get_current_working_directory" },
  get_project_name = { "get_project_name", "get_project_name" },
  get_system_binary = { "get_system_binary", "get_system_binary" },
  get_user = { "get_user", "get_user" },
  protected_plugin_call = { "protected_plugin_call", "protected_plugin_call" },
  is_presentation_markdown = { "is_presentation_markdown", "is_presentation_markdown" },
  toggle_lsp_server = { "toggle_lsp_server", "toggle_lsp_server" },
  toggle_spell = { "toggle_spell", "toggle_spell" },
  lsp_actions = { "lsp_actions", "lsp_actions" },
  lsp_servers = { "lsp_servers", "lsp_servers" },
  keymap_desc = { "keymap_desc" },
  lint_versions = { "lint_versions" },
}

return setmetatable({}, {
  __index = function(t, key)
    local export = exports[key]
    if not export then
      error(("config.utils has no export %q"):format(tostring(key)), 2)
    end
    local mod = require("config.utils." .. export[1])
    local value = export[2] and mod[export[2]] or mod
    rawset(t, key, value)
    return value
  end,
})
