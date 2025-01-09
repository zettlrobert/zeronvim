require("config.utils.source")

local M = {
  get_current_working_directory = require("config.utils.get_current_working_directory").get_current_working_directory,
  get_project_name = require("config.utils.get_project_name").get_project_name,
  get_system_binary = require("config.utils.get_system_binary").get_system_binary,
  get_user = require("config.utils.get_user").get_user,
  protected_plugin_call = require("config.utils.protected_plugin_call").protected_plugin_call,
}

return M
