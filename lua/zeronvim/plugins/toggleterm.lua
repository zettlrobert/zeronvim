local utils = require "zeronvim.utils"
local toggleterm = utils.protected_plugin_call("toggleterm")

if toggleterm then
  toggleterm.setup({
    size = 20,
    open_mapping = [[<c-/>]],
    hide_numbers = true,
    shade_terminals = true,
    shade_filetypes = {},
    shading_factor = 1,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "float",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = "curved",
      winblend = 3,
      highlights = {
        border = "Normal",
        background = "Normal"
      },
    },
  })

end
