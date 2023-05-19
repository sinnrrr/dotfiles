local M = {}

M.config = function()
	require("refactoring").setup({
		-- prompt for return type
		prompt_func_return_type = {
			go = true,
			cpp = true,
			c = true,
			java = true,
		},
		-- prompt for function parameters
		prompt_func_param_type = {
			go = true,
			cpp = true,
			c = true,
			java = true,
		},
		printf_statements = {},
		print_var_statements = {},
	})
end

return M
