require("config.utils.source")
local buffer_paths = require("config.utils.get_buffer_paths")

local M = {
  get_current_realtive_buffer_path = buffer_paths.get_current_relative_buffer_path,
  get_current_absolute_buffer_path = buffer_paths.get_current_absolute_buffer_path,
  get_current_absolute_buffer_path_with_cwd = buffer_paths.get_current_absolute_buffer_path_with_cwd,
  get_current_working_directory = require("config.utils.get_current_working_directory").get_current_working_directory,
  get_project_name = require("config.utils.get_project_name").get_project_name,
  get_system_binary = require("config.utils.get_system_binary").get_system_binary,
  get_user = require("config.utils.get_user").get_user,
  protected_plugin_call = require("config.utils.protected_plugin_call").protected_plugin_call,
  is_presentation_markdown = require("config.utils.is_presentation_markdown").is_presentation_markdown,
  patch_colorscheme = require("config.utils.patch_colorscheme"),
  toggle_lsp_server = require("config.utils.toggle_lsp_server").toggle_lsp_server,
  toggle_spell = require("config.utils.toggle_spell").toggle_spell,
  lsp_actions = require("config.utils.lsp_actions").lsp_actions,
  lsp_servers = require("config.utils.lsp_servers").lsp_servers,
  keymap_desc = require("config.utils.keymap_desc"),
}

-- Filetype detection for `.env*` files → treat as shell. `vim.filetype.add`
-- runs once at file open (not on every BufEnter) and doesn't fire notifications.
-- Covers `.env` itself and any dot-suffixed variant like `.env.local`,
-- `.env.production`, `.env.test`.
--
-- `filename` handles the exact `.env` case and beats Neovim's built-in
-- `env` detection out of the box. `pattern` for the dot-suffixed variants
-- needs an explicit `priority` bump to win over the built-in — the shell
-- filetype gives useful highlighting for the `KEY=value` syntax.
vim.filetype.add({
  filename = {
    [".env"] = "sh",
  },
  pattern = {
    ["%.env%..*"] = { "sh", { priority = 100 } },
  },
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

    -- opt_local scopes to the current buffer/window — using `vim.opt` here
    -- leaked the setting globally and left conceallevel = 1 in every buffer
    -- opened afterwards until nvim restarted.
    vim.opt_local.conceallevel = 1
  end,
})

return M
