-- https://github.com/uga-rosa/ccc.nvim
return {
  "uga-rosa/ccc.nvim",
  config = function()
    local ccc = require("ccc")

    ccc.setup({
      highlighter = {
        auto_enable = true,
        lsp = true,
      }
    })

    vim.keymap.set(
      "n", "<leader>ccp",
      function()
        vim.api.nvim_command("CccPick")
      end,
      { desc = "Toggle ColorPicker" }
    )
  end
}
