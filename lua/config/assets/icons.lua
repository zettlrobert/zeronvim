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

M.WindowTitle = {
  project = " ",
  file = " ",
}
return M
