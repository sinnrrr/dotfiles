local capabilities = require("lvim.lsp").common_capabilities()

local status, jdtls = pcall(require, "jdtls")
if not status then
	return
end

-- Determine OS
local home = os.getenv("HOME")
if vim.fn.has("mac") == 1 then
	WORKSPACE_PATH = home .. "/workspace/"
	CONFIG = "mac"
elseif vim.fn.has("unix") == 1 then
	WORKSPACE_PATH = home .. "/workspace/"
	CONFIG = "linux"
else
	print("Unsupported system")
end

-- Find root of project
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
	return
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local workspace_dir = WORKSPACE_PATH .. project_name

function get_regex_files(dir, filename)
	local handle = io.popen(string.format("find %s -name '%s'", dir, filename))
	local res = handle:read("*a")
	handle:close()
	return res
end

local bundles = {}
local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
vim.list_extend(
	bundles,
	vim.split(get_regex_files(mason_path .. "packages/java-test/extension/server/", "*.jar"), "\n")
)
vim.list_extend(
	bundles,
	vim.split(
		get_regex_files(
			mason_path .. "packages/java-debug-adapter/extension/server/",
			"com.microsoft.java.debug.plugin-*.jar"
		),
		"\n"
	)
)

local jdtls_launch =
	string.gsub(get_regex_files(mason_path .. "packages/jdtls/plugins/", "org.eclipse.equinox.launcher_*"), "\n", "")

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
	-- The command that starts the language server
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	cmd = {

		-- 💀
		"java", -- or '/path/to/java11_or_newer/bin/java'
		-- depends on if `java` is in your $PATH env variable and if it points to the right version.

		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-javaagent:" .. mason_path .. "packages/jdtls/lombok.jar",
		"-Xms1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-jar",
		jdtls_launch,
		-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
		-- Must point to the                                                     Change this to
		-- eclipse.jdt.ls installation                                           the actual version
		"-configuration",
		mason_path .. "packages/jdtls/config_" .. CONFIG,
		"-data",
		workspace_dir,
	},

	-- on_attach = require("lvim.lsp").on_attach,
	capabilities = capabilities,

	-- 💀
	-- This is the default if not provided, you can remove it. Or adjust as needed.
	-- One dedicated LSP server & client will be started per unique root_dir
	root_dir = root_dir,

	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- or https://github.com/redhat-developer/vscode-java#supported-vs-code-settings
	-- for a list of options
	settings = {
		java = {
			-- jdt = {
			--   ls = {
			--     vmargs = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx1G -Xms100m"
			--   }
			-- },
			eclipse = {
				downloadSources = true,
			},
			-- configuration = {
			-- 	updateBuildConfiguration = "interactive",
			-- 	runtimes = {
			-- 		{
			-- 			name = "JavaSE-11",
			-- 			path = "~/.sdkman/candidates/java/11.0.2-open",
			-- 		},
			-- 		{
			-- 			name = "JavaSE-18",
			-- 			path = "~/.sdkman/candidates/java/18.0.1.1-open",
			-- 		},
			-- 	},
			-- },
			maven = {
				downloadSources = true,
			},
			implementationsCodeLens = {
				enabled = true,
			},
			referencesCodeLens = {
				enabled = true,
			},
			references = {
				includeDecompiledSources = true,
			},
			inlayHints = {
				parameterNames = {
					enabled = "all", -- literals, all, none
				},
			},
			format = {
				enabled = false,
				-- settings = {
				--   profile = "asdf"
				-- }
			},
		},
		signatureHelp = { enabled = true },
		completion = {
			favoriteStaticMembers = {
				"org.hamcrest.MatcherAssert.assertThat",
				"org.hamcrest.Matchers.*",
				"org.hamcrest.CoreMatchers.*",
				"org.junit.jupiter.api.Assertions.*",
				"java.util.Objects.requireNonNull",
				"java.util.Objects.requireNonNullElse",
				"org.mockito.Mockito.*",
			},
		},
		contentProvider = { preferred = "fernflower" },
		extendedClientCapabilities = extendedClientCapabilities,
		sources = {
			organizeImports = {
				starThreshold = 9999,
				staticStarThreshold = 9999,
			},
		},
		codeGeneration = {
			toString = {
				template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
			},
			useBlocks = true,
		},
	},

	flags = {
		allow_incremental_sync = true,
	},

	-- Language server `initializationOptions`
	-- You need to extend the `bundles` with paths to jar files
	-- if you want to use additional eclipse.jdt.ls plugins.
	--
	-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
	--
	-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
	init_options = {
		-- bundles = {},
		bundles = bundles,
	},
}

config["on_attach"] = function(client, bufnr)
	local _, _ = pcall(vim.lsp.codelens.refresh)
	require("lvim.lsp").common_on_attach(client, bufnr)
	local map = function(mode, lhs, rhs, desc)
		if desc then
			desc = desc
		end

		vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc, buffer = bufnr, noremap = true })
	end

	map("n", "<leader>lco", "<Cmd>lua require('jdtls').organize_imports()<CR>", "Organize Imports")
	map("n", "<leader>lcv", "<Cmd>lua require('jdtls').extract_variable()<CR>", "Extract Variable")
	map("n", "<leader>lcc", "<Cmd>lua require('jdtls').extract_constant()<CR>", "Extract Constant")
	map("n", "<leader>lct", "<Cmd>lua require('jdtls').test_nearest_method()<CR>", "Test Method")
	map("n", "<leader>lcT", "<Cmd>lua require('jdtls').test_class()<CR>", "Test Class")
	map("n", "<leader>lcu", "<Cmd>JdtUpdateConfig<CR>", "Update Config")
	map("v", "<leader>lcv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", "Extract Variable")
	map("v", "<leader>lcc", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", "Extract Constant")
	map("v", "<leader>lcm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", "Extract Method")

	require("jdtls.dap").setup_dap_main_class_configs()
	jdtls.setup_dap({ hotcodereplace = "auto" })
end

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.java" },
	callback = function()
		local _, _ = pcall(vim.lsp.codelens.refresh)
	end,
})

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)

-- vim.cmd(
-- 	[[command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)]]
-- )
-- vim.cmd "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
vim.cmd("command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
-- -- vim.cmd "command! -buffer JdtJol lua require('jdtls').jol()"
-- vim.cmd "command! -buffer JdtBytecode lua require('jdtls').javap()"
-- -- vim.cmd "command! -buffer JdtJshell lua require('jdtls').jshell()"
