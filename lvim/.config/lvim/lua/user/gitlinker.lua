local M = {}

M.config = function()
  local status_ok, gitlinker = pcall(require, "gitlinker")
  if not status_ok then
    return
  end
  gitlinker.setup {
    opts = {
      print_url = false,
      action_callback = function(url)
        -- yank to unnamed register
        vim.api.nvim_command("let @\" = '" .. url .. "'")
        -- copy to the system clipboard using OSC52
        vim.fn.OSCYankString(url)
      end,
    },
  }
end

return M
