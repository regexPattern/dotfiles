-- https://github.com/ibhagwan/fzf-lua
local fzf = require("fzf-lua")

fzf.setup({
  winopts = {
    border = false,
    fullscreen = true,
    preview = { hidden = "hidden" },
  },
  keymap = {
    fzf = {
      ["ctrl-z"] = "abort",
      ["ctrl-q"] = "select-all+accept",
      ["ctrl-a"] = "beginning-of-line",
    },
  },
  defaults = {
    file_icons = "mini",
    hidden = true,
  },
  files = {
    actions = {
      ["ctrl-d"] = function(selected, opts)
        local path_utils = require("fzf-lua.path")
        local file_path = path_utils.entry_to_file(selected[1]).path
        local dir_path = path_utils.join({
          opts.cwd or (vim.uv or vim.loop).cwd(),
          vim.fn.fnamemodify(file_path, ":h"),
        })
        vim.cmd.edit(dir_path)
      end,
    },
  },
  fzf_opts = { ["--layout"] = "default" },
})

fzf.register_ui_select()

vim.keymap.set("n", "<Leader>ff", function()
  require("fzf-lua").files()
end)

vim.keymap.set("n", "<Leader>fe", function()
  vim.ui.input({ prompt = "Extension❯ " }, function(e)
    require("fzf-lua").files({ fd_opts = "--extension " .. e })
  end)
end)

vim.keymap.set("n", "<Leader>fg", function()
  require("fzf-lua").live_grep()
end)

vim.keymap.set("n", "<Leader>fd", function()
  require("fzf-lua").files({
    prompt = "Directories❯ ",
    fd_opts = "--type directory",
  })
end)

vim.keymap.set("n", "=z", function()
  require("fzf-lua").spell_suggest()
end)
