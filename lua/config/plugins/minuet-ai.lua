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
  -- Loaded only when enabled through config.utils.ai_toggle (<leader>am or
  -- <leader>aA in config/keymaps.lua), never at startup.
  lazy = true,
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
          -- Base variant is required for clean FIM completions. The plain
          -- `qwen2.5-coder:7b` tag is the instruct (chat) variant, which
          -- treats <|fim_prefix|>/<|fim_middle|> tokens loosely and produces
          -- completions that overlap or shift by one character.
          model = "qwen2.5-coder:7b-base",
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

      -- One request per suggestion; Ollama runs them one after another, so
      -- each extra one adds ~0.2-0.3 s on the 7900 XTX (measured: 1 = ~0.5 s,
      -- 2 = ~0.7 s, 3 = ~1.0-1.3 s). Two gives an alternative for little wait.
      n_completions = 2, -- (minuet default: 3)
      -- Characters, not tokens: 6000 is about 1,500 tokens of Lua. Measured
      -- (docs/ai.md): same completion quality as 12000 on typical files, and
      -- half the slow-request latency (p95 0.7 s instead of 1.35 s). Raising
      -- it past ~15000 gets the prompt cut by Ollama unless
      -- OLLAMA_CONTEXT_LENGTH is raised too.
      -- context_window = 12000,
      context_window = 6000,

      -- Disable the auto-generated "first line only" duplicate entry. Reduces
      -- edge cases in blink's item handling and avoids two-lines-shown vs
      -- one-line-inserted mismatches.
      add_single_line_entry = false,
    })

    -- Default off on every load path. ai_toggle queues its enable after this.
    -- Deferred so require("minuet").config is populated before disable runs.
    vim.schedule(function()
      require("config.utils.ai_toggle").disable_minuet({ silent = true })
    end)
  end,
}
