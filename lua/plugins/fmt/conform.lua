local function init()
  vim.keymap.set(
    'n',
    '<leader>fm',
    function() require('conform').format { lsp_format = 'fallback' } end,
    { desc = 'general format file' }
  )
end

return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'ruff' },
    },
  },
  init = init,
}
