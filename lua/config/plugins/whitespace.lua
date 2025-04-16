local config = {
  highlight = 'DiffDelete',
  ignored_filetypes = { 'TelescopePrompt', 'Trouble', 'help', 'dashboard' },
  ignore_terminal = true,
  return_cursor = true,
}

local function init ()
  vim.keymap.set('n', '<leader>a', require 'whitespace-nvim'.trim,
    { desc = 'Trim trailing whitespaces'}
  )
end

return {
  'johnfrankmorgan/whitespace.nvim', enable = true, lazy = false,
  opts = config,
  init = init,
}
