local M = {}

M.config = function()
	local status_ok, dap = pcall(require, "dap")
	if not status_ok then
		return
	end

	dap.defaults.fallback.terminal_win_cmd = "50vsplit new"
	dap.defaults.fallback.exception_breakpoints = { "uncaught" }
	dap.defaults.fallback.external_terminal = {
		command = "alacritty",
		args = { "-e" },
	}

	dap.adapters.delve = {
		type = "server",
		port = "${port}",
		executable = {
			command = "dlv",
			args = { "dap", "-l", "127.0.0.1:${port}" },
		},
	}

	dap.configurations.go = {
		{
			type = "delve",
			name = "Debug",
			request = "launch",
			program = "${file}",
		},
		{
			type = "delve",
			name = "Debug test", -- configuration for debugging test files
			request = "launch",
			mode = "test",
			program = "${file}",
		},
		-- works with go.mod packages and sub packages
		{
			type = "delve",
			name = "Debug test (go.mod)",
			request = "launch",
			mode = "test",
			program = "./${relativeFileDirname}",
		},
	}

	local deps_ok, js_debug = pcall(function()
		return require("dap-vscode-js")
	end)
	if not deps_ok then
		return
	end

	js_debug.setup({
		debugger_cmd = { "js-debug-adapter" },
		adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
	})

	for _, language in ipairs({ "typescript", "javascript" }) do
		dap.configurations[language] = {
			{
				type = "pwa-node",
				request = "launch",
				name = "[pwa-node] Launch file",
				program = "${file}",
				cwd = "${workspaceFolder}",
			},
			{
				type = "pwa-node",
				request = "attach",
				name = "[pwa-node] Attach",
				processId = require("dap.utils").pick_process,
				cwd = "${workspaceFolder}",
			},
			{
				type = "pwa-node",
				request = "launch",
				name = "Debug Jest Tests",
				-- trace = true, -- include debugger info
				runtimeExecutable = "node",
				runtimeArgs = {
					"./node_modules/jest/bin/jest.js",
					"--runInBand",
				},
				rootPath = "${workspaceFolder}",
				cwd = "${workspaceFolder}",
				console = "integratedTerminal",
				internalConsoleOptions = "neverOpen",
			},
		}
	end

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
	dap.configurations.rust = dap.configurations.cpp
	dap.adapters.python = {
		type = "executable",
		command = "debugpy-adapter",
	}

	dap.configurations.python = {
		{
			type = "python",
			request = "launch",
			name = "Launch file",
			justMyCode = false,
			program = "${file}",
			pythonPath = function()
				local path
				for _, server in pairs(vim.lsp.buf_get_clients()) do
					if server.name == "pyright" or server.name == "pylance" then
						path = vim.tbl_get(server, "config", "settings", "python", "pythonPath")
						break
					end
				end
				-- path = vim.fn.input("Python path: ", path or "", "file")
				-- path = path ~= "" and vim.fn.expand(path) or nil
				return path
			end,
			env = function()
				return { ["PYTHONPATH"] = vim.fn.getcwd() }
			end,
			console = "integratedTerminal",
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
		},
	}
end

return M
