local function init()
  local map = vim.keymap.set

  map('n', '<C-h>', '<cmd> TmuxNavigateLeft<CR>', { desc = 'window left' })
  map('n', '<C-l>', '<cmd> TmuxNavigateRight<CR>', { desc = 'window right' })
  map('n', '<C-j>', '<cmd> TmuxNavigateDown<CR>', { desc = 'window down' })
  map('n', '<C-k>', '<cmd> TmuxNavigateUp<CR>', { desc = 'window up' })
end

return {
  'christoomey/vim-tmux-navigator',
  enable = true,
  lazy = false,
  init = init,
}
