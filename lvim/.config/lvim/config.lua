lvim.builtin.wakatime = { active = true }
lvim.builtin.lastplace = { active = true } -- change to false if you are jumping to future
lvim.builtin.tabnine = { active = true } -- change to false if you don't like tabnine
lvim.builtin.persistence = { active = true } -- change to false if you don't want persistence
lvim.builtin.dap = { active = true } -- change this to enable/disable debugging
lvim.builtin.fancy_diff = { active = false } -- enable/disable fancier git diff
lvim.builtin.test_runner = { active = true, runner = "neotest" } -- change this to enable/disable ultest or neotest
lvim.builtin.sql_integration = { active = false } -- use sql integration
lvim.builtin.smooth_scroll = "neoscroll" -- for smoth scrolling, can be "cinnamon", "neoscroll" or ""
lvim.builtin.cursorline = { active = false } -- use a bit fancier cursorline
lvim.builtin.async_tasks = { active = true } -- enable/disable async tasks
lvim.builtin.lf_integration = { active = true }
lvim.builtin.winbar_provider = "treesitter" -- can be "filename" or "treesitter" or ""
lvim.builtin.tag_provider = "symbols-outline" -- change this to use different tag providers ( symbols-outline or vista )
lvim.builtin.editorconfig = { active = true } -- enable/disable editorconfig
lvim.builtin.global_statusline = false -- set true to use global statusline
lvim.builtin.refactoring = { active = false } -- enable to use refactoring.nvim code_actions
lvim.builtin.lsp_lines = true -- enable/disable lsp_lines to display lsp virtual text below instead of behind

-- Additional Plugins
-- =========================================
require("user.plugins").config()

-- Additional Plugins
-- =========================================
require("user.builtin").config()

-- Debugging
-- =========================================
if lvim.builtin.dap.active then
	require("user.dap").config()
end

-- LF integration
-- =========================================
if lvim.builtin.lf_integration.active then
	require("user.lf").config()
end

require("user.null_ls").config()

-- Autocommands
-- =========================================
require("user.autocommands").config()

-- Additional keybindings
-- =========================================
require("user.keybindings").config()
