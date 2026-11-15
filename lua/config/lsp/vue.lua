---[[
---Vue workspace detection, shared by the TypeScript servers:
---
---  - after/lsp/tsc.lua   (TypeScript 7) skips Vue workspaces
---  - after/lsp/vtsls.lua (tsserver + @vue/typescript-plugin) only runs there
---  - after/lsp/vue_ls.lua handles the .vue template/style parts and forwards
---    TypeScript requests to vtsls ("hybrid mode")
---
---A buffer is in a Vue workspace when a package.json between the buffer and
---the workspace root lists `vue` or `nuxt` in its dependencies. Checking every
---package.json on the way up covers Nx/pnpm monorepos, where the Vue app's own
---package.json sits below the workspace root.
---]]
local M = {}

local LOCKFILES = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" }
local VUE_DEPS = { "vue", "nuxt" }

---@type table<string, boolean> package.json path → lists vue/nuxt
local cache = {}

---Whether a package.json lists vue or nuxt as a dependency. Cached per path.
---@param path string
---@return boolean
local function package_json_has_vue(path)
  if cache[path] ~= nil then
    return cache[path]
  end
  local found = false
  local ok, lines = pcall(vim.fn.readfile, path)
  if ok then
    local decoded_ok, pkg = pcall(vim.json.decode, table.concat(lines, "\n"))
    if decoded_ok and type(pkg) == "table" then
      for _, field in ipairs({ "dependencies", "devDependencies", "peerDependencies" }) do
        local deps = pkg[field]
        if type(deps) == "table" then
          for _, dep in ipairs(VUE_DEPS) do
            if deps[dep] ~= nil then
              found = true
            end
          end
        end
      end
    end
  end
  cache[path] = found
  return found
end

---Whether the buffer belongs to a Vue workspace.
---@param bufnr integer
---@return boolean
function M.is_vue_workspace(bufnr)
  local name = vim.api.nvim_buf_get_name(bufnr)
  if name == "" then
    return false
  end
  -- Stop at the workspace root (lockfile, else .git) so a package.json above
  -- the project never counts.
  local stop = vim.fs.root(bufnr, { LOCKFILES, { ".git" } })
  local files = vim.fs.find("package.json", {
    path = vim.fs.dirname(name),
    upward = true,
    limit = math.huge,
    stop = stop and vim.fs.dirname(stop) or nil,
  })
  for _, file in ipairs(files) do
    if package_json_has_vue(file) then
      return true
    end
  end
  return false
end

---Path of @vue/language-server inside Mason's vue-language-server package,
---which ships @vue/typescript-plugin for vtsls.
---@return string
function M.typescript_plugin_location()
  return vim.fs.joinpath(
    vim.fn.stdpath("data"),
    "mason",
    "packages",
    "vue-language-server",
    "node_modules",
    "@vue",
    "language-server"
  )
end

return M
