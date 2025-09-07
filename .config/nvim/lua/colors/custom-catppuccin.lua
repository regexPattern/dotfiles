vim.pack.add({
  {
    src = "https://github.com/catppuccin/nvim",
    name = "catppuccin",
  },
})

require("catppuccin").setup({
  transparent_background = true,
  float = { transparent = true },
  show_end_of_buffer = true,
  no_italic = true,
  auto_integrations = false,
})

vim.cmd.colo("catppuccin")
