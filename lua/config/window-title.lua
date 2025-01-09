local icons = require("config.assets.icons")

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
  local prefix_project = icons.WindowTitle.project
  local prefix_file = icons.WindowTitle.file
  local prefix = prefix_file

  local is_dir = is_project_directory()

  if is_dir == true then
    prefix = prefix_project
  end

  local project_name = get_project_name()

  return prefix .. project_name
end

---Sets the window title
vim.o.titlestring = generate_window_title()
