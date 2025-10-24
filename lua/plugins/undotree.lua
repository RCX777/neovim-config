local function init()
  local map = vim.keymap.set
  
  map('n', '<leader>u', '<cmd>UndotreeToggle<CR>', { desc = 'Toggle undo tree' })
end

return {
  'mbbill/undotree',
  cmd = 'UndotreeToggle',
  init = init,
}