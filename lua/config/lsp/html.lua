vim.lsp.config('html', {
  filetypes = { 'html', 'htmldjango' },
  init_options = {
    provideFormatter = true,
  },
})

vim.lsp.enable 'html'
