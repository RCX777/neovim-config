vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = true,
      },
    },
  },
})

vim.lsp.enable 'rust_analyzer'
