-- EXAMPLE
local on_attach = require 'nvchad.configs.lspconfig'.on_attach
local on_init = require 'nvchad.configs.lspconfig'.on_init
local capabilities = require 'nvchad.configs.lspconfig'.capabilities

local lspconfig = require 'lspconfig'
local servers = {
  'basedpyright',
  'nixd',
  'hls',
  'rust_analyzer',
  'bashls'
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

lspconfig.clangd.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--completion-style=bundled',
    '--function-arg-placeholders=0'
  },
}

lspconfig.omnisharp.setup {
  cmd = { 'dotnet', os.getenv('HOME') .. '/.local/share/omnisharp/OmniSharp.dll' },
  settings = {
    FormattingOptions = {
      EnableEditorConfigSupport = true
    }
  }
}

