return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "b0o/SchemaStore.nvim",
      {
        "williamboman/mason.nvim",
        dependencies = { "williamboman/mason-lspconfig.nvim" },
        cmd = "Mason",
        opts = {
          ui = { border = "single" },
        },
      },
    },
    config = function()
      require "plugin.non-minimal.lspconfig.setup"

      local lspconfig = require "lspconfig"
      local server_configs = require "plugin.non-minimal.lspconfig.server_configs"

      require("mason-lspconfig").setup {
        handlers = {
          function(server)
            local opts = server_configs[server] or {}
            lspconfig[server].setup(opts)
          end,
        },
      }
    end,
  },
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      notification = {
        window = {
          winblend = 0,
          max_width = 60,
        },
      },
    },
  },
  {
    "felpafel/inlay-hint.nvim",
    event = "LspAttach",
    opts = {},
  },
}
