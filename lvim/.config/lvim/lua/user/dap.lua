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

	dap.adapters.cppdbg = {
		id = "cppdbg",
		type = "executable",
		command = "OpenDebugAD7",
	}

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

	dap.adapters.lldb = {
		type = "executable",
		command = "/opt/homebrew/opt/llvm/bin/lldb-vscode", -- adjust as needed, must be absolute path
		name = "lldb",
	}

	dap.configurations.cpp = {
		{
			name = "Launch",
			type = "lldb",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			args = {},

			-- 💀
			-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
			--
			--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
			--
			-- Otherwise you might get the following error:
			--
			--    Error on launch: Failed to attach to the target process
			--
			-- But you should be aware of the implications:
			-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
			-- runInTerminal = false,
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
			-- console = "externalTerminal",
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
