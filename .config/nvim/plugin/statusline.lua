function Statusline_bufname()
  local output
  local bufname = vim.fn.bufname "%"
  if vim.bo.buftype == "" and bufname ~= "" then
    output = vim.fn.expand "%:."
  else
    output = bufname == "" and "[No Name]" or vim.fn.expand "%:t"
  end
  return output
end

function Statusline_reg_recorded()
  local output = ""
  local reg = vim.fn.reg_recording()
  if reg ~= "" then
    output = "recording @" .. reg .. "%="
  end
  return output
end

vim.opt.statusline = ""

---@diagnostic disable: undefined-field
vim.opt.statusline:append [[%<%{%v:lua.Statusline_bufname()%}]]
vim.opt.statusline:append [[ ]]
vim.opt.statusline:append [[%h%w%m%r]]
vim.opt.statusline:append [[%=]]
vim.opt.statusline:append [[%{%v:lua.Statusline_reg_recorded()%}]]
vim.opt.statusline:append [[%-14.(%l,%c%V%) %P]]
