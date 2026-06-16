return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  build = 'make',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'zbirenbaum/copilot.lua',
  },
  opts = {
    provider = 'copilot',
    providers = {
      copilot = {
        model = 'gpt-4o',
      },
    },
  },
}
