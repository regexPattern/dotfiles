return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost" },
    opts = {
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<leader>ts",
          node_incremental = ".",
          scope_incremental = ";",
          node_decremental = ",",
        },
      },
    },
  },

  {
    "Darazaki/indent-o-matic",
    event = "BufReadPost",
    opts = {},
  },
}
