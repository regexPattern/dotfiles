vim.pack.add({ "https://github.com/echasnovski/mini.icons" }, { confirm = false })

return {
  "mini.icons",
  after = function()
    require("mini.icons").setup({
      style = "glyph",
      use_file_extension = function(ext)
        return ext:sub(-3) ~= "scm" or ext:sub(-3) ~= "lua"
      end,
    })
  end,
}
