return {
  'saghen/blink.cmp',
  version = '*',
  event = 'InsertEnter',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      dependencies = { 'rafamadriz/friendly-snippets' },
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
      end,
    },
    {
      'windwp/nvim-autopairs',
      opts = {
        fast_wrap = {},
        disable_filetype = { 'TelescopePrompt', 'vim' },
      },
    },
  },
  opts = {
    keymap = {
      preset = 'none',
      ['<Tab>'] = { 'accept', 'fallback' },
      ['<Left>'] = { 'cancel', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },
      ['<Up>'] = { 'select_prev', 'fallback' },
    },

    completion = {
      accept = {
        -- autopairs handles bracket insertion; disable blink's to avoid double-pairing
        auto_brackets = { enabled = false },
      },
      list = {
        -- first item highlighted but not inserted until Tab confirms (matches old SelectBehavior.Select)
        selection = { preselect = true, auto_insert = false },
      },
      menu = {
        border = 'rounded',
        winblend = 0,
        draw = {
          columns = { { 'kind_icon' }, { 'label', gap = 1 } },
          components = {
            label = {
              text = function(ctx)
                return require('colorful-menu').blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require('colorful-menu').blink_components_highlight(ctx)
              end,
            },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 100,
        window = {
          border = 'rounded',
          winblend = 0,
        },
      },
    },

    signature = {
      enabled = true,
      window = {
        border = 'rounded',
        winblend = 0,
      },
    },

    snippets = { preset = 'luasnip' },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
  },
}
