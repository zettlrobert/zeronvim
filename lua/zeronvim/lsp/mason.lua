local utils = require "zeronvim.utils"
local mason = utils.protected_plugin_call("mason")
local mason_nvim_dap = utils.protected_plugin_call("mason-nvim-dap")

if mason and mason_nvim_dap then
  -- Default Mason Setup
  mason.setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      },

      keymaps = {
        -- Keymap to expand a package
        toggle_package_expand = "<CR>",
        -- Keymap to install the package under the current cursor position
        install_package = "i",
        -- Keymap to reinstall/update the package under the current cursor position
        update_package = "u",
        -- Keymap to check for new version for the package under the current cursor position
        check_package_version = "c",
        -- Keymap to update all installed packages
        update_all_packages = "U",
        -- Keymap to check which installed packages are outdated
        check_outdated_packages = "C",
        -- Keymap to uninstall a package
        uninstall_package = "X",
        -- Keymap to cancel a package installation
        cancel_installation = "<C-c>",
        -- Keymap to apply language filter
        apply_language_filter = "<C-f>",
      },
    },
  })

  -- Ensure we can install debug adapters with mason
  mason_nvim_dap.setup({
    ensure_installed = {
      "js-debug-adapter",
      "chrome-debug-adapter",
      "firefox-debug-adapter",
    },
    -- NOTE: this is left here for future porting in case needed
    -- Whether adapters that are set up (via dap) should be automatically installed if they're not already installed.
    -- This setting has no relation with the `ensure_installed` setting.
    -- Can either be:
    --   - false: Daps are not automatically installed.
    --   - true: All adapters set up via dap are automatically installed.
    --   - { exclude: string[] }: All adapters set up via mason-nvim-dap, except the ones provided in the list, are automatically installed.
    --       Example: automatic_installation = { exclude = { "python", "delve" } }
    automatic_installation = true,

    -- Whether adapters that are installed in mason should be automatically set up in dap.
    -- Removes the need to set up dap manually.
    -- See mappings.adapters and mappings.configurations for settings.
    -- Must invoke when set to true: `require 'mason-nvim-dap'.setup_handlers()`
    -- Can either be:
    -- 	- false: Dap is not automatically configured.
    -- 	- true: Dap is automatically configured.
    -- 	- {adapters: {ADAPTER: {}, }, configurations: {ADAPTER: {}, }}. Allows overriding default configuration.
    automatic_setup = true,
  })
end

-- Mason provides good default settings, there is no real change required
