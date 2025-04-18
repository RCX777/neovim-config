return {
  'Wansmer/treesj',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  keys = { '<space>j', '<space>J' },
  config = function()
    local treesj = require 'treesj'
    treesj.setup {}

    local map = vim.keymap.set

    map('n', '<leader>j', function()
      treesj.toggle { split = { recursive = false } }
    end, { desc = 'TreeJS Join/Unjoin' })

    map('n', '<leader>J', function()
      treesj.toggle { split = { recursive = true } }
    end, { desc = 'TreeJS Join/Unjoin Recursively' })
  end,
}
