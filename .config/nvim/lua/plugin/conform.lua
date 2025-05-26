return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  config = function()
    -- Re-use formatters for the given filetypes.
    local function common_fmtrs(fts, fmtrs)
      local conform_setup = {}
      for _, ft in ipairs(fts) do
        conform_setup[ft] = fmtrs
      end
      return conform_setup
    end

    require("conform").setup({
      formatters_by_ft = vim.tbl_extend(
        "force",
        {
          fish = { "fish_indent" },
          go = {
            "gofmt",
            "goimports",
          },
          lua = { "stylua" },
          sql = { "pg_format" },
        },
        common_fmtrs({
          "css",
          "html",
          "javascript",
          "javascriptreact",
          "json",
          "svelte",
          "typescript",
          "typescriptreact",
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
      -- If formatting with conform failed (e.g. when there is no formatter
      -- available for the given filetype), format using Vim's reindentation.
      if not require("conform").format({ quiet = true }) then
        vim.cmd([[norm mqHmwgg=G`wzt`q]])
      end
    end, {})
  end,
  keys = {
    { "<Leader>x", ":Format<CR>", silent = true },
  },
}
