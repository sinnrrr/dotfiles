vim.list_extend(lvim.lsp.override, { "rust_analyzer" })
lvim.plugins = {
  { "ptzz/lf.vim" },
  { "voldikss/vim-floaterm" },
  { "lunarvim/colorschemes" },
  { "folke/tokyonight.nvim" },
  { "wakatime/vim-wakatime" },
  { "jose-elias-alvarez/nvim-lsp-ts-utils" },
  { "TovarishFin/vim-solidity" },
  { "sohkai/syntastic-local-solhint" },
  { "styled-components/vim-styled-components" },
  { "mg979/vim-visual-multi" },
  { "kevinhwang91/nvim-bqf" },
  {
    "simrat39/rust-tools.nvim",
    config = require("plugins.rust_tools").config,
    ft = { "rust", "rs" },
  },
  {
    "peterhoeg/vim-qml",
    event = "BufRead",
    ft = { "qml" },
  },
  -- {
  --   "tzachar/cmp-tabnine",
  --   config = function ()
  --     local tabnine = require "cmp_tabnine.config"
  --     tabnine:setup {
  --       max_lines = 1000,
  --       max_num_results = 20,
  --       sort = true,
  --     }
  --   end,

  --   run = "./install.sh",
  --   requires = "hrsh7th/nvim-cmp",
  -- }
}
