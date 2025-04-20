local api_key_path = vim.fn.stdpath 'config' .. '/secrets/openai.key'

if vim.fn.filereadable(api_key_path) == 0 then
  vim.notify(
    'ChatGPT: OpenAI API key not found. To use the plugin, please create a file at ' .. api_key_path,
    vim.log.levels.INFO
  )
  vim.notify(
    'To disable this message, check out `' .. vim.fn.stdpath 'config' .. '/lua/plugins/ai/chatgpt.lua`',
    vim.log.levels.INFO
  )
  return {}
end

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
    api_key_cmd = 'cat ' .. api_key_path,
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  init = init,
}
