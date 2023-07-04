local util = require("lspconfig/util")

local function get_python_path(workspace)
	-- Use activated virtualenv.
	if vim.env.VIRTUAL_ENV then
		return util.path.join(vim.env.VIRTUAL_ENV, "bin", "python")
	end

	-- Find and use virtualenv in workspace directory.
	local match = vim.fn.glob(util.path.join(workspace, "pyproject.toml"))
	if match ~= "" then
		local venv = vim.fn.trim(vim.fn.system("poetry env info -p")):match("[^\n]*$") -- poetry 1.5 throws deprecation notice, pick only the last line with actual path
		if venv then
			return util.path.join(venv, "bin", "python")
		end
	end

	for _, pattern in ipairs({ "*", ".*" }) do
		match = vim.fn.glob(util.path.join(workspace, pattern, "pyvenv.cfg"))
		if match ~= "" then
			return util.path.join(util.path.dirname(match), "bin", "python")
		end
	end

	return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

local function set_python_path(client, path)
	if
		client.config.settings.python
		and client.config.settings.python.pythonPath
		and client.config.settings.python.pythonPath == path
	then
		return
	end
	client.config.settings = vim.tbl_deep_extend("force", client.config.settings, { python = { pythonPath = path } })
	-- client.notify("workspace/didChangeConfiguration", { settings = nil })
end

local python_path_per_project_cache = {}

local function find_root_dir(fname)
	local root_files = {
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		"pyrightconfig.json",
	}
	return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
end

local opts = {
	root_dir = find_root_dir,
	single_file_support = true,
	on_init = function()
		python_path_per_project_cache = {}
	end,
	on_attach = function(client, bufnr)
		local root_dir = find_root_dir(vim.api.nvim_buf_get_name(bufnr)) -- can't use client.config.root_dir, because it's not updated when this function is invoked
		if not python_path_per_project_cache[root_dir] then
			python_path_per_project_cache[root_dir] = get_python_path(root_dir)
		end
		set_python_path(client, python_path_per_project_cache[root_dir])
		vim.api.nvim_create_autocmd("BufEnter", {
			buffer = bufnr,
			callback = function()
				set_python_path(client, python_path_per_project_cache[root_dir])
			end,
		})
	end,
}

require("lvim.lsp.manager").setup("pyright", opts)
