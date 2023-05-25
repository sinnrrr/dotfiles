require("typescript").setup({
	debug = false, -- enable debug logging for commands
	go_to_source_definition = {
		fallback = true, -- fall back to standard LSP definition on failure
	},
	-- server = { -- pass options to lspconfig's setup method
	-- 	on_attach = ...,
	-- },
})
require("lspconfig").tsserver.setup({})

lvim.builtin.which_key.mappings["lc"] = {
	name = "Typescript",
	i = { "<cmd>TypescriptAddMissingImports<cr>", "Import All" },
	f = { "<cmd>TypescriptFixAll<cr>", "Fix all" },
	o = { "<cmd>TypescriptOrganizeImports<cr>", "Organize Imports" },
	r = { "<cmd>TypescriptRenameFile<cr>", "Rename File" },
	u = { "<cmd>TypescriptRemoveUnused<cr>", "Remove unused" },
	d = { "<cmd>TypescriptGoToSourceDefinition<cr>", "Go to source definition" },
}
