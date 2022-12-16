local get_icons = require "zeronvim.utils.get_icons"

local M = {}

-- Get the path and name of the current file
local get_filename_and_path = function()
  return vim.api.nvim_call_function("expand", { "%:p:t" })
end

-- Check if file or directory was opened
local is_file_or_directory = function()
  local filename = get_filename_and_path()

  if filename == "" then
    return nil
  elseif filename:sub(-1) == "/" then
    return "directory"
  else
    return "file"
  end
end

-- Generate a pretty project title string
local generate_project_title_string = function(title)
  local titlestring = " " .. title
  return titlestring
end

-- Generate a pretty file title string
local generate_file_title_string = function()
  local current_file = vim.api.nvim_call_function("expand", { "%:t" })
  local file_type = vim.api.nvim_call_function("expand", { "%:e" })
  local file_icon = get_icons.get_file_icon(current_file, file_type)
  local titlestring = file_icon .. " " .. current_file
  return titlestring
end

local generate_full_title_string = function()
  local full_path_and_name = get_filename_and_path()
  local file_type = vim.api.nvim_call_function("expand", { "%:e" })
  local file_icon = get_icons.get_file_icon(full_path_and_name, file_type)
  local titlestring = file_icon .. " " .. full_path_and_name
  return titlestring
end

local function split_path(path)
  local directories = {}

  for dir in path:gmatch("[^/]+") do
    table.insert(directories, dir)
  end
  return directories
end

-- Returns the absolute path for the current working directory
local current_working_directory = vim.api.nvim_call_function("getcwd", {})

-- Split the current_working_directory into individual directories
local directories = split_path(current_working_directory)

-- The number of directories in the current working path
local number_of_directories = #directories

local project_root = directories[number_of_directories]

-- Function that returns a titlestring based on project or file
M.get_title_string = function()
  -- Check if file or directory was opened
  local file_or_directory = is_file_or_directory()

  -- Here we handle edge cases like, nvim-tree and a dashboard
  if not file_or_directory then
    -- NVIM tree opens if we open a directory, the current file is `.` thasts why we want to use the generate_project_title_string
    local project_title_string = generate_project_title_string(project_root)
    return project_title_string
  end

  if file_or_directory == 'file' then
    local file_title_string = generate_file_title_string()
    return file_title_string
  end

  if file_or_directory == 'directory' then
    local project_title_string = generate_project_title_string(project_root)
    return project_title_string
  end

  -- Fallback
  return generate_full_title_string()
end

-- This function updates the current titlestring to the project directory
M.set_titlestring_to_project = function()
  local project_title_string = generate_project_title_string(project_root)
  vim.o.titlestring = project_title_string
end

-- This function updates the current titlestring to the filename
M.set_titlestring_to_file = function()
  local file_title_string = generate_file_title_string()
  vim.o.titlestring = file_title_string
end

return M
