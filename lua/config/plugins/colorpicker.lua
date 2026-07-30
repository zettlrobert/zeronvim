-- https://github.com/uga-rosa/ccc.nvim
return {
  "uga-rosa/ccc.nvim",
  config = function()
    local ccc = require("ccc")

    ccc.setup({
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    })

    -- <leader>t namespace (toggle)
    vim.keymap.set("n", "<leader>tc", function()
      vim.api.nvim_command("CccPick")
    end, { desc = "CccPick: color picker" })
  end,
}
