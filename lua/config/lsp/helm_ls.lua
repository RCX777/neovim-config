vim.lsp.config('helm_ls', {
  filetypes = { 'helm' },
  settings = {
    ['helm-ls'] = {
      yamlls = {
        path = 'yaml-language-server',
      },
    },
  },
})

vim.lsp.enable 'helm_ls'
