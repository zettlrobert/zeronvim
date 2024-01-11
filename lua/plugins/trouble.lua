return {
  "folke/trouble.nvim",
  config = function()
    local keymaps = vim.keymap.set
    local trouble = require("trouble")

    trouble.setup({})

    keymaps('n', "<leader>tt", function()
        trouble.toggle()
      end,
      { desc = "Toggle trouble" }
    )

    keymaps('n', "<leader>td", function()
        trouble.toggle({ mode = "document_diagnostics" })
      end,
      { desc = "Toggle trouble document diagnostics" }
    )

    keymaps('n', "<leader>tw", function()
        trouble.toggle({ mode = "workspace_diagnostics" })
      end,
      { desc = "Toggle trouble workspace diagnostics" }
    )

    keymaps('n', "<leader>tq", function()
        trouble.toggle({ mode = "quickfix" })
      end,
      { desc = "Toggle trouble quickfix" }
    )

    keymaps('n', "<leader>tl", function()
        trouble.toggle({ mode = "lsp_references" })
      end,
      { desc = "Toggle trouble lsp references" }
    )

    keymaps('n', "<leader>todo", function()
        trouble.toggle({ mode = "todo" })
      end,
      { desc = "Toggle trouble todos" }
    )

    keymaps('n', '<leader>tn', function()
        trouble.next({ skip_groups = true, jump = true })
      end,
      { desc = "Trouble next item" }
    )

    keymaps('n', '<leader>tp', function()
        trouble.prev({ skip_groups = true, jump = true })
      end,
      { desc = "Trouble previous item" }
    )
  end
}
