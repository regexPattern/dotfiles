vim.pack.add({
  "https://github.com/echasnovski/mini.align",
  "https://github.com/echasnovski/mini.diff",
  "https://github.com/echasnovski/mini.icons",
  "https://github.com/echasnovski/mini.surround",
})

require("mini.align").setup()
require("mini.diff").setup()
require("mini.surround").setup()

require("mini.icons").setup({
  style = "glyph",
  use_file_extension = function(ext)
    return ext:sub(-3) ~= "scm" or ext:sub(-3) ~= "lua"
  end,
})
