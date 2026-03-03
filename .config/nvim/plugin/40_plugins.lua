-- mini.nvim modules
Config.later(function()
  vim.pack.add({
    "https://github.com/nvim-mini/mini.align",
    "https://github.com/nvim-mini/mini.icons",
    "https://github.com/nvim-mini/mini.surround",
  })

  require("mini.align").setup({})
  require("mini.icons").setup({})
  require("mini.surround").setup({})
end)

-- treesitter
Config.now_if_args(function()
  vim.pack.add({
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/Darazaki/indent-o-matic",
  })

  Config.on_packchanged("nvim-treesitter", { "update" }, function()
    vim.cmd([[TSUpdate]])
  end)

  require("indent-o-matic").setup({})

  -- Auto-install missing parsers
  -- Stolen from: https://github.com/nvim-treesitter/nvim-treesitter/discussions/7927#discussioncomment-15398263
  Config.new_autocmd("FileType", "*", function(args)
    local ft = vim.bo[args.buf].filetype
    local lang = vim.treesitter.language.get_lang(ft)

    if not lang then
      return
    end

    if not vim.treesitter.language.add(lang) then
      local available = vim.g.ts_available or require("nvim-treesitter").get_available()
      if not vim.g.ts_available then
        vim.g.ts_available = available
      end
      if vim.tbl_contains(available, lang) then
        require("nvim-treesitter").install(lang, { summary = true })
      end
    end

    if vim.treesitter.language.add(lang) then
      vim.treesitter.start(args.buf, lang)
      if vim.treesitter.query.get(lang, "indents") then
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end
  end)
end)

-- LSP
Config.later(function()
  vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/j-hui/fidget.nvim",
  })

  vim.lsp.enable({
    "golangci_lint_ls",
    "gopls",
    "jsonls",
    "lua_ls",
    "rust_analyzer",
    "svelte",
    "tailwindcss",
    "ts_ls",
  })

  Config.new_autocmd("LspAttach", "*", function()
    require("fidget").setup({})
  end)

  Config.new_autocmd("LspProgress", "*", function(ev)
    local value = ev.data.params.value or {}
    local msg = value.message or "done"
    vim.api.nvim_echo({ { msg } }, false, {
      id = "lsp",
      kind = "progress",
      title = value.title,
      status = value.kind ~= "end" and "running" or "success",
      percent = value.percentage,
    })
  end)
end)

-- conform.nvim
Config.later(function()
  vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

  require("conform").setup({
    default_format_opts = {
      lsp_format = "fallback",
    },
  })

  vim.api.nvim_create_user_command("Indent", function()
    vim.cmd([[norm mqHmwgg=G`wzt`q]])
  end, {})

  vim.keymap.set({ "n", "x" }, "<Leader>x", ":Indent<CR>")
end)

-- oil.nvim
Config.later(function()
  vim.pack.add({ "https://github.com/stevearc/oil.nvim" })

  require("oil").setup({
    default_file_explorer = true,
    columns = {
      "icon",
      -- "size",
      -- "mtime",
    },
    skip_confirm_for_simple_edits = true,
    view_options = { show_hidden = true },
    keymaps = {
      ["<Leader>y"] = function()
        require("oil.actions").yank_entry.callback()
        vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
      end,
    },
  })

  vim.keymap.set("n", "-", ":Oil<CR>")
end)

-- fzf.lua
Config.later(function()
  vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })

  require("fzf-lua").setup({
    winopts = {
      border = false,
      fullscreen = true,
      preview = { border = "single" },
    },
  })

  require("fzf-lua").register_ui_select()

  vim.keymap.set("n", "<Leader>ff", ":FzfLua files<CR>")
  vim.keymap.set("n", "<Leader>gr", ":FzfLua live_grep<CR>")
  vim.keymap.set("n", "<Leader>wd", ":FzfLua diagnostics_workspace<CR>")
  vim.keymap.set("n", "z=", ":FzfLua spell_suggest<CR>")

  vim.keymap.set({ "n", "v", "i" }, "<C-x><C-f>", function()
    require("fzf-lua").complete_path()
  end)
end)
