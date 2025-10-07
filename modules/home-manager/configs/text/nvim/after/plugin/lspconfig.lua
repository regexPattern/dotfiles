-- https://github.com/neovim/nvim-lspconfig
vim.api.nvim_create_autocmd("BufReadPre", {
  group = vim.api.nvim_create_augroup("lspconfig.setup", {}),
  once = true,
  callback = function()
    local servers = vim.api.nvim_get_runtime_file([[lsp/\(volar\|glint\)\@!*.lua]], true)
    vim.lsp.enable(vim.tbl_map(function(s)
      return vim.fn.fnamemodify(s, ":t:r")
    end, servers))
  end,
})

-- https://github.com/j-hui/fidget.nvim
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("fidget.setup", {}),
  once = true,
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
