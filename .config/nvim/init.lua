-- regexPattern's Neovim 0.12 config
-- Greatly inspired (completely stolen) from: https://github.com/nvim-mini/MiniMax/tree/70ade6783c9d45d5c81eab5a2d3ff3a62e02066e/configs/nvim-0.12

_G.Config = {}

vim.pack.add({ "https://github.com/nvim-mini/mini.misc" })

local misc = require("mini.misc")
Config.now = function(f)
  misc.safely("now", f)
end
Config.later = function(f)
  misc.safely("later", f)
end
Config.now_if_args = vim.fn.argc(-1) > 0 and Config.now or Config.later
Config.on_event = function(ev, f)
  misc.safely("event:" .. ev, f)
end

local gr = vim.api.nvim_create_augroup("custom-config", {})
Config.new_autocmd = function(event, pattern, callback)
  local opts = { group = gr, pattern = pattern, callback = callback }
  vim.api.nvim_create_autocmd(event, opts)
end

Config.on_packchanged = function(plugin_name, kinds, callback)
  local f = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if not (name == plugin_name and vim.tbl_contains(kinds, kind)) then
      return
    end
    if not ev.data.active then
      vim.cmd.packadd(plugin_name)
    end
    callback()
  end
  Config.new_autocmd("PackChanged", "*", f)
end
