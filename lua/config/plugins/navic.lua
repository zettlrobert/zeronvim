--https://github.com/SmiteshP/nvim-navic
return {
  {
    "SmiteshP/nvim-navic",
    -- Attached from the LspAttach handler in lua/config/lsp/init.lua, whose
    -- require() is what loads this plugin. auto_attach is off: when the plugin
    -- loads on the first LspAttach, its own handler misses that first buffer.
    lazy = true,
    config = function()
      local navic = require("nvim-navic")

      navic.setup({
        lsp = {
          auto_attach = false,
        },
        highlight = true,
      })
    end,
  },
}
