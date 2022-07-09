local status_ok, dap = pcall(require, "dap")
if not status_ok then
	return
end

local dbg_path = vim.fn.expand("$LVIM_DEBUGGERS")

dap.configurations.lua = {
	{
		type = "nlua",
		request = "attach",
		name = "Neovim attach",
		host = function()
			local value = vim.fn.input("Host [127.0.0.1]: ")
			if value ~= "" then
				return value
			end
			return "127.0.0.1"
		end,
		port = function()
			local val = tonumber(vim.fn.input("Port: "))
			assert(val, "Please provide a port number")
			return val
		end,
	},
}

dap.adapters.go = function(callback, _)
	local stdout = vim.loop.new_pipe(false)
	local handle
	local pid_or_err
	local port = 38697
	local opts = {
		stdio = { nil, stdout },
		args = { "dap", "-l", "127.0.0.1:" .. port },
		detached = true,
	}
	handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
		stdout:close()
		handle:close()
		if code ~= 0 then
			print("dlv exited with code", code)
		end
	end)
	assert(handle, "Error running dlv: " .. tostring(pid_or_err))
	stdout:read_start(function(err, chunk)
		assert(not err, err)
		if chunk then
			vim.schedule(function()
				require("dap.repl").append(chunk)
			end)
		end
	end)
	-- Wait for delve to start
	vim.defer_fn(function()
		callback({ type = "server", host = "127.0.0.1", port = port })
	end, 100)
end
-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
	{
		type = "go",
		name = "Debug",
		request = "launch",
		program = "${file}",
	},
	{
		type = "go",
		name = "Debug test", -- configuration for debugging test files
		request = "launch",
		mode = "test",
		program = "${file}",
	},
	-- works with go.mod packages and sub packages
	{
		type = "go",
		name = "Debug test (go.mod)",
		request = "launch",
		mode = "test",
		program = "./${relativeFileDirname}",
	},
}

dap.adapters.node2 = {
	type = "executable",
	command = "node",
	args = { dbg_path .. "/node2/out/src/nodeDebug.js" },
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
dap.configurations.typescriptreact = dap.configurations.typescript
dap.configurations.javascriptreact = dap.configurations.typescript

dap.adapters.codelldb = function(on_adapter)
	local tcp = vim.loop.new_tcp()
	tcp:bind("127.0.0.1", 0)
	local port = tcp:getsockname().port
	tcp:shutdown()
	tcp:close()
	local stdout = vim.loop.new_pipe(false)
	local stderr = vim.loop.new_pipe(false)
	local opts = {
		stdio = { nil, stdout, stderr },
		args = { "--port", tostring(port) },
	}
	local handle
	local pid_or_err
	handle, pid_or_err = vim.loop.spawn(dbg_path .. "/codelldb/extension/adapter/codelldb", opts, function(code)
		stdout:close()
		stderr:close()
		handle:close()
		if code ~= 0 then
			print("codelldb exited with code", code)
		end
	end)
	if not handle then
		vim.notify("Error running codelldb: " .. tostring(pid_or_err), vim.log.levels.ERROR)
		stdout:close()
		stderr:close()
		return
	end
	vim.notify("codelldb started. pid=" .. pid_or_err)
	stderr:read_start(function(err, chunk)
		assert(not err, err)
		if chunk then
			vim.schedule(function()
				require("dap.repl").append(chunk)
			end)
		end
	end)
	local adapter = {
		type = "server",
		host = "127.0.0.1",
		port = port,
	}
	vim.defer_fn(function()
		on_adapter(adapter)
	end, 500)
end

dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = true,
	},
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

dap.adapters.python = {
	type = "executable",
	command = dbg_path .. "/debugpy/bin/python",
	args = { "-m", "debugpy.adapter" },
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
			path = path ~= "" and vim.fn.expand(path) or nil
			return path
		end,
		env = function()
			return { ["PYTHONPATH"] = vim.fn.getcwd() }
		end,
		-- args = function()
		--   local args = {}
		--   local i = 1
		--   while true do
		--     local arg = vim.fn.input("Argument [" .. i .. "]: ")
		--     if arg == "" then
		--       break
		--     end
		--     args[i] = arg
		--     i = i + 1
		--   end
		--   return args
		-- end,
	},
}
