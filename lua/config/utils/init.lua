require("config.utils.source")
local buffer_paths = require("config.utils.get_buffer_paths")

local M = {
  get_current_realtive_buffer_path = buffer_paths.get_current_relative_buffer_path,
  get_current_absolute_buffer_path = buffer_paths.get_current_absolute_buffer_path,
  get_current_working_directory = require("config.utils.get_current_working_directory").get_current_working_directory,
  get_project_name = require("config.utils.get_project_name").get_project_name,
  get_system_binary = require("config.utils.get_system_binary").get_system_binary,
  get_user = require("config.utils.get_user").get_user,
  protected_plugin_call = require("config.utils.protected_plugin_call").protected_plugin_call,
  is_presentation_markdown = require("config.utils.is_presentation_markdown").is_presentation_markdown,
  patch_colorscheme = require("config.utils.patch_colorscheme"),
}

-- TODO: Move to autocommands
--- Setting filetype to sh for .env* files
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = ".env*",
  callback = function()
    vim.notify("Setting filetype to sh for .env* file", vim.log.levels.INFO, { title = "Filetype Set" })

    vim.bo.filetype = "sh"
  end,
})

---TODO: Use utility function
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.presentation.md",
  callback = function()
    vim.notify(
      "Setting conceallevel to 1 for presentation markdown",
      vim.log.levels.INFO,
      { title = "Conceallevel Set" }
    )

    vim.opt.conceallevel = 1
  end,
})

return M
