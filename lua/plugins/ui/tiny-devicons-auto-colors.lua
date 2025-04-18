return {
  'rachartier/tiny-devicons-auto-colors.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'catppuccin/nvim',
  },
  event = 'VeryLazy',
  config = function()
    require('tiny-devicons-auto-colors').setup {
      colors = require('catppuccin.palettes').get_palette 'mocha',
    }
  end,
}
