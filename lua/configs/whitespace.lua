local whitespace_nvim = require 'whitespace-nvim'

vim.keymap.set('n', '<leader>a', whitespace_nvim.trim,
  { desc = 'Trim trailing whitespaces'}
)

return whitespace_nvim.setup {
  highlight = '@comment.danger',
  ignored_filetypes = { 'TelescopePrompt', 'Trouble', 'help', 'dashboard' },
  ignore_terminal = true,
  return_cursor = true,
}

