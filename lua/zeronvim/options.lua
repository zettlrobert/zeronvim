-- Imports
local get_title_string = require "zeronvim.utils.get_titlestring"

-- Path to personal dictionlary - checking with ltex-ls
local spellfilePath = vim.fn.stdpath "config" .. "/dictionary/utf-8.add"

-- The computated titlestring to assign to the option
local custom_titlestring = get_title_string.get_title_string()
--[[ local custom_titlestring = "Project:" ]]

-- Neovim Options
local options = {
  autoindent = true, -- automatically indent line with indentation of previous line
  autoread = true, -- automatically read file when changed outside of vim
  backup = false, -- keep backup file after overwriting a file
  breakindent = true, -- wrapped line repeats indent
  cmdheight = 2, -- Number of screen lines to use for the command-line, cmdheight - Number of screen lines to use for the command-line, space to display messages space to display messages
  colorcolumn = "125", -- comma-separated list of screen columns
  completeopt = { "menuone", "noselect", "preview" }, -- comma-separated list of options for Insert mode completion
  conceallevel = 0, -- determine how text with the 'conceal' syntax attribute :syn-conceal is shown
  confirm = true, -- operations that would normally fail, because of unsaved changes raise a dialog,  asking if we want to save
  cursorline = true, -- highlight the text line of the cursor with cursorline hl-CursorLine
  cursorlineopt = { "screenline", "number" }, -- settings for how cursorline is displayed
  expandtab = true, -- use the appropriate number of spaces to insert a <Tab>
  fileencoding = "utf-8", -- file-content encoding for the current buffer
  hlsearch = true, -- when there is a previous search pattern highlight all its matches
  hidden = true, -- When off a buffer is unloaded (including loss of undo information)
  ignorecase = true, -- ignore case in search patterns
  laststatus = 3, -- influences when the last window will have a status line
  mouse = 'a', -- enable mouse support
  number = true, -- print the line number in front of each line.
  numberwidth = 5, -- number of columns to use for the line number
  pumheight = 10, -- maximum number of items to show in popup menu
  relativenumber = true, -- show the line number relative to the line with the cursor
  scrolloff = 16, -- minimal number of screen lines to keep above and below the cursor
  shiftwidth = 2, -- number of spaces to use for each step of (auto)indent
  showtabline = 2, -- the value of this option specifies when the line with tab page labels will be displayed
  sidescrolloff = 60, -- the minimal number of screen columns to keep to the left and to the right of the cursor if nowrap is set
  signcolumn = "yes", -- when and how to draw the signcolumn
  smartcase = true, -- override the ignorecase option if the search patter contains upper case characters
  smartindent = false, -- do smart autoindenting when starting a new line
  splitbelow = true, -- when on, splitting a window will put the new window below the current
  splitright = true, -- when on, splitting a window will put the new window to the right of the current one
  swapfile = false, -- use a swapfile for the buffer
  tabstop = 4, -- number of spaces that a tab in the file counts for
  termguicolors = true, -- enables 24-bit RGB color in the TUI
  undofile = true, -- the name of the undo file that would be used for a file with {name} when writing
  updatetime = 250, -- updatetime - if this many millisecond's nothing is typed the swap file will be written to disk
  wrap = false, -- this option changes how text is displayed
  spellfile = spellfilePath, -- path to our custom dictionary
  spelllang = { "en_us", "de_de" }, -- languages we do spellchecking for, if we enable it
  foldlevel = 20, -- the result is a number, which is the foldlevel of line
  foldmethod = "expr", -- foldexpr gives t he foldlevel of a line
  foldexpr = "nvim_treesitter#foldexpr()", -- expression, used for when foldmethod is expr in this case treesitter
  title = true, -- when on title of the window will be set to titlestring
  titlestring = custom_titlestring, -- this option will be used for the title of the current window
}

-- Set option with value from options array
for k, v in pairs(options) do
  vim.opt[k] = v
end

-- TODO: evaluate preview for no completeopt
-- TODO: is guifont needed?
-- TODO: icon, iconstring
-- TODO: langmap
-- TODO: statusline
-- TODO: switchbuf
-- TODO: tabline
