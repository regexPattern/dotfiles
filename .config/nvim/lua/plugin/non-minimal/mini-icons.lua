return {
  "echasnovski/mini.icons",
  opts = {
    use_file_extension = function(ext)
      return ext:sub(-3) ~= "scm" or ext:sub(-3) ~= "lua"
    end
  },
}
