return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    main = "nvim-treesitter.configs",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-refactor",
    },
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
      refactor = {
        highlight_definitions = {
          enable = true,
          clear_on_cursor_move = true,
        },
        navigation = {
          enable = true,
          keymaps = {
            goto_definition_lsp_fallback = "gd",
          },
        },
        smart_rename = {
          enable = true,
          keymaps = {
            smart_rename = "<Leader>trn",
          },
        },
      },
    },
    config = function(plugin, opts)
      require(plugin.main).setup(opts)
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    end,
  },
  {
    "Darazaki/indent-o-matic",
    event = "BufReadPost",
    opts = {},
  },
}
