local status_ok, dap = pcall(require, "dap")
if not status_ok then
	return
end

-- dap.defaults.fallback.terminal_win_cmd = "50vsplit new"
dap.defaults.fallback.exception_breakpoints = { "uncaught" }
dap.defaults.fallback.external_terminal = {
	command = "open -na Alacritty",
	args = { "-e" },
}

require("user.dap.python").setup()
require("user.dap.js").setup()
require("user.dap.go").setup()
require("user.dap.cpp").setup()

require("dap.ext.vscode").load_launchjs()
