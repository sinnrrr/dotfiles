local util = require("lspconfig/util")
local path = util.path

local function get_python_path(workspace)
	-- Use activated virtualenv.
	if vim.env.VIRTUAL_ENV then
		return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
	end

	-- Find and use virtualenv in workspace directory.
	for _, pattern in ipairs({ "*", ".*" }) do
		local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
		if match ~= "" then
			return path.join(path.dirname(match), "bin", "python")
		end
		match = vim.fn.glob(path.join(workspace, "pyproject.toml"))
		if match ~= "" then
			local venv = vim.fn.trim(vim.fn.system("poetry env info -p"))
			if venv then
				return path.join(venv, "bin", "python")
			end
		end
	end

	-- Fallback to system Python.
	return exepath("python3") or exepath("python") or "python"
end

local opts = {
	root_dir = function(fname)
		local root_files = {
			"pyproject.toml",
			"setup.py",
			"setup.cfg",
			"requirements.txt",
			"Pipfile",
			"manage.py",
			"pyrightconfig.json",
		}
		return util.root_pattern(unpack(root_files))(fname)
			or util.root_pattern(".git")(fname)
			or util.path.dirname(fname)
	end,
	single_file_support = true,
	before_init = function(_, config)
		config.settings.python.pythonPath = get_python_path(config.root_dir)
	end,
}

local servers = require("nvim-lsp-installer.servers")
local server_available, requested_server = servers.get_server("pyright")
if server_available then
	opts.cmd_env = requested_server:get_default_options().cmd_env
end

require("lvim.lsp.manager").setup("pyright", opts)
