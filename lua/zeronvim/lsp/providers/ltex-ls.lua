-- https://gist.github.com/lbiaggi/a3eb761ac2fdbff774b29c88844355b8
local Dictionary_file = {
  ["en_US"] = { vim.fn.stdpath "config" .. "/dictionary/en-dictionary.txt" },
  ["de_DE"] = { vim.fn.stdpath "config" .. "/dictionary/de-dictionary.txt" }
}

--[[]]
--[[ local DisabledRules_file = { ]]
--[[     ["en_US"] = {vim.fn.stdpath "config" .. "/dictionary/en-disable.txt"}, ]]
--[[     ["de_DE"] = {vim.fn.stdpath "config" .. "/dictionary/de-disable.txt"} ]]
--[[ } ]]
--[[]]
--[[ local FalsePositives_file = { ]]
--[[     ["en_US"] = {vim.fn.stdpath "config" .. "/dictionary/en-false.txt"}, ]]
--[[     ["de_DE"] = {vim.fn.stdpath "config" .. "/dictionary/de-false.txt"} ]]
--[[ } ]]
--[[]]


return {
  function ()
    require"ltex_extra".setup {
      load_langs = {"en-US", "de-DE" },
      init_check = true,
      path = vim.fn.stdpath "config" .. "/dictionary/dictionary.txt",
      log_level = "none",
    }
  end,
  settings = {
    language = "auto",
  }
}
