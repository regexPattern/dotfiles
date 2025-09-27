-- https://github.com/nvim-treesitter/nvim-treesitter
vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("treesitter.update", {}),
  command = [[TSUpdate]],
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter.setup", {}),
  callback = function(args)
    local buf = args.buf
    local filetype = args.match

    local language = vim.treesitter.language.get_lang(filetype) or filetype
    if not vim.treesitter.language.add(language) then
      return
    end

    -- vim.wo.foldmethod = "expr"
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

    vim.treesitter.start(buf, language)

    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

-- https://github.com/Darazaki/indent-o-matic
require("indent-o-matic").setup({})
