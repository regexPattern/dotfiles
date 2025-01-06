return {
  "olimorris/codecompanion.nvim",
  cmdn = { "CodeCompanionChat" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "fzf-lua",
  },
  opts = {
    strategies = {
      chat = {
        adapter = "openai",
        keymaps = {
          completion = {
            modes = { i = "<C-X><C-O>" },
          },
        },
      },
    },
    display = {
      chat = { show_settings = true },
    }
  },
  keys = {
    { "<Leader>ai", ":CodeCompanionChat Toggle<CR>" },
  },
}
