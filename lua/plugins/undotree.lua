local function init()
  vim.keymap.set('n', '<leader>u', '<cmd>UndotreeToggle<CR>', { desc = 'Toggle undo tree' })
end

return {
  'mbbill/undotree',
  cmd = 'UndotreeToggle',
  init = init,
}

