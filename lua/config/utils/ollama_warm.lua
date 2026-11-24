--[[
Load an Ollama model in the background before completion requests need it.

Ollama unloads a model after 5 minutes idle (OLLAMA_KEEP_ALIVE default), and
reloading the 7B coder takes ~3-4 s. minuet's requests time out after 3 s
(`request_timeout`) and are cancelled on every keystroke, and a cancelled
request aborts the load ("Load failed ... context canceled" in the Ollama
log). So after a break the model never came back and minuet stayed silent.

This sends one request with no prompt, which only loads the model. It has its
own long timeout and is not tied to a completion, so typing cannot cancel it.
When the model is already loaded it returns in a few milliseconds.
]]

local M = {}

local last = 0
local MIN_INTERVAL_S = 30

---@param end_point string OpenAI-style URL, e.g. http://localhost:11434/v1/completions
---@param model string
---@param force? boolean skip the rate limit
function M.warm(end_point, model, force)
  local now = os.time()
  if not force and now - last < MIN_INTERVAL_S then
    return
  end
  last = now
  local base = end_point:gsub("/v1/.*$", "")
  vim.system({
    "curl",
    "-s",
    "-o",
    "/dev/null",
    "--max-time",
    "60",
    "-d",
    vim.json.encode({ model = model }),
    base .. "/api/generate",
  })
end

return M
