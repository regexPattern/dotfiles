function Statusline_bufname()
  if vim.bo.filetype == "oil" then
    return require("oil").get_current_dir(nil)
  end
  local output
  local bufname = vim.fn.bufname("%")
  if vim.bo.buftype == "" and bufname ~= "" then
    output = vim.fn.expand("%:.")
  else
    output = bufname == "" and "[No Name]" or vim.fn.expand("%:t")
  end
  return output
end

function Statusline_rec_status()
  local output = ""
  local reg = vim.fn.reg_recording()
  if reg ~= "" then
    output = "recording @" .. reg .. "%="
  end
  return output
end

---@diagnostic disable: undefined-field
vim.opt.statusline = [[%<%{%v:lua.Statusline_bufname()%}]]
vim.opt.statusline:append([[ ]])
vim.opt.statusline:append([[%h%w%m%r]])
vim.opt.statusline:append([[%=]])
vim.opt.statusline:append([[%{%v:lua.Statusline_rec_status()%}%{execute('redrawstatus')}]])
vim.opt.statusline:append([[%-14.(%l,%c%V%) %P]])
