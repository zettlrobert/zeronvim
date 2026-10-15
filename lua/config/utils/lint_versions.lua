--[[
Compare the git hooks' linters (nix profile, github:zettlrobert/githooks) with
Mason's copies. nvim-lint uses the profile's copy so the editor reports what a
commit will; Mason only wins on machines without the profile.

- :LintVersions opens a table of both versions and which copy the editor uses.
- Once per session, a few seconds after startup, the same versions are read in
  the background. When Mason has a newer version than the profile, a WARN
  notification says the hooks' toolchain is behind. Each version pair warns
  once: it is remembered in ~/.local/state/nvim/lint-versions.json, and a newer
  Mason release warns again.
]]

local M = {}

---Linters shared with the git hooks, by nvim-lint name (= binary name).
M.shared = { "shellcheck", "yamllint", "hadolint", "actionlint", "markdownlint-cli2" }

M.profile_bin = vim.fn.expand("~/.nix-profile/bin/")

local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/"
local state_path = vim.fn.stdpath("state") .. "/lint-versions.json"
local title = "Linters"

---Run `<bin> --version` in the background and pass the first x.y.z to `cb`.
---Missing binary: `cb(nil)`. markdownlint-cli2 prints its version on any call.
---@param bin string
---@param cb fun(version: string|nil)
local function read_version(bin, cb)
  if vim.fn.executable(bin) ~= 1 then
    cb(nil)
    return
  end
  local ok = pcall(vim.system, { bin, "--version" }, { text = true, timeout = 5000 }, function(out)
    cb(((out.stdout or "") .. (out.stderr or "")):match("%d+%.%d+%.%d+"))
  end)
  if not ok then
    cb(nil)
  end
end

---Read profile and Mason versions of every shared linter, then call `cb` on the
---main loop with one row per linter.
---@param cb fun(rows: { name: string, profile: string|nil, mason: string|nil }[])
function M.collect(cb)
  local rows, pending = {}, #M.shared * 2
  local function done()
    pending = pending - 1
    if pending == 0 then
      vim.schedule(function()
        cb(rows)
      end)
    end
  end
  for i, name in ipairs(M.shared) do
    rows[i] = { name = name }
    read_version(M.profile_bin .. name, function(v)
      rows[i].profile = v
      done()
    end)
    read_version(mason_bin .. name, function(v)
      rows[i].mason = v
      done()
    end)
  end
end

---@return boolean true when Mason's version is newer than the profile's
local function mason_newer(row)
  return row.profile ~= nil and row.mason ~= nil and vim.version.gt(row.mason, row.profile)
end

local function editor_uses(row)
  if vim.fn.executable(M.profile_bin .. row.name) == 1 then
    return "profile"
  end
  return vim.fn.executable(mason_bin .. row.name) == 1 and "mason" or "-"
end

---Pad by display width: string.format pads by bytes and the ↑ is three.
local function pad(s, width)
  return s .. (" "):rep(width - vim.fn.strdisplaywidth(s))
end

---@return string[] the :LintVersions table
function M.format(rows)
  local function line(name, profile, mason, uses)
    return pad(name, 20) .. pad(profile, 18) .. pad(mason, 11) .. uses
  end
  local lines = { line("Linter", "Hooks (profile)", "Mason", "Editor uses") }
  for _, row in ipairs(rows) do
    local mason = (row.mason or "-") .. (mason_newer(row) and " ↑" or "")
    lines[#lines + 1] = line(row.name, row.profile or "-", mason, editor_uses(row))
  end
  return lines
end

local function load_warned()
  local f = io.open(state_path, "r")
  if not f then
    return {}
  end
  local content = f:read("*a")
  f:close()
  local ok, parsed = pcall(vim.json.decode, content)
  return (ok and type(parsed) == "table") and parsed or {}
end

---Atomic write via temp + rename, like toggle_lsp_server.
local function save_warned(warned)
  local tmp = state_path .. ".tmp"
  local f = io.open(tmp, "w")
  if not f then
    return
  end
  f:write(vim.json.encode(warned))
  f:close()
  os.rename(tmp, state_path)
end

---Notify about version pairs where Mason is newer and that have not warned yet.
---Pairs that are no longer behind drop out of the state file.
---@return string|nil the notification text, nil when nothing was sent
function M.warn(rows)
  local warned, current, fresh = load_warned(), {}, {}
  for _, row in ipairs(rows) do
    if mason_newer(row) then
      local pair = row.profile .. " → " .. row.mason
      current[row.name] = pair
      if warned[row.name] ~= pair then
        fresh[#fresh + 1] = ("  %-18s %s"):format(row.name, pair)
      end
    end
  end
  save_warned(current)
  if #fresh == 0 then
    return nil
  end
  local msg = table.concat({
    "The hooks' toolchain is behind Mason:",
    table.concat(fresh, "\n"),
    "Editor keeps the hook versions.",
    "Update: nix flake update in nix-profiles core, then nix profile upgrade",
    "Details: :LintVersions",
  }, "\n")
  vim.notify(msg, vim.log.levels.WARN, { title = title, timeout = 8000 })
  return msg
end

---Float with the version table; `q` or `<Esc>` closes it.
local function show(rows)
  local lines = M.format(rows)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.bo[buf].bufhidden = "wipe"
  local width = 0
  for _, line in ipairs(lines) do
    width = math.max(width, vim.fn.strdisplaywidth(line))
  end
  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width + 2,
    height = #lines,
    row = math.floor((vim.o.lines - #lines) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = "minimal",
    border = "rounded",
    title = " Lint versions ",
  })
  for _, key in ipairs({ "q", "<Esc>" }) do
    vim.keymap.set("n", key, "<cmd>close<cr>", { buffer = buf, nowait = true })
  end
end

vim.api.nvim_create_user_command("LintVersions", function()
  M.collect(show)
end, { desc = "Compare the git hooks' linters (nix profile) with Mason's" })

-- Background check: interactive sessions only, and only where the profile
-- exists (without it the editor already uses Mason, nothing to compare).
vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("LintVersions", { clear = true }),
  once = true,
  callback = function()
    if #vim.api.nvim_list_uis() > 0 and vim.fn.isdirectory(M.profile_bin) == 1 then
      vim.defer_fn(function()
        M.collect(M.warn)
      end, 5000)
    end
  end,
})

return M
