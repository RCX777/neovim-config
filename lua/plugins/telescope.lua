local function config()
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')

  local function yank_selected_entry(prompt_bufnr)
    local selection = action_state.get_selected_entry()
    if selection then
      local value = selection.value or selection[1] or selection.filename or tostring(selection)
      vim.fn.setreg('+', value)
      vim.fn.setreg('"', value)
      vim.notify('Yanked: ' .. value)
    end
    actions.close(prompt_bufnr)
  end

  return {
    defaults = {
      prompt_prefix = '   ',
      selection_caret = ' ',
      entry_prefix = ' ',
      sorting_strategy = 'ascending',
      layout_config = {
        horizontal = {
          prompt_position = 'top',
          preview_width = 0.55,
        },
        width = 0.87,
        height = 0.80,
      },
      mappings = {
        i = {
          ['<C-c>'] = yank_selected_entry,
        },
        n = {
          ['q'] = actions.close,
          ['<C-c>'] = yank_selected_entry,
          ['y'] = yank_selected_entry,
        },
      },
    },

    extensions_list = { 'themes', 'terms' },
    extensions = {},
  }
end

local function init()
  local map = vim.keymap.set

  map('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { desc = 'telescope find files' })
  map('n', '<leader>fw', '<cmd>Telescope live_grep<CR>', { desc = 'telescope live grep' })
  map('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { desc = 'telescope find buffers' })
  map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', { desc = 'telescope help page' })
  map('n', '<leader>ma', '<cmd>Telescope marks<CR>', { desc = 'telescope find marks' })
  map('n', '<leader>fo', '<cmd>Telescope oldfiles<CR>', { desc = 'telescope find oldfiles' })
  map('n', '<leader>fz', '<cmd>Telescope current_buffer_fuzzy_find<CR>', { desc = 'telescope find in current buffer' })
  map('n', '<leader>gc', '<cmd>Telescope git_commits<CR>', { desc = 'telescope git commits' })
  map('n', '<leader>gs', '<cmd>Telescope git_status<CR>', { desc = 'telescope git status' })
  map('n', '<leader>pt', '<cmd>Telescope terms<CR>', { desc = 'telescope pick hidden term' })
  map(
    'n',
    '<leader>fa',
    '<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>',
    { desc = 'telescope find all files' }
  )
end

return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  cmd = 'Telescope',
  opts = config,
  init = init,
}
