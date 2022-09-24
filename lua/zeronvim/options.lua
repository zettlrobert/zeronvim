--[[
-- autoindent - automatically indent line with indentation of previous line
-- autoread - automatically read file when changed outside of vim
-- backup - keep backup file after overwriting a file
-- breakindent - wrapped line repeats indent
-- cmdheight - Number of screen lines to use for the command-line, space to display messages
-- colorcolum - comma-separated list of screen columns
-- completeopt -  comma-separated list of options for Insert mode completion
-- conceallevel - determine how text with the 'conceal' syntax attribute :syn-conceal is shown
-- confirm - operations that would normally fail, because of unsaved changes raise a dialog,  asking if we want to save
-- cursorline - highlight the text line of the cursor with cursorline hl-CursorLine
-- cursorlineopt - settings for how cursorline is displayed
-- expandtab - use the appropriate number of spaces to insert a <Tab>
-- fileencoding - file-content encoding for the current buffer
-- hlsearch - when there is a previous search pattern highlight all its matches
-- ignorecase - ignore case in search patterns
-- laststatus - influences when the last window will have a status line
-- mouse - enable mouse support
-- number - print the line number in front of each line.
-- numberwidth - number of columns to use for the line number
-- pumheight - maximum number of items to show in popup menu
-- relativenumber - show the line number relative to the line with the cursor
-- scrolloff - minimal number of screen lines to keep above and below the cursor
-- shiftwidth - number of spaces to use for each step of (auto)indent
-- showtabline - the value of this option specifies when the line with tab page labels will be displayed
-- sidescrolloff - the minimal number of screen columns to keep to the left and to the right of the cursor if nowrap is set
-- signcolumn - when and how to draw the signcolumn
-- smartcase - override the ignorecase option if the search patter contains upper case characters
-- smartindent - do smart autoindenting when starting a new line
-- splitbelow - when on, splitting a window will put the new window below the current
-- splitright - when on, splitting a window will put the new window to the right of the current one
-- swapfile - use a swapfile for the buffer
-- tabstop - number of spaces that a tab in the file counts for
-- termguicolors - enables 24-bit RGB color in the TUI
-- undofile - the name of the undo file that would be used for a file with {name} when writing
-- updatetime - if this many millisecond's nothing is typed the swap file will be written to disk 
-- wrap - this option changes how text is displayed
--]]
local options = {
  autoindent = true,
  autoread = true,
  backup = false,
  breakindent = true,
  cmdheight = 2,
  colorcolum = "125",
  completeopt = { "menuone", "noselect", "preview" },
  conceallevel = 0,
  confirm = true,
  cursorline = true,
  cursorlineopt = { "screenline", "number" },
  expandtab = true,
  fileencoding = "utf-8",
  hlsearch = true,
  ignorecase = true,
  laststatus = 3,
  mouse = 'a',
  number = true,
  numberwidth = "5",
  pumheight = 10,
  relativenumber = true,
  scrolloff = 16,
  shiftwidth = 2,
  showtabline = 2,
  sidescrolloff = 16,
  signcolumn = "yes",
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  tabstop = 4,
  termguicolors = true,
  undofile = true,
  updatetime = 300,
  wrap = true
}

-- Set option with value from options array
for k, v in pairs(options) do
  vim.opt[k] = v
end


-- TODO: evaluate preview for no completeopt
-- TODO: foldclose, foldcolumn, foldenable
-- TODO: is guifont needed?
-- TODO: icon, iconstring
-- TODO: langmap
-- TODO: linebreak - this has to be used in conjunction with wrap
-- TODO: wrap
-- TODO: scrollback
-- TODO: showbreak
-- TODO: spellsuggest
-- TODO: statusline
-- TODO: switchbuf
-- TODO: tabline
--
--[[]]
--[[ vim.opt.shortmess:append "c" 				    -- Don't pass messages to |ins-completion-menu|. ]]
--[[ vim.opt.errorbells=false                       	-- Disable soundeffects ]]
--[[ vim.cmd('syntax on')                         	-- Syntax on ]]
--[[ vim.o.hidden = true                             -- Required to keep multiple buffers open multiple buffers ]]
--[[ vim.o.mousemodel = "popup"			            -- Sets the model for the mouse to use ]]
--[[ vim.cmd('highlight Normal guibg=none') ]]
--[[]]
--[[]]
--[[ --  Tab, Indent and Words ]]
--[[ vim.o.softtabstop = 4                           -- Insert 4 spaces for a tab ]]
--[[ vim.bo.autoindent = true                        -- Copy indent from current line ]]
--[[ vim.cmd('set iskeyword+=-')       	            -- treat dash separated words as a word text object" ]]
--[[ vim.cmd('set shortmess+=c') ]]
--[[ vim.cmd('set inccommand=split')			        -- Make substitution work in real time ]]
--[[ -- vim.o.spell = true				            -- Spell checking for nvim enabled ]]
--[[ vim.o.spellcapcheck = ''			            -- Ignore capitalization when spell checking ]]
--[[ vim.o.showmatch = true				            -- When bracket is inserted, briefly jump to the matching one. ]]
--[[ vim.o.spelllang = 'en_us'                       -- Languages ]]

