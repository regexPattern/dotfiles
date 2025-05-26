vim.keymap.set("n", "<C-Right>", ":vert res +5<CR>", { silent = true })
vim.keymap.set("n", "<C-Left>", ":vert res -5<CR>", { silent = true })
vim.keymap.set("n", "<C-Up>", ":res +2<CR>", { silent = true })
vim.keymap.set("n", "<C-Down>", ":res -2<CR>", { silent = true })

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
