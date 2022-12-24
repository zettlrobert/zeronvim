# Debugging in Neovim

Implementation of the Debug Adapter Protocol

- start debugging
- continue to next breakpoint
- step over
- same principal as lsp

## Steps to get up and running

Install:

- mfussenegger/nvim-dap
- rcarriga/nvim-dap-ui
- theHamsta/nvim-dap-virutal-text
- nvim-telescope/telescope-dap.nvim
- leoluz//nvim-dap-go

- debug adapter for `x` language

  - goplease
  - delf (for go)

- Setup Keymaps
- nvim-virtual-text.setup
- leadser dt - debug test --> dap-go.debug_test
- dap.continue is the entrypoint for all things
- leader b to set a breakpoint
- leader B conditional breakpoint
  - write code to conditionally set breakpoints
  - breakpoints that only trigger when condition is fulfilled
- <leader>dr dap.repl.open

Nvim dap emits certain events, which will allow us to run functions on certain emits
The key in dap ui is to make sure that the function only ever runs once

## How to Debug

- dap.continue and call again
- set breakpoint
- start testing
- step over

### Common Tips

- Visual selection to Replace according to pattern in that selection
- <ap - indent arround paragraph - motion - >ap
- source %
- check if there is a mapping for a key combination
  - normal mode -> :nmap
  - normal mode -> :nmap <leader>
  - :verbose nmap <leader>
  - :Telescope keymaps
- :new Telescope buffers - to open a buffer in a window

### Debug an executable

## Debugging TS Node

## Debugging React
