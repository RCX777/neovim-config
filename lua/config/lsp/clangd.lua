vim.lsp.config('clangd', {
  cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--completion-style=bundled',
    '--function-arg-placeholders=0'
  },
})

vim.lsp.enable('clangd')

