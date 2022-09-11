local M = {}

M.config = function()
  local status_ok, dapui = pcall(require, "dapui")
  if not status_ok then
    return
  end

  dapui.setup {
    icons = { expanded = "▾", collapsed = "▸" },
    mappings = {
      expand = { "<CR>", "l" },
      open = "o",
      remove = "d",
      edit = "e",
      repl = "r",
      toggle = "t",
    },
    layouts = {
      {
        elements = {
          { id = "scopes", size = 0.33 },
          { id = "breakpoints", size = 0.25 },
          -- { id = "stacks", size = 0.25 },
          -- { id = "watches", size = 0.25 },
        },
        size = 50,
        position = "left",
      },
      {
        elements = {
          "repl",
          -- "console",
        },
        size = 8,
        position = "bottom",
      },
      floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      windows = { indent = 1 },
    },
  }

  local dap = require "dap"
  dap.listeners.after.event_initialized["dapui_config"] = function()
    vim.cmd [[
      vnoremap ge <Cmd>lua require("dapui").eval()<CR>
      map ge <Cmd>lua require("dapui").eval()<CR>
    ]]
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
    dap.repl.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
    dap.repl.close()
  end
end

return M
