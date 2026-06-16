local bufnr = vim.api.nvim_get_current_buf()
vim.schedule(function()
  vim.bo[bufnr].syntax = 'yaml'
end)
