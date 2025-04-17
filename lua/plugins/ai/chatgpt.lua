local function init()
  local map = vim.keymap.set

  map('n', '<leader>gc', '<cmd>ChatGPT<CR>', { desc = 'ChatGPT open window' })
  map('n', '<leader>gs', '<cmd>ChatGPTRun summarize<CR>', { desc = 'ChatGPT summarize buffer' })
  map('v', '<leader>gs', '<cmd>ChatGPTRun summarize<CR>', { desc = 'ChatGPT summarize selection' })
end

return {
  'jackMort/ChatGPT.nvim',
  event = 'VeryLazy',
  opts = {
    api_key_cmd = 'cat ' .. vim.fn.stdpath 'config' .. '/.openai_api_key',
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  init = init
}
