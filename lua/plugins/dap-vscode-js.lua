return {
  "mxsdev/nvim-dap-vscode-js",
  "microsoft/vscode-js-debug",
  -- Install vscode-js-debug - https://github.com/microsoft/vscode-js-debug
  build = "cd /home/zettlrobert/.local/share/nvim/lazy/nvim-dap-vscode-js/ && npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
  config = function()
    local dap_vscode_js = require("nvim-dap-vscode-js")

    dap_vscode_js.setup({
      adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
    })
  end,
}
