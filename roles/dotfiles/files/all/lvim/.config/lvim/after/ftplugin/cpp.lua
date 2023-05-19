local clangd_flags = {
	"--background-index",
	"--fallback-style=Google",
	"--all-scopes-completion",
	"--clang-tidy",
	"--log=error",
	"--suggest-missing-includes",
	"--cross-file-rename",
	"--completion-style=detailed",
	"--pch-storage=memory", -- could also be disk
	"--folding-ranges",
	"--enable-config", -- clangd 11+ supports reading from .clangd configuration file
	"--offset-encoding=utf-16", --temporary fix for null-ls
	-- "--limit-references=1000",
	-- "--limit-resutls=1000",
	-- "--malloc-trim",
	-- "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
	-- "--header-insertion=never",
	-- "--query-driver=<list-of-white-listed-complers>"
}

local custom_on_attach = function(client, bufnr)
	require("lvim.lsp").common_on_attach(client, bufnr)
	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lh", "<Cmd>ClangdSwitchSourceHeader<CR>", opts)
end

local opts = {
	cmd = { "clangd", unpack(clangd_flags) },
	on_attach = custom_on_attach,
}

require("lvim.lsp.manager").setup("clangd", opts)
