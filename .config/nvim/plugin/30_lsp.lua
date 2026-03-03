local function custom_on_attach(client, bufnr)
  if client:supports_method("textDocument/inlayHint") then
    vim.keymap.set("n", "gti", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, { buffer = bufnr })
  end
end

Config.new_autocmd("LspAttach", "*", function(ev)
  local client = vim.lsp.get_client_by_id(ev.data.client_id)
  if not client then
    return
  end
  custom_on_attach(client, ev.buf)
end)

vim.lsp.handlers["client/registerCapability"] = (function(overridden)
  return function(err, res, ctx)
    local result = overridden(err, res, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    if not client then
      return
    end
    for bufnr, _ in pairs(client.attached_buffers) do
      custom_on_attach(client, bufnr)
    end
    return result
  end
end)(vim.lsp.handlers["client/registerCapability"])
