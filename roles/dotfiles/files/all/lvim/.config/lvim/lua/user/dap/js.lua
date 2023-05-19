local M = {}

M.setup = function()
	local dap = require("dap")
	dap.adapters.node2 = {
		type = "executable",
		command = "node-debug2-adapter",
	}

	dap.configurations.javascript = {
		{
			name = "Launch",
			type = "node2",
			request = "launch",
			program = "${file}",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			protocol = "inspector",
			console = "integratedTerminal",
		},
		{
			-- For this to work you need to make sure the node process is started with the `--inspect` flag.
			name = "Attach to process",
			type = "node2",
			request = "attach",
			processId = require("dap.utils").pick_process,
		},
	}

	dap.configurations.typescript = dap.configurations.javascript

	dap.adapters.chrome = {
		type = "executable",
		command = "chrome-debug-adapter",
	}

	dap.configurations.javascriptreact = {
		{
			type = "chrome",
			request = "attach",
			program = "${file}",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			protocol = "inspector",
			port = 9222,
			webRoot = "${workspaceFolder}",
		},
	}

	dap.configurations.typescriptreact = dap.configurations.javascriptreact
end

return M
