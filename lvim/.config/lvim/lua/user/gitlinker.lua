local M = {}

M.config = function()
  local status_ok, gitlinker = pcall(require, "gitlinker")
  if not status_ok then
    return
  end
  gitlinker.setup {
    opts = {
      print_url = false,
    },
  }
end

return M
