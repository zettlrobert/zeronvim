-- https://github.com/folke/trouble.nvim
return {
  "folke/trouble.nvim",
  config = function()
    local trouble = require("trouble")

    vim.keymap.set("n", "<leader>tt", function()
      trouble.toggle()
    end, { desc = ":Trouble toggle" })

    -- Diagnostics trouble options
    local workspaceDiagnosticOpts = {
      mode = "diagnostics",
      multiline = true,
      auto_preview = true,
      win = {
        type = "split",
        relative = "editor",
        position = "bottom",
        size = 0.25,
      },
    }

    -- Keymap diagnostics
    vim.keymap.set("n", "<leader>xx", function()
      trouble.toggle(workspaceDiagnosticOpts)
    end, { desc = ":Trouble toggle workspace diagnostics" })

    -- Buffer diagnostics
    local bufferDiagnotsicOpts = {
      mode = "diagnostics",
      multiline = true,
      auto_preview = true,
      win = {
        type = "split",
        relative = "editor",
        position = "bottom",
        size = 0.25,
      },
      filter = { buf = 0 },
    }

    -- Keymap diagnostics buffer
    vim.keymap.set("n", "<leader>xX", function()
      trouble.toggle(bufferDiagnotsicOpts)
    end, {
      desc = ":Trouble toggle buffer diagnostics",
    })

    -- Quickfix trouble options
    local quickfixOpts = {
      mode = "quickfix",
      multiline = true,
      auto_preview = true,
      win = {
        type = "split",
        relative = "editor",
        position = "bottom",
        size = 0.25,
      },
    }

    -- Keymap quickfix list
    vim.keymap.set("n", "<leader>xQ", function()
      trouble.toggle(quickfixOpts)
    end, { desc = ":Trouble toggle quickfix" })

    -- Automatically open trouble with quickfix list
    -- vim.api.nvim_create_autocmd("QuickFixCmdPost", {
    --   callback = function()
    --     trouble.toggle(quickfixOpts)
    --     -- Find solution to close quickfix list
    --   end,
    -- })

    -- Toggle native quickfix list
    vim.keymap.set("n", "<leader>qq", function()
      vim.api.nvim_command("cclose")
    end, { desc = ":Toggle native quickfix list" })

    -- Symbols trouble options
    local symbolOpts = {
      mode = "symbols",
      multiline = true,
      auto_preview = true,
      win = {
        type = "split",
        relative = "editor",
        position = "right",
        size = 0.3,
      },
    }

    -- Keymap trouble toggle symbols
    vim.keymap.set("n", "<leader>ts", function()
      trouble.toggle(symbolOpts)
    end, { desc = ":Trouble toggle symbols" })

    -- LSP defintions/references options
    -- TODO: Make it references
    local lspTroubleOpts = {
      mode = "lsp",
      multiline = true,
      auto_preview = true,
      win = {
        type = "split",
        relative = "editor",
        position = "right",
        size = 0.3,
      },
    }

    -- Keymap trouble toggle lsp defintions and references
    vim.keymap.set("n", "<leader>cl", function()
      trouble.toggle(lspTroubleOpts)
    end, { desc = ":Trouble toggle lsp defintions and references" })

    -- Loclist trouble opts
    local loclistOpts = {
      mode = "quickfix",
      multiline = true,
      auto_preview = true,
      win = {
        type = "split",
        relative = "editor",
        position = "bottom",
        size = 0.25,
      },
    }

    -- Keymap trouble toggle loclist
    vim.keymap.set("n", "<leader>xL", function()
      trouble.toggle(loclistOpts)
    end, { desc = ":Trouble toggle loclist" })

    -- Trouble next item
    vim.keymap.set("n", "<leader>tn", function()
      trouble.next(self, { skip_groups = true, jump = true })
    end, { desc = ":Trouble next item" })

    -- Trouble prev item
    vim.keymap.set("n", "<leader>tp", function()
      trouble.prev(self, { skip_groups = true, jump = true })
    end, { desc = ":Trouble previous item" })
  end,
}
