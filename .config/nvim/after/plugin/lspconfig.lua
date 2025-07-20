vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/b0o/SchemaStore.nvim",
  "https://github.com/j-hui/fidget.nvim",
})

local servers = vim.api.nvim_get_runtime_file([[lsp/\(volar\)\@!*.lua]], true)

vim.lsp.enable(vim.tbl_map(function(s)
  return vim.fn.fnamemodify(s, ":t:r")
end, servers))

vim.api.nvim_create_autocmd("LspAttach", {
  once = true,
  pattern = "*",
  callback = function()
    require("fidget").setup({
      notification = {
        window = {
          winblend = 0,
          max_width = 60,
        },
      },
    })
  end,
})
