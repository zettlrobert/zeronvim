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
-- mouse - enable mouse support
--
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
  mouse = 'a',


}

-- TODO: evaluate preview for no completeopt
-- TODO: foldclose, foldcolumn, foldenable
-- TODO: is guifont needed?
-- TODO: icon, iconstring
-- TODO: langmap
-- TODO: linebreak


--[[



  laststatus = 3,                               -- status line only on last window
  pumheight = 10, 					            -- Makes popup menu height
  showtabline = 2, 					            -- Always show tabs
  smartcase = true, 					        -- Smartcase
  smartindent = true,                        	-- Makes indenting smart
  splitbelow = true,                       	    -- Horizontal splits will automatically be below
  splitright = true,                       	    -- Vertical splits will automatically be to the right
  swapfile = false,                          	-- No swap file
  termguicolors = true,                     	-- set term GUI colors most terminals support this
  cndofile = true,					            -- enable persistend uindo
  updatetime = 300,			                    -- Faster update time.
  shiftwidth = 2,   				            -- Shiftwidth value
  tabstop = 4, 					                -- Insert 4 spaces for a tab
  number = true,                          		-- Set numbered lines
  relativenumber = true,	                  	-- Set relative line numbers
  numberwidth = 4, 				                -- set number column width to (default 4)
  cigncolumn = "yes",  	                   	    -- Always show the signcolumn, otherwise it would shift the text each time
  wrap = false,                             	-- Display long lines as just one line
  scrolloff = 16,           	                -- Move up and down when reaching + - 16 lines of code
  sidescrolloff = 8,				            -- The minimal numer of screenoffset to keep to the left and right
- ]]
