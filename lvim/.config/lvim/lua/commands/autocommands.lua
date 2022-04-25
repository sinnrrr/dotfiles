lvim.autocommands.custom_groups = {
	-- Organize typescript packages
	{ "BufWrite", "*.ts,*.tsx", ":TSLspOrganizeSync" },

	-- Formate tables on markdown save
	{ "BufWrite", "*.md", ":silent! TableFormat" },
}
