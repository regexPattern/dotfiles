-- https://github.com/stevearc/oil.nvim
require("oil").setup({
  default_file_explorer = true,
  columns = { "icon" },
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,
  lsp_file_methods = { autosave_changes = false },
  view_options = { show_hidden = true },
  float = {
    padding = 0,
    border = "single",
  },
  confirmation = { min_height = 1 },
  keymaps = { ["Y"] = "actions.yank_entry" },
})

vim.keymap.set("n", "-", function()
  require("oil").open()
end)
