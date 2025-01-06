require("lspconfig.ui.windows").default_options.border = "single"

local function with_handler(handler, config)
  return function(extra_config)
    return handler(vim.tbl_deep_extend("force", config, extra_config or {}))
  end
end

vim.lsp.buf.hover = with_handler(vim.lsp.buf.hover, {
  border = "single",
  max_width = 80,
  max_height = 20,
})

vim.lsp.buf.signature_help = with_handler(vim.lsp.buf.signature_help, {
  border = "single",
  title_pos = "left",
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if not client then
      return
    end

    vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, { buffer = args.buf })
    vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, { buffer = args.buf })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = args.buf })

    vim.keymap.set("n", "<Leader>gW", function()
      vim.diagnostic.setqflist()
      vim.cmd.copen()
    end, { buffer = args.buf })

    if client:supports_method("textDocument/inlayHint", args.buf) then
      vim.lsp.inlay_hint.enable(false, { buffer = args.buf })
      vim.keymap.set("n", "<Leader>ti", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { buffer = true })
      end)
    end

    if client:supports_method("textDocument/completion", args.buf) then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = false })
    end
  end,
})
