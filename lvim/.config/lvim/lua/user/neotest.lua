local M = {}

M.config = function()
  require("neotest").setup({
    floating = {
      max_width = 0.8,
      max_height = 0.8,
    },
    output = {
      open_on_run = false,
    },
    discovery = {
      concurrent = 1,
      enabled = true,
    },
    summary = {
      follow = true,
      expand_errors = false,
      mappings = {
        attach = "a",
        expand = { "l", "h" }, -- any letter just toggles, keep both
        expand_all = "L",
        jumpto = "<CR>",
        output = "o",
        short = "s",
        run = "r",
        mark = "t",
        run_marked = "R",
        clear_marked = "c",
        stop = "q",
        next_failed = "]e",
        prev_failed = "[e",
        target = nil,
        clear_target = nil,
      },
    },
    adapters = {
      require("neotest-python")({
        args = { "-vv", "-s" },
        runner = "pytest",
        dap = {
          justMyCode = false,
        },
      }),
      require("neotest-go"),
    },
  })
end

return M
