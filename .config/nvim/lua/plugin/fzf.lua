return {
  "ibhagwan/fzf-lua",
  dependencies = { "mini.icons" },
  cmd = "FzfLua",
  event = "LspAttach",
  config = function()
    local fzf = require("fzf-lua")

    fzf.setup({
      winopts = {
        border = false,
        fullscreen = true,
        preview = {
          hidden = "hidden",
        },
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
      },
      files = {
        actions = {
          ["ctrl-g"] = { require("fzf-lua.actions").toggle_ignore },
          ["ctrl-d"] = function(selected, opts)
            local path_utils = require("fzf-lua.path")
            local file_path = path_utils.entry_to_file(selected[1]).path
            local dir_path = path_utils.join({
              ---@diagnostic disable-next-line: undefined-field
              opts.cwd or (vim.uv or vim.loop).cwd(),
              vim.fn.fnamemodify(file_path, ":h"),
            })
            vim.cmd.edit(dir_path)
          end,
        },
      },
      fzf_opts = { ["--layout"] = "default" },
      file_icon_padding = " ",
    })

    fzf.register_ui_select()
  end,
  keys = {
    { "<Leader>ff", ":FzfLua files<CR>" },
    { "<Leader>fb", ":FzfLua buffers<CR>" },
    {
      "<Leader>fe",
      function()
        vim.ui.input({ prompt = "Extension: " }, function(input)
          -- TODO: handle errors properly
          require("fzf-lua").files({ fd_opts = "-e " .. input })
        end)
      end,
    },
    { "<Leader>fg", ":FzfLua grep<CR>" },
    { "<Leader>fd", ":FzfLua files fd_opts=--hidden\\ --type\\ d<CR>" },
    { "<Leader>nv", ":FzfLua files cwd=" .. vim.fn.stdpath("config") .. "<CR>" },
    { "<Leader>fr", ":FzfLua lsp_references<CR>" },
    { "=z", ":FzfLua spell_suggest<CR>" },
  },
}
