local function configure_mappings ()
  local map = vim.keymap.set

  map("n", "gD", vim.lsp.buf.declaration, { desc = "LSP: Go to declaration" })
  map("n", "gd", vim.lsp.buf.definition, { desc = "LSP: Go to definition" })
end

local function init ()
  vim.diagnostic.config({
    virtual_lines = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  })

  require 'config.lsp.lua'
  require 'config.lsp.clangd'
  require 'config.lsp.basedpyright'

  configure_mappings()
end

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'williamboman/mason.nvim'
  },
  init = init
}

