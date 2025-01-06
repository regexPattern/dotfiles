vim.g.mapleader = " "

vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump { count = 1, float = true }
end)

vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump { count = -1, float = true }
end)

vim.keymap.set("n", "<C-Right>", ":vertical resize +5<CR>", { silent = true })
vim.keymap.set("n", "<C-Left>", ":vertical resize -5<CR>", { silent = true })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { silent = true })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { silent = true })

vim.keymap.set("n", "<C-j>", function()
  if not vim.tbl_isempty(vim.fn.getqflist()) then
    -- return ":try | cnext | catch | cfirst | catch | endtry<CR>"
    return ":try | cnext | catch | endtry<CR>"
  else
    return "<C-j>"
  end
end, { expr = true, silent = true })

vim.keymap.set("n", "<C-k>", function()
  if not vim.tbl_isempty(vim.fn.getqflist()) then
    -- return ":try | cprev | catch | clast | catch | endtry<CR>"
    return ":try | cprev | catch | endtry<CR>"
  else
    return "<C-k>"
  end
end, { expr = true, silent = true })
