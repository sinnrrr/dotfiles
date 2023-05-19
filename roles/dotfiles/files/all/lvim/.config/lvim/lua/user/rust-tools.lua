local dap = require("dap")
local M = {}

M.config = function()
	require("rust-tools").setup({
		tools = {
			autoSetHints = true,
			runnables = {
				use_telescope = true,
			},
		},
		dap = {
			adapter = dap.adapters.codelldb,
		},
		server = {
			cmd = { "rust-analyzer" },
			on_attach = require("lvim.lsp").common_on_attach,
			on_init = require("lvim.lsp").common_on_init,
		},
	})
end

return M
