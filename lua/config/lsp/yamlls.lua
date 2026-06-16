-- Helm templates contain Go template syntax that breaks YAML parsing.
-- Classify them as 'helm' filetype so yamlls never attaches to them.
vim.filetype.add {
  pattern = {
    ['.*/templates/.*%.ya?ml'] = 'helm',
    ['.*helmfile.*%.ya?ml'] = 'helm',
  },
}

vim.lsp.config('yamlls', {
  filetypes = { 'yaml', 'yaml.docker-compose' },
  settings = {
    yaml = {
      validate = true,
      schemaStore = { enable = true, url = 'https://www.schemastore.org/api/json/catalog.json' },
    },
  },
})

vim.lsp.enable 'yamlls'
