return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufEnter" },
    init = function()
      local server_configs = vim.api.nvim_get_runtime_file("lsp/*.lua", true)
      local server_names = vim.tbl_map(function(s)
        return vim.fn.fnamemodify(s, ":t:r")
      end, server_configs)
      vim.lsp.enable(server_names)
    end,
  },
  { "b0o/SchemaStore.nvim" },
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
}
