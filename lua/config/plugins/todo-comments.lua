-- https://github.com/folke/todo-comments.nvim
return {
  "folke/todo-comments.nvim",
  -- Loads with the first real file buffer. The <leader>xt and ]t/[t keymaps
  -- live in config/keymaps.lua.
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  cmd = { "TodoTrouble", "TodoTelescope", "TodoQuickFix", "TodoLocList" },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = function()
    local icons = require("config.assets.icons")

    return {
      keywords = {
        FIX = {
          icon = icons.TodoComments.Bug,
          color = "error",
          alt = {
            "FIXME",
            "BUG",
            "FIXIT",
            "ISSUE",
          },
        },
        TODO = {
          icon = icons.TodoComments.Info,
          color = "info",
          alt = {
            "TASK",
          },
        },
        HACK = {
          icon = icons.TodoComments.Hack,
          color = "warning",
        },
        WARN = {
          icon = icons.TodoComments.Warn,
          color = "warning",
          alt = {
            "WARNING",
            "XXX",
          },
        },
        PERF = {
          icon = icons.TodoComments.Perf,
          alt = {
            "OPTIM",
            "PERFORMANCE",
            "OPTIMIZE",
          },
        },
        NOTE = {
          icon = icons.TodoComments.Note,
          color = "hint",
          alt = {
            "INFO",
          },
        },
        TEST = {
          icon = icons.TodoComments.Test,
          color = "test",
          alt = {
            "TESTING",
            "PASSED",
            "FAILED",
          },
        },
      },
    }
  end,
}
