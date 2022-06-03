lvim.builtin.terminal.active = true
lvim.builtin.terminal.persist_size = true
lvim.builtin.terminal.size = 8
lvim.builtin.terminal.direction = "horizontal"
-- lvim.builtin.terminal.open_mapping = [[<c-b>]]

local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  end,
})

function _lazygit_toggle()
  lazygit:toggle()
end

local lf = Terminal:new({
  cmd = "lf",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  end,
})

function _lf_toggle()
  lf:toggle()
end

lvim.keys.normal_mode["gg"] = "<cmd>lua _lazygit_toggle()<CR>"
