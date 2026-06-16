return {
  'folke/snacks.nvim',
  lazy = false,
  priority = 950,
  opts = {
    input = {},
    words = { enabled = true },
    lazygit = {},
    explorer = {},
    picker = {
      ui_select = true,
    },
  },
  init = function()
    local map = vim.keymap.set

    -- Picker (replaces Telescope)
    map('n', '<leader>ff', function() Snacks.picker.files() end, { desc = 'Find files' })
    map('n', '<leader>fw', function() Snacks.picker.grep() end, { desc = 'Live grep' })
    map('n', '<leader>fb', function() Snacks.picker.buffers() end, { desc = 'Find buffers' })
    map('n', '<leader>fh', function() Snacks.picker.help() end, { desc = 'Help tags' })
    map('n', '<leader>fo', function() Snacks.picker.recent() end, { desc = 'Recent files' })
    map('n', '<leader>fz', function() Snacks.picker.lines() end, { desc = 'Search current buffer' })
    map('n', '<leader>ma', function() Snacks.picker.marks() end, { desc = 'Find marks' })
    map('n', '<leader>gc', function() Snacks.picker.git_log() end, { desc = 'Git commits' })
    map('n', '<leader>gs', function() Snacks.picker.git_status() end, { desc = 'Git status' })
    map('n', '<leader>fa', function() Snacks.picker.files { hidden = true, ignored = true } end, { desc = 'Find all files' })

    -- Explorer (replaces nvim-tree)
    map('n', '<C-n>', function() Snacks.explorer() end, { desc = 'Toggle explorer' })
    map('n', '<leader>e', function() Snacks.explorer() end, { desc = 'Focus explorer' })

    -- Lazygit (replaces lazygit.nvim)
    if vim.fn.executable 'lazygit' == 1 then
      map('n', '<leader>gg', function() Snacks.lazygit() end, { desc = 'LazyGit' })
      map('n', '<leader>gr', function() Snacks.lazygit.log() end, { desc = 'LazyGit reflog' })
    end
  end,
}
