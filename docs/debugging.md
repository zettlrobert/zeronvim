# Debugging in Neovim

A debugging session is a process in which a debugger is used to inspect the state of a program (the debuggee) as it is running. The debugger allows you to pause the execution of the program, inspect its variables and other properties, and step through the code line by line to understand the flow of control.

During a debugging session, you can use various debugging tools, such as breakpoints, watches, and call stacks, to inspect the state of the debuggee and understand its behavior. You can also use the debugger to run the debuggee to a specific point in the code, evaluate expressions, and perform other tasks related to debugging.

## DAP Scopes

DAP (Debug Adapter Protocol) Scopes are objects in the DAP that represent the state of a debuggee at a specific point in time. They can be used to inspect variables, evaluate expressions, and perform other tasks related to debugging.

In the DAP, a scope is defined by its name, variables, and other properties, such as its start and end line numbers in the source code, its type (e.g., global, local, etc.), and its parent scope.

Scopes can be used to represent different levels of the debuggee's state, such as global, local, and closure scopes. They can also be used to represent different contexts within the debuggee, such as catch blocks or with blocks.

You can use the DAP Scopes feature to inspect the variables and other properties of a scope and navigate between scopes in the debuggee. This can be useful when debugging a program and trying to understand its state at a specific point in time.

## DAP Breakpoint

DAP (Debug Adapter Protocol) Breakpoints are points in the source code of a debuggee at which the debugger can pause the execution of the program and allow you to inspect the state of the debuggee.

In the DAP, breakpoints are defined by their line number in the source code, the file in which they are located, and other properties, such as their condition (an expression that must be true for the breakpoint to be triggered) and their hit count (the number of times the breakpoint has been hit).

You can use the DAP Breakpoints feature to set, modify, and delete breakpoints in the debuggee. This can be useful when debugging a program and trying to understand its behavior at specific points in the code.

For example, you can set a breakpoint at a line of code where you suspect there might be an error, and then run the debuggee until the breakpoint is hit. At that point, you can inspect the state of the debuggee and determine the cause of the error.

I hope this helps! Let me know if you have any further questions or if you need further assistance.

## DAP Stacks

DAP (Debug Adapter Protocol) Stacks are data structures that represent the call stack of a debuggee at a specific point in time. They can be used to trace the execution of a program and understand the flow of control through the code.

In the DAP, a stack is defined by a list of stack frames, each of which represents a function call in the debuggee. A stack frame contains information about the function being called, such as its name, arguments, and local variables.

You can use the DAP Stacks feature to inspect the stack frames of a debuggee and navigate between them. This can be useful when debugging a program and trying to understand the flow of control through the code.

For example, you can use the DAP Stacks feature to inspect the arguments and local variables of a function at different points in its execution, or to trace the execution of a program from the start of a function to its return.

## DAP Watches

DAP (Debug Adapter Protocol) Watches are expressions that are evaluated by the debugger and displayed in the debuggee's user interface. They can be used to inspect the value of variables and other expressions at different points in the execution of a program.

In the DAP, watches are defined by their expression and their variables (the variables that are used in the expression). You can use the DAP Watches feature to add, modify, and delete watches in the debuggee.

You can use watches to inspect the value of variables and expressions at different points in the execution of a program. This can be useful when debugging a program and trying to understand the behavior of certain variables or expressions.

For example, you can set a watch on a variable that you suspect might be causing an error, and then run the debuggee until the error occurs. At that point, you can inspect the value of the watched variable and determine the cause of the error.

### Example for Debugging Session

- Start the debugging session by using the :DebuggerStart command. This will launch the debugger and open the JavaScript file you specified in your debug configuration.

- Set a breakpoint at a line of code where you want to pause the execution of the debuggee. You can use the :DebuggerBreakpoint command to set a breakpoint, or you can use the js-debug-adapter plugin's built-in commands, such as :DapToggleBreakpoint.

- Run the debuggee until the breakpoint is hit. You can use the :DebuggerContinue command to run the debuggee until the next breakpoint is hit, or you can use the :DebuggerStepOver command to step over the current line of code.

- Inspect the state of the debuggee at the breakpoint. You can use the :DebuggerEval command to evaluate expressions and inspect the value of variables, or you can use the :DebuggerStack command to view the call stack of the debuggee.

- Continue the debugging session as needed. You can use the :DebuggerContinue command to run the debuggee to the next breakpoint, or you can use the :DebuggerStepOver or :DebuggerStepInto commands to step through the code line by line.

---

## DAP Implementation

To enable debugging in neovim we need the following plugins:

```lua
  -- Plugin to bridge mason.nvim and nvim-dap
  use { "jayp0521/mason-nvim-dap.nvim" }

  -- Debug Adapter Protocol client implementation for Neovim
  use { "mfussenegger/nvim-dap" }

  -- A UI for nvim-dap which provides a good out of the box configuration.
  use { "rcarriga/nvim-dap-ui" }

  -- This plugin adds virtual text support to nvim-dap. nvim-treesitter is used to find variable definitions.
  use { "theHamsta/nvim-dap-virtual-text" }

  -- nvim-dap adapter for vscode-js-debug.
  use { "mxsdev/nvim-dap-vscode-js" }
```

These plugins are not enough to get debugging working, they just provide the foundation to add the individual adapters for specific languages.

Every language requires it's own adapter, some of them can be installed with `mason` others have to be installed manually.

### Local Implementation

- `mason-nvim-dap` has to be setup with but after mason as it hooks into its functionality to install adapters, we can ensure that daps are installed and even provide automatic setup for some. That automatic setup is not used for now as we want to configure the individual adapters.

- `nvim-dap` this is the main plugin, required to get the Debug Adapter Protocol working in neovim, we setup dap, import adapters and tie together our entire configuration in `dap/init.lua`

- `nvim-dap-ui` is a simple elegant ui for nvim-dap so we do not need to execute command after command to get information which is relevant in the debugging process

- `nvim-dap-virtual-text` provides as a treesitter based virtual text, with information at the current step of the debugging process

- `nvim-dap-vscode-js` this is a plugin which bridges the adapter and dap, and is required when using the `js-degbug-adapter`

### Common Vim Tips

- Visual selection to Replace according to pattern in that selection
- <ap - indent around paragraph - motion - >ap
- source %
- check if there is a mapping for a key combination
  - normal mode -> :nmap
  - normal mode -> :nmap <leader>
  - :verbose nmap <leader>
  - :Telescope keymaps
- :new Telescope buffers - to open a buffer in a window
