local M = {}

M.get_python_path_from_lsp = function()
	for _, server in pairs(vim.lsp.get_active_clients()) do
		if server.name == "pyright" or server.name == "pylance" then
			local path = vim.tbl_get(server, "config", "settings", "python", "pythonPath")
			return path
		end
	end
	-- path = vim.fn.input("Python path: ", path or "", "file")
	-- path = path ~= "" and vim.fn.expand(path) or nil
	-- return path
end

M.get_dap_config = function(tbl)
	return vim.tbl_extend("force", {
		type = "python",
		request = "launch",
		justMyCode = false,
		showReturnValue = true,
		console = "integratedTerminal",
	}, tbl or {})
end

M.setup = function()
	local dap = require("dap")

	dap.adapters.python = {
		type = "executable",
		command = "debugpy-adapter",
	}

	dap.configurations.python = vim.list_extend(dap.configurations.python or {}, {
		M.get_dap_config({
			name = "Launch file",
			program = "${file}",
			pythonPath = M.get_python_path_from_lsp,
			env = function()
				return { ["PYTHONPATH"] = vim.fn.getcwd() }
			end,
			args = function()
				local args = {}
				local i = 1
				while true do
					local arg = vim.fn.input("Argument [" .. i .. "]: ")
					if arg == "" then
						break
					end
					args[i] = arg
					i = i + 1
				end
				return args
			end,
		}),
	})
end

return M
