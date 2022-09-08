local M = {}

M.config = function()
  lvim.builtin.nvimtree.active = false

  vim.g.NERDTreeHijackNetrw = 0
  vim.g.lf_replace_netrw = 1
  vim.g.lf_map_keys = 0

  vim.g.floaterm_title = ""
  vim.g.floaterm_width = 0.8
  vim.g.floaterm_height = 0.8

  lvim.builtin.which_key.mappings["e"] = { "<cmd>Lf<cr>", "Explorer" }
end

return M
