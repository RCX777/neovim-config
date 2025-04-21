vim.filetype.add {
  extension = {
    jinja = 'jinja',
    jinja2 = 'jinja',
    j2 = 'jinja',
  },
}

vim.lsp.config('jinja_lsp', {
  filetypes = { 'jinja', 'jinja2', 'j2', 'html', 'htmldjango' },
})

vim.lsp.enable 'jinja_lsp'
