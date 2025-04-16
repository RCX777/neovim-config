local map = vim.keymap.set

-- Comment
map('n', '<leader>/', 'gcc', { desc = 'toggle comment', remap = true })
map('v', '<leader>/', 'gc', { desc = 'toggle comment', remap = true })

map('v', '<M-Down>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
map('v', '<M-Up>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

map('n', '<leader>y', '"+y', { desc = 'Yank into `+` register' })
map('v', '<leader>y', '"+y', { desc = 'Yank selection into `+` register' })
map('n', '<leader>y', '"+Y', { desc = 'Yank into `+` register' })

map('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {
  desc = 'Replace all occurences of word under cursor',
})

map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { desc = 'Code action' })

