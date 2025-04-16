local function configure_mappings()
  local map = vim.keymap.set

  map('n', 'gD', vim.lsp.buf.declaration, { desc = 'LSP: Go to declaration' })
  map('n', 'gd', vim.lsp.buf.definition, { desc = 'LSP: Go to definition' })
end

local function init()
  vim.diagnostic.config {
    virtual_lines = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  }

  -- Set up borders for floating windows
  local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
  ---@diagnostic disable-next-line: duplicate-set-field
  vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = 'rounded'
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
  end

  require 'config.lsp.lua'
  require 'config.lsp.clangd'
  require 'config.lsp.basedpyright'

  configure_mappings()
end

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'williamboman/mason.nvim',
  },
  init = init,
}
