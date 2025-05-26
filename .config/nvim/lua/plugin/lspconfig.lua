return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufEnter" },
    config = function()
      vim.lsp.enable({
        "gopls",
        "jsonls",
        "lua_ls",
        "rust_analyzer",
        "svelte",
        "tailwindcss",
        "ts_ls",
      })
    end,
  },
  { "b0o/SchemaStore.nvim" },
}
