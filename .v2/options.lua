local options = {
  -- automatically indent line with indentation of previous line
  autoindent = true,
  -- automatically read file when changed outside of vim
  autoread = true,
  -- keep backup file after overwriting a file
  backup = false,
  -- wrapped line repeats indent
  breakindent = true,
  -- Number of screen lines to use for the command-line, cmdheight - Number of screen lines to use for the command-line, space to display messages space to display messages
  cmdheight = 2,
  -- comma-separated list of options for Insert mode completion
  completeopt = { "menuone", "noselect", "preview" },
  -- determine how text with the 'conceal' syntax attribute :syn-conceal is shown
  conceallevel = 2,
  -- operations that would normally fail, because of unsaved changes raise a dialog,  asking if we want to save
  confirm = true,
  -- highlight the text line of the cursor with cursorline hl-CursorLine
  cursorline = true,
  -- settings for how cursorline is displayed
  cursorlineopt = { "screenline", "number" },
  -- use the appropriate number of spaces to insert a <Tab>
  expandtab = true,
  -- file-content encoding for the current buffer
  fileencoding = "utf-8",
  -- when there is a previous search pattern highlight all its matches
  hlsearch = true,
  -- When off a buffer is unloaded (including loss of undo information)
  hidden = true,
  -- ignore case in search patterns
  ignorecase = true,
  -- influences when the last window will have a status line
  laststatus = 3,
  -- enable mouse support
  mouse = 'a',
  -- print the line number in front of each line.
  number = true,
  -- number of columns to use for the line number
  numberwidth = 5,
  -- maximum number of items to show in popup menu
  pumheight = 10,
  -- show the line number relative to the line with the cursor
  relativenumber = true,
  -- minimal number of screen lines to keep above and below the cursor
  scrolloff = 16,
  -- number of spaces to use for each step of (auto)indent
  shiftwidth = 2,
  -- the value of this option specifies when the line with tab page labels will be displayed
  showtabline = 2,
  -- the minimal number of screen columns to keep to the left and to the right of the cursor if nowrap is set
  sidescrolloff = 60,
  -- when and how to draw the signcolumn
  signcolumn = "yes",
  -- override the ignorecase option if the search patter contains upper case characters
  smartcase = true,
  -- do smart autoindenting when starting a new line
  smartindent = true,
  -- when on, splitting a window will put the new window below the current
  splitbelow = true,
  -- when on, splitting a window will put the new window to the right of the current one
  splitright = true,
  -- use a swapfile for the buffer
  swapfile = false,
  -- number of spaces that a tab in the file counts for
  tabstop = 4,
  -- enables 24-bit RGB color in the TUI
  termguicolors = true,
  -- the name of the undo file that would be used for a file with {name} when writing
  undofile = true,
  -- updatetime - if this many millisecond's nothing is typed the swap file will be written to disk
  updatetime = 250,
  -- this option changes how text is displayed
  wrap = false,
  -- languages we do spellchecking for, if we enable it
  spelllang = { "en_us", "de_de" },
  -- the result is a number, which is the foldlevel of line
  foldlevel = 20,
  -- foldexpr gives t he foldlevel of a line
  foldmethod = "expr",
  -- expression, used for when foldmethod is expr in this case treesitter
  foldexpr = "nvim_treesitter#foldexpr()",
  -- when on title of the window will be set to titlestring
  title = true,
}

for option, setting in pairs(options) do
  vim.opt[option] = setting
end
