local dap = require("dap")
local dapui = require("dapui")

lvim.autocommands = {
	-- could also created file fugitive.lua in ftplugin
	{
		"FileType",
		{
			pattern = { "fugitive" },
			callback = function()
				vim.cmd([[
          nnoremap <silent> <buffer> q :close<CR>
          set nobuflisted
        ]])
			end,
		},
	},
	{
		"FileType",
		{
			pattern = { "gitcommit" },
			callback = function()
				vim.cmd([[
          nnoremap <silent> <buffer> <leader>w :noautocmd w<CR>
        ]])
			end,
		},
	},
	{
		"BufWritePost",
		{
			pattern = { "*/.vscode/launch.json" },
			callback = function()
				require("dap.ext.vscode").load_launchjs()
			end,
		},
	},
	{
		"VimResized",
		{
			callback = function()
				if dap.session() then
					dapui.open({ reset = true })
				end
			end,
		},
	},
}
