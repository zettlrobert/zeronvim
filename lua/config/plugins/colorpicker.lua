-- https://github.com/uga-rosa/ccc.nvim
return {
  "uga-rosa/ccc.nvim",
  config = function()
    local ccc = require("ccc")
    local kd = require("config.utils.keymap_desc")

    ccc.setup({
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    })

    -- <leader>t namespace (toggle)
    vim.keymap.set("n", "<leader>tc", function()
      vim.api.nvim_command("CccPick")
    end, { desc = kd.format(kd.KIND.OPEN, kd.TOOL.CccPick, "color picker") })
  end,
}
