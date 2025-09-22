local icons = require("config.assets.icons")

---Return the folder containing the directory above the current working directory
---@returns string
local function get_parent_folder()
  local cwd = vim.fn.getcwd()

  -- Remove trailing slash if present
  cwd = cwd:gsub("/$", "")

  -- Find the parent directory
  local parent_dir = cwd:match("(.+)/[^/]+$")

  if parent_dir then
    -- Extract the folder name from the parent directory
    local parent = parent_dir:match("([^/]+)$")

    if parent then
      local parent_folder = parent .. "/"
      return parent_folder
    end
  end

  -- Fallback to cwd if no parent folder is found
  return "cwd: "
end

get_parent_folder()

---Returns the project name via lua string matching
---@return string
local function get_project_name()
  local cwd = vim.fn.getcwd()

  -- Get the first position of / in the reversed string (last occurrence)
  local reversed_first_index = string.find(string.reverse(cwd), "/")

  -- Get the length of the reversed string
  local cwd_length = string.len(cwd)

  -- Add 2 to exclude the `/` and index offset
  local substring_start = cwd_length - reversed_first_index + 2

  -- Parse the project title via a substring
  local project_name = string.sub(cwd, substring_start, cwd_length)

  -- Fallback and return path if the project was not found
  if project_name == nil then
    return vim.fn.getcwd()
  end

  return project_name
end

---Checks if neovim was started with a director
---@return boolean
local function is_project_directory()
  local arguments = vim.v.argv
  local is_directory = false

  -- If any of the startup values was a '.'
  for _, value in ipairs(arguments) do
    if value == "." then
      is_directory = true
    end
  end

  -- If neovim is started without arguments it opens the cwd
  if #arguments == 2 then
    is_directory = true
  end

  return is_directory
end

---Generates the titlestring based on opened project or file
---@return string
local function generate_window_title()
  local is_project = is_project_directory()
  local prefix = is_project and icons.WindowTitle.project or icons.WindowTitle.file

  local project_name = get_project_name()
  local parent_folder = get_parent_folder()

  -- Concatenate prefix, parent folder, and project name for the title
  return prefix .. parent_folder .. project_name
end

---Sets the window title
vim.o.titlestring = generate_window_title()

--- Sets the terminal window/tab title to the project name when Neovim is about to close
vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
  pattern = { "*" },
  callback = function()
    local project_name = get_project_name()
    local parent_folder = get_parent_folder() or ""
    local exit_tab_title = parent_folder .. project_name

    -- Set the terminal/tab title to the project name
    vim.fn.chansend(vim.v.stderr, "\27]2;" .. exit_tab_title .. "\7")
    vim.o.titlestring = exit_tab_title
  end,
  group = vim.api.nvim_create_augroup("WindowTitle", { clear = true }),
})
