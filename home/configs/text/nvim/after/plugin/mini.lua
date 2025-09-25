-- https://github.com/echasnovski/mini.align
require("mini.align").setup({})

-- https://github.com/echasnovski/mini.icons
require("mini.icons").setup({
  style = "glyph",
  use_file_extension = function(ext)
    return ext:sub(-3) ~= "scm" or ext:sub(-3) ~= "lua"
  end,
})

-- https://github.com/echasnovski/mini.surround
require("mini.surround").setup({})
