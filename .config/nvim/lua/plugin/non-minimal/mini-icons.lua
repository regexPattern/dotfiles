return {
  "echasnovski/mini.icons",
  opts = {
    style = "glyph",
    ---@diagnostic disable-next-line: unused-local
    use_file_extension = function(ext, file)
      return ext:sub(-3) ~= "scm" or ext:sub(-3) ~= "lua"
    end,
  },
}
