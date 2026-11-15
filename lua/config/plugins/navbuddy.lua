-- https://github.com/SmiteshP/nvim-navbuddy
local kd = require("config.utils.keymap_desc")

return {
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "MunifTanjim/nui.nvim",
      "numToStr/Comment.nvim",
    },
    -- Attached from lua/config/lsp/init.lua like nvim-navic. With auto_attach
    -- on, a late load walks existing clients through the deprecated
    -- vim.lsp.get_buffers_by_client_id.
    keys = {
      -- <leader>s namespace (symbols) — room for future <leader>sd/sw
      {
        "<leader>ss",
        function()
          require("nvim-navbuddy").open()
        end,
        desc = kd.format(kd.KIND.OPEN, kd.TOOL.Navbuddy, "symbol tree"),
      },
    },
    opts = {
      lsp = {
        auto_attach = false,
      },
    },
  },
}
