require("lspconfig.ui.windows").default_options.border = "single"

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if not client then
      return
    end

    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover {
        border = "single",
        max_width = 80,
        max_height = 20,
      }
    end)

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
