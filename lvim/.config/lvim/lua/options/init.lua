require "options.dashboard"
require "options.lualine"
require "options.notify"
require "options.nvimtree"
require "options.terminal"
require "options.treesitter"

lvim.log.level = "warn"
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.colorscheme = "onedarker"

lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

vim.g.NERDTreeHijackNetrw = 0
vim.g.lf_replace_netrw = 1
vim.g.lf_map_keys = 0

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        underline = true,
        virtual_text = {
            spacing = 5,
            severity_limit = 'Warning',
        },
        update_in_insert = true,
    }
)
