local utils = require "zeronvim.utils"
local nvim_tree = utils.protected_plugin_call("nvim-tree")

-- ----------------------------------------------------------------------------------------------------------------------
if nvim_tree then
  nvim_tree.setup({
    auto_reload_on_write = true,
    create_in_closed_folder = true,
    disable_netrw = true,
    hijack_cursor = true,
    hijack_netrw = true,
    hijack_unnamed_buffer_when_opening = false,
    ignore_buffer_on_setup = false,
    open_on_setup = false,
    open_on_setup_file = false,
    open_on_tab = false,
    ignore_buf_on_tab_change = {},
    sort_by = "case_sensitive",
    root_dirs = {},
    prefer_startup_root = false,
    sync_root_with_cwd = false,
    reload_on_bufenter = false,
    respect_buf_cwd = false,
    on_attach = "disable",
    remove_keymaps = false,
    select_prompts = false,
    view = {
      adaptive_size = true,
      centralize_selection = false,
      width = 35,
      hide_root_folder = false,
      side = "left",
      preserve_window_proportions = true,
      number = false,
      relativenumber = true,
      signcolumn = "yes",
      mappings = {
        custom_only = false,
        list = {
          -- user mappings go here
          { key = { "l", "<CR>", "o" }, action = "edit", mode = "n" },
          { key = "h", action = "close_node"},
          { key = "v", action = "vsplit" },
        },
      },
      float = {
        enable = false,
        quit_on_focus_loss = true,
        open_win_config = {
          relative = "editor",
          border = "rounded",
          width = 30,
          height = 30,
          row = 1,
          col = 1,
        },
      },
    }
  })
end
