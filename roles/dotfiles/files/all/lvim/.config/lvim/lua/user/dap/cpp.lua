local M = {}

M.setup = function()
	local dap = require("dap")

	dap.adapters.codelldb = {
		type = "server",
		port = "${port}",
		executable = {
			command = "codelldb",
			args = { "--port", "${port}" },
			-- On windows you may have to uncomment this:
			-- detached = false,
		},
	}

	dap.configurations.cpp = {
		{
			name = "Launch file",
			type = "codelldb",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			args = {},
		},
	}
	dap.configurations.c = dap.configurations.cpp
	-- dap.configurations.rust = dap.configurations.cpp
end

return M
