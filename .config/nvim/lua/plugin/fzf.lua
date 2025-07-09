return {
  "ibhagwan/fzf-lua",
  dependencies = { "mini.icons" },
  cmd = { "FzfLua" },
  event = { "LspAttach" },
  config = function()
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
  end,
  keys = {
    {
      "<Leader>ff",
      function()
        require("fzf-lua").files()
      end,
    },
    {
      "<Leader>fe",
      function()
        vim.ui.input({ prompt = "Extension❯ " }, function(e)
          require("fzf-lua").files({ fd_opts = "--extension " .. e })
        end)
      end,
    },
    {
      "<Leader>fg",
      function()
        require("fzf-lua").live_grep()
      end,
    },
    {
      "<Leader>fd",
      function()
        require("fzf-lua").files({
          prompt = "Directories❯ ",
          fd_opts = "--type directory",
        })
      end,
    },
    {
      "<Leader>nv",
      function()
        require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
      end,
    },
    {
      "=z",
      function()
        require("fzf-lua").spell_suggest()
      end,
    },
  },
}
