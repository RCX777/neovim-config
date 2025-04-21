vim.lsp.config('ts_ls', {
  on_attach = function(client, _) client.server_capabilities.documentFormattingProvider = false end,
  filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  cmd = { 'typescript-language-server', '--stdio' },
})

vim.lsp.enable 'ts_ls'
