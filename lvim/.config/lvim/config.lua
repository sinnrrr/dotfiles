-- Features
-- =========================================
lvim.builtin.wakatime = { active = true }
lvim.builtin.debugger = { active = true } -- change this to enable/disable debugging
lvim.builtin.test_runner = { active = true, runner = "neotest" } -- change this to enable/disable ultest or neotest
lvim.builtin.sql_integration = { active = false } -- use sql integration
lvim.builtin.smooth_scroll = "neoscroll" -- for smoth scrolling, can be "cinnamon", "neoscroll" or ""
lvim.builtin.lf_integration = { active = true }
lvim.builtin.winbar_provider = "treesitter" -- can be "filename" or "treesitter" or ""
lvim.builtin.tag_provider = "symbols-outline" -- change this to use different tag providers ( symbols-outline or vista )
lvim.builtin.global_statusline = false -- set true to use global statusline
lvim.builtin.lsp_lines = false -- enable/disable lsp_lines to display lsp virtual text below instead of behind

-- Additional Plugins
-- =========================================
require("user.plugins").config()

-- Builtin components customizations
-- =========================================
require("user.builtin").config()

-- Formatters, linters, etc.
-- =========================================
require("user.null_ls").config()

-- Autocommands
-- =========================================
require("user.autocommands").config()

-- Additional keybindings
-- =========================================
require("user.keybindings").config()
