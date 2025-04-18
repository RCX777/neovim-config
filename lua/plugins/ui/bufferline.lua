return {
  'akinsho/bufferline.nvim',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    vim.opt.termguicolors = true

    local bufferline = require 'bufferline'
    bufferline.setup {
      options = {
        diagnostics = 'nvim_lsp',

        buffer_close_icon = '',
        close_icon = '',
        indicator = {
          style = 'none',
        },
        separator_style = { ' ', ' ' },
      },
    }
  end,
}
