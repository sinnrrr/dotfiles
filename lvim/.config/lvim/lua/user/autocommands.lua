local M = {}

local create_aucmd = vim.api.nvim_create_autocmd

M.config = function()
  create_aucmd("VimResized", {
    pattern = { "*" },
    command = "FloatermUpdate",
  })
end

return M
