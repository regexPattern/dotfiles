vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/b0o/SchemaStore.nvim",
}, { confirm = false })

return {
  "lspconfig",
  event = "BufReadPre",
  after = function()
    local servers = vim.api.nvim_get_runtime_file([[lsp/\(volar\|glint\)\@!*.lua]], true)
    vim.lsp.enable(vim.tbl_map(function(s)
      return vim.fn.fnamemodify(s, ":t:r")
    end, servers))
  end,
}
