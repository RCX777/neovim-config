return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  init = function()
    vim.cmd.colorscheme 'catppuccin-mocha'
  end,
  opts = {
    flavour = 'mocha',
    transparent_background = true,
    term_colors = true,
    styles = {
      comments = { 'italic' },
      conditionals = {},
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = { 'bold', 'italic' },
      operators = {},
    },
    integrations = {
      gitsigns = true,
      telescope = true,
      treesitter = true,
      cmp = true,
    },
  },
}
