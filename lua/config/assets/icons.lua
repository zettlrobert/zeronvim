local M = {}

M.Dashboard = {
  NEW_FILE = " ",
  FIND_FILE = " ",
  LIVE_GREP = "󰱼 ",
  CLOSE = "󱎘 ",
}

M.Diagnostics = {
  ERROR = "",
  WARN = "",
  HINT = "",
  INFO = "",
}

M.TodoComments = {
  Bug = " ",
  Info = " ",
  Hack = " ",
  Warn = " ",
  Perf = "",
  Note = " ",
  Test = "⏲ ",
}

M.Tree = {
  default = "",
  symlink = "",
  bookmark = "",
  symlink_arrow = " ➛ ",
  Folder = {
    ARROW_CLOSED = "",
    ARROW_OPEN = "",
    DEFAULT = "",
    OPEN = "",
    EMPTY = "",
    EMPTY_OPEN = "",
    SYMLINK = "",
    SYMLINK_OPEN = "",
  },
  Git = {
    unstaged = "✗",
    staged = "✓",
    unmerged = "",
    renamed = "➜",
    untracked = "★",
    deleted = "",
    ignored = "◌",
  },
}

M.Mason = {
  package_installed = "✓",
  package_pending = "➜",
  package_uninstalled = "✗",
}

-- AI completion providers: statusline (utils/ai_toggle), blink kind icons
-- (plugins/completion.lua) and mini.icons lsp entries (plugins/mini-icons.lua).
M.AI = {
  Copilot = "",
  -- nf-fa-microchip; older codepoint than nf-md-brain, works on more fonts.
  Minuet = "",
}

M.WindowTitle = {
  project = " ",
  file = " ",
}
return M
