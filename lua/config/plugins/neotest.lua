-- https://github.com/nvim-neotest/neotest
--
-- Framework for discovering, running, and debugging tests. Language support
-- via adapters:
--   - neotest-vitest for Vitest (TS/JS)
--   - neotest-go for `go test`
--
-- Test debugging integrates with nvim-dap: run a test with `strategy = "dap"`
-- and it starts a DAP session with breakpoints active. See <leader>Td keymap.

return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    -- FixCursorHold.nvim dropped: was required only for Neovim < 0.10 where
    -- CursorHold fired too aggressively. Fixed natively in 0.10+, this
    -- config is on 0.12 — the shim is inert dead weight.
    "nvim-treesitter/nvim-treesitter",
    -- Adapters
    "marilari88/neotest-vitest",
    "nvim-neotest/neotest-go",
    -- Debug integration (already installed by lua/config/plugins/nvim-dap.lua)
    "mfussenegger/nvim-dap",
  },
  event = "VeryLazy",
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-vitest"),
        require("neotest-go")({
          experimental = { test_table = true },
          args = { "-count=1", "-timeout=60s" },
        }),
      },
      status = { virtual_text = true },
      output = { open_on_run = true },
      quickfix = {
        open = function()
          vim.cmd("copen")
        end,
      },
    })
  end,
}
