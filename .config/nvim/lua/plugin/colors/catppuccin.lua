return {
  name = "catppuccin",
  lazy = {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function(spec)
      require(spec.name).setup({
        background = {
          light = "latte",
          dark = "mocha",
        },
        transparent_background = false,
        show_end_of_buffer = true,
        styles = {
          comments = {},
          conditionals = {},
        },
        custom_highlights = function()
          return {
            netrwMarkFile = { style = { "reverse" } },
          }
        end,
      })
    end,
  },
  setup = function()
    vim.cmd([[colorscheme catppuccin]])
  end,
}
