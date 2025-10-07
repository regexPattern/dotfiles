require("render-markdown").setup({
  heading = {
    width = "block",
    left_pad = 1,
    right_pad = 1,
    icons = {},
  },
  code = {
    border = "thin",
    inline_pad = 1,
    left_pad = 1,
    language = false,
    -- highlight_border = false,
  },
  bullet = {
    enabled = false,
  },
  sign = {
    enabled = false,
  },
  overrides = { buftype = { nofile = { enabled = false } } },
})
