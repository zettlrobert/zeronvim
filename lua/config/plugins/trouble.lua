-- https://github.com/folke/trouble.nvim
--
-- Trouble is an optional, persistent split-panel viewer over lists
-- (diagnostics, quickfix, symbols, references, todos). It does NOT replace
-- native quickfix navigation — `]q`/`[q` and `<leader>q*` (see keymaps.lua)
-- are the primary workflow. Trouble is the "examine" alternative.
--
-- All trouble bindings live under `<leader>x*` (examine) for consistency.

return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  config = function()
    local trouble = require("trouble")

    -- Shared window opts: bottom split, 25% height
    local bottom_split = {
      type = "split",
      relative = "editor",
      position = "bottom",
      size = 0.25,
    }

    -- Shared window opts: right split, 30% width
    local right_split = {
      type = "split",
      relative = "editor",
      position = "right",
      size = 0.3,
    }

    local function open(opts)
      return function()
        trouble.toggle(opts)
      end
    end

    -- Diagnostics
    vim.keymap.set("n", "<leader>xx", open({
      mode = "diagnostics",
      multiline = true,
      auto_preview = true,
      win = bottom_split,
    }), { desc = "Trouble: workspace diagnostics" })

    vim.keymap.set("n", "<leader>xX", open({
      mode = "diagnostics",
      multiline = true,
      auto_preview = true,
      win = bottom_split,
      filter = { buf = 0 },
    }), { desc = "Trouble: buffer diagnostics" })

    -- Quickfix / loclist views (don't fight native :copen / :lopen)
    vim.keymap.set("n", "<leader>xq", open({
      mode = "quickfix",
      multiline = true,
      auto_preview = true,
      win = bottom_split,
    }), { desc = "Trouble: quickfix panel" })

    vim.keymap.set("n", "<leader>xl", open({
      mode = "loclist",
      multiline = true,
      auto_preview = true,
      win = bottom_split,
    }), { desc = "Trouble: loclist" })

    -- Symbols
    vim.keymap.set("n", "<leader>xs", open({
      mode = "symbols",
      multiline = true,
      auto_preview = true,
      win = right_split,
    }), { desc = "Trouble: symbols" })

    -- LSP definitions / references
    vim.keymap.set("n", "<leader>xr", open({
      mode = "lsp",
      multiline = true,
      auto_preview = true,
      win = right_split,
    }), { desc = "Trouble: lsp definitions and references" })
  end,
}
