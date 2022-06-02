local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")

-- Check if the config is already defined (useful when reloading this file)
if not configs.nginxls then
	configs.nginxls = {
		default_config = {
			cmd = { "nginx-language-server" },
			filetypes = { "nginx" },
			root_dir = function(fname)
				return lspconfig.util.find_git_ancestor(fname)
			end,
			settings = {},
		},
	}
end
