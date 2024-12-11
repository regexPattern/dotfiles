return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  config = function()
    local function common_formatters(filetypes, formatters)
      local conform_setup = {}
      for _, ft in ipairs(filetypes) do
        conform_setup[ft] = formatters
      end
      return conform_setup
    end

    require("conform").setup({
      formatters_by_ft = vim.tbl_extend(
        "force",
        {
          go = { "goimports", "gofmt" },
          lua = { "stylua" },
          sql = { "pg_format" },
        },
        common_formatters({
          "css",
          "html",
          "javascript",
          "json",
          "typescript",
        }, { "prettierd" })
      ),
      default_format_opts = {
        lsp_format = "fallback",
        stop_after_first = true,
      },
    })
  end,
  init = function()
    vim.api.nvim_create_user_command("Format", function()
      if not require("conform").format({ quiet = true }) then
        vim.cmd([[normal mqHmwgg=G`wzt`q]])
      end
    end, {})
  end,
  keys = {
    { "<Leader>x", ":Format<CR>" },
  },
}
