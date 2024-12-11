return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    main = "nvim-treesitter.configs",
    opts = {
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<Leader>ts",
          node_incremental = ".",
          scope_incremental = ";",
          node_decremental = ",",
        },
      },
    },
    init = function()
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    end,
  },
  {
    "Darazaki/indent-o-matic",
    event = "BufReadPost",
    opts = {},
  },
}
