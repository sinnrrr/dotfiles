local M = {
}

M.config = function()
  lvim.leader = ","

  lvim.builtin.terminal.open_mapping = [[<c-\>]]

  -- ignore project.nvim mapping, use only packer
  lvim.builtin.which_key.mappings["P"] = lvim.builtin.which_key.mappings["p"]
  lvim.builtin.which_key.mappings["p"] = nil
  lvim.builtin.which_key.mappings[";"] = nil
  lvim.lsp.buffer_mappings.normal_mode["gr"] = nil
  --lvim.builtin.which_key.mappings["/"] = nil

  lvim.keys.normal_mode = {
    ["<C-s>"] = "<cmd>w<cr>",
    ["[d"] = "<cmd>lua vim.diagnostic.goto_prev()<cr>",
    ["]d"] = "<cmd>lua vim.diagnostic.goto_next()<cr>",
    ["[e"] = "<cmd>lua vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })<cr>",
    ["]e"] = "<cmd>lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })<cr>",
    ["gr"] = "<cmd>TroubleToggle lsp_references<cr>",
    ["gS"] = "<cmd>setlocal spell!<cr>",
    ["<C-Up>"] = ":resize +2<CR>",
    ["<C-Down>"] = ":resize -2<CR>",
    ["<C-Left>"] = ":vertical resize +2<CR>",
    ["<C-Right>"] = ":vertical resize -2<CR>",
    ["<S-l>"] = ":BufferLineCycleNext<CR>",
    ["<S-h>"] = ":BufferLineCyclePrev<CR>",
    ["<S-x>"] = ":BufferKill<CR>",
  }

  vim.cmd([[
      " backward search
       nnoremap \ ,
      "leader instead of , is not working for some reason
      "paste and ignore deleted content
       xnoremap ,p "_dP
      "delete completly (to the null register)
       " nnoremap ,d "_d
       " vnoremap ,d "_d
      "copy to the clipboard
       nnoremap ,y "+y
       vnoremap ,y "+y
  ]])

  lvim.builtin.which_key.mappings["LC"] = { "<cmd>LvimCacheReset<cr>", "Lvim cache reset" }
  lvim.builtin.which_key.mappings["W"] = {
    name = "Save options",
    s = { "<cmd>SudaWrite<cr>", "sudo save" },
    n = { "<cmd>noautocmd w<cr>", "no format save" },
    a = { "<cmd>wa<cr>", "save all" },
    t = { "<cmd>LvimToggleFormatOnSave<cr>", "Toggle format on save" },
    N = { "<cmd>noautocmd wa<cr>", "no format save all" },
  }

  lvim.builtin.which_key.mappings["T"] = {
    name = "Trouble",
    r = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
    f = { "<cmd>TroubleToggle lsp_definitions<cr>", "Definitions" },
    d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics" },
    q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix" },
    l = { "<cmd>TroubleToggle loclist<cr>", "Location list" },
    w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics" },
  }

  lvim.builtin.which_key.mappings["gv"] = {
    name = "Diffview",
    o = { "<cmd>DiffviewOpen<cr>", "Open" },
    c = { "<cmd>DiffviewClose<cr>", "Close" },
    r = { "<cmd>DiffviewRefresh<cr>", "Refresh" },
    f = { "<cmd>DiffviewRefresh<cr>", "Files History" },
  }
  lvim.builtin.which_key.mappings["gy"] = { "<cmd>lua require'gitlinker'.get_buf_range_url('n')<cr>", "Copy link" }
  lvim.builtin.which_key.mappings["gm"] = { "<cmd>Git<cr>", "Git menu" }

  lvim.builtin.which_key.mappings["m"] = { "<cmd>MarkdownPreviewToggle<cr>", "Live Markdown" }

  lvim.builtin.which_key.mappings["lo"] = { "<cmd>SymbolsOutline<cr>", "Outline" }

  lvim.builtin.which_key.mappings["S"] = {
    name = "Session",
    c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
    l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
    Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
  }

  lvim.builtin.which_key.mappings["r"] = {
    name = "Replace",
    r = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
    w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
    f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace Buffer" },
  }

  lvim.builtin.which_key.mappings["Y"] = { ":OSCYank<cr>", "OSC52 Copy (for ssh)", mode = "v" }
  lvim.builtin.which_key.mappings["e"] = { "<cmd>Lf<cr>", "Explorer" }
  lvim.builtin.which_key.mappings["ss"] = { "<cmd>Telescope resume<cr>", "Resume search" }

  lvim.builtin.which_key.mappings["t"] = {
    name = "Test Runner",
    f = { '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<cr>', "Run file" },
    n = { "<cmd>lua require('neotest').run.run()<cr>", "Run nearest" },
    r = { "<cmd>lua require('neotest').run.run_last()<cr>", "Re-run latest" },
    q = { "<cmd>lua require('neotest').run.stop()<cr>", "Stop nearest" },
    d = {
      name = "Debug",
      n = { "<cmd>lua require('neotest').run.run({ strategy='dap' })<cr>", "Debug nearest" },
      f = { "<cmd>lua require('neotest').run.run({ vim.fn.expand('%'), strategy='dap' })<cr>", "Debug file" },
      r = { "<cmd>lua require('neotest').run.run_last({ strategy='dap' })<cr>", "Re-run latest with debug" },
    },
    s = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Toogle Summary" },
    o = { "<cmd>lua require('neotest').output.open({ enter = true, short = false })<cr>", "Show output" },
  }

  local _, trouble = pcall(require, "trouble.providers.telescope")
  local _, actions = pcall(require, "telescope.actions")
  lvim.builtin.telescope.defaults.mappings = {
    i = {
      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,
      ["<C-n>"] = actions.cycle_history_next,
      ["<C-p>"] = actions.cycle_history_prev,
      ["<C-q>"] = trouble.open_with_trouble,
    },
    n = {
      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,
      ["<C-q>"] = trouble.open_with_trouble,
    },
  }

  lvim.builtin.which_key.mappings["d"] = {
    name = "Debug",
    t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
    l = {
      "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
      "Toggle Log point",
    },
    T = {
      "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
      "Toggle conditional Breakpoint",
    },
    B = { "<cmd>lua require'dap'.clear_breakpoints()<cr>", "Clear all breakpoints" },
    b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Start/Continue" },
    C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
    g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
    u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
    p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
    -- With new lvim autocommand to hide repl, no longer needed
    -- R = { "<cmd>lua require'dap'.repl.close()<cr>", "Close Repl" },
    q = { "<cmd>lua require'dap'.terminate()<cr>", "Quit" },
  }

  local cmp = require("cmp")
  lvim.builtin.cmp.mapping["<C-l>"] = cmp.mapping.complete()
  lvim.builtin.cmp.mapping["<C-Space>"] = nil
end

return M
