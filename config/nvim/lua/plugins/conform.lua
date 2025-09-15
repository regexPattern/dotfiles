vim.pack.add({ "https://github.com/stevearc/conform.nvim" }, { confirm = false })

local function common_formatter(filetypes, formatter)
  local conform_setup = {}
  for _, ft in ipairs(filetypes) do
    conform_setup[ft] = formatter
  end
  return conform_setup
end

vim.api.nvim_create_user_command("Format", function()
  -- If formatting with conform failed (e.g. when there is no formatter
  -- available for the given filetype), format using Vim's reindentation.
  if not require("conform").format({ quiet = true }) then
    vim.cmd([[norm mqHmwgg=G`wzt`q]])
  end
end, {})

return {
  "conform",
  cmd = { "ConformInfo" },
  event = { "BufReadPost" },
  keys = { { "<Leader>x", vim.cmd.Format } },
  after = function()
    require("conform").setup({
      formatters_by_ft = vim.tbl_extend(
        "force",
        {
          nix = { "alejandra" },
          fish = { "fish_indent" },
          go = { "golangci-lint" },
          lua = { "stylua" },
          sql = { "pg_format" },
        },
        common_formatter({
          "css",
          "html",
          "javascript",
          "javascriptreact",
          "json",
          "svelte",
          "typescript",
          "typescriptreact",
          "markdown",
        }, { "prettierd" })
      ),
      default_format_opts = {
        lsp_format = "fallback",
        stop_after_first = true,
      },
    })
  end,
}
