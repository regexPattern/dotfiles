function Statusline_bufname()
  if vim.bo.filetype == "oil" then
    return require("oil").get_current_dir()
  end

  local bufname = vim.fn.bufname("%")
  if vim.bo.buftype == "" and bufname ~= "" then
    return vim.fn.expand("%:.")
  end

  return bufname == "" and "[No Name]" or vim.fn.expand("%:t")
end

-- function Statusline_rec_status()
--   local reg = vim.fn.reg_recording()
--   return reg ~= "" and "recording @" .. reg .. "%=" or ""
-- end

---@diagnostic disable: undefined-field
vim.opt.statusline = [[%<%{%v:lua.Statusline_bufname()%}]]
vim.opt.statusline:append([[ ]])
vim.opt.statusline:append([[%h%w%m%r]])
vim.opt.statusline:append([[%=]])
-- vim.opt.statusline:append([[%{%v:lua.Statusline_rec_status()%}%{execute('redrawstatus')}]])
vim.opt.statusline:append([[%-14.(%l,%c%V%) %P]])
