return {
  "folke/todo-comments.nvim",
  event = { "BufReadPost" },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    signs = false,
    highlight = {
      after = "",
      keyword = "bg",
    },
  },
  keys = {
    { "<Leader>td", ":TodoFzfLua<CR>", silent = true },
  },
}
