vim.pack.add({ "https://github.com/j-hui/fidget.nvim" }, { confirm = false })

return {
  "fidget",
  event = "LspAttach",
  after = function()
    require("fidget").setup({
      notification = {
        window = {
          winblend = 0,
          max_width = 60,
        },
      },
    })
  end,
}
