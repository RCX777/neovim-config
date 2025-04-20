return {
  'zbirenbaum/copilot.lua',
  dependencies = { 'hrsh7th/nvim-cmp' },
  event = 'InsertEnter',
  opts = {
    panel = {
      enabled = false,
    },
    suggestion = {
      auto_trigger = true,
      keymap = {
        accept = '<S-Tab>',
      },
    },
    filetypes = {
      ['*'] = true,
    },
  },
}

