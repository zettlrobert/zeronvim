-- https://github.com/milanglacier/minuet-ai.nvim
--
-- AI code completion via blink source. Sole current backend: local Ollama
-- running qwen2.5-coder:7b via the OpenAI-compatible FIM endpoint.
--
-- Blink integration is registered in lua/config/plugins/completion.lua
-- (the `minuet` source in the providers table and default sources list).
--
-- Backend swap: edit `provider` + `provider_options` below. Fenrir integration
-- is planned once its endpoint is publicly available — see `docs/ai.md` and
-- `.plan/chore-nvim-improvements/PLAN.md` section 1.

return {
  "milanglacier/minuet-ai.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("minuet").setup({
      -- FIM (fill-in-middle) completion. qwen2.5-coder ships with FIM tokens
      -- baked in, and Ollama exposes an OpenAI-compatible /v1/completions
      -- endpoint that minuet can drive via this provider.
      provider = "openai_fim_compatible",

      provider_options = {
        openai_fim_compatible = {
          -- Local Ollama needs no auth; minuet still requires an env var name
          -- for its `api_key` field. `TERM` is always defined ($TERM=xterm-...)
          -- so it satisfies the check without leaking anything meaningful.
          api_key = "TERM",
          name = "Ollama",
          end_point = "http://localhost:11434/v1/completions",
          model = "qwen2.5-coder:7b",
          stream = true,
          optional = {
            max_tokens = 128,
            top_p = 0.9,
          },
        },
      },

      -- Request pacing. Higher throttle/debounce = fewer requests to Ollama
      -- at the cost of feeling slower.
      throttle = 1500, -- ms between successive completion requests
      debounce = 400, -- ms of no keystrokes before firing

      n_completions = 1, -- single suggestion per request keeps latency down
      context_window = 12000, -- max input tokens sent to the model
    })

    -- Default off. Enable on demand via <leader>am or <leader>aA.
    -- Deferred so require("minuet").config is populated before disable runs.
    vim.schedule(function()
      require("config.utils.ai_toggle").disable_minuet({ silent = true })
    end)
  end,
}
