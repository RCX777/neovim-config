local config = function()
  local cmp = require 'cmp'

  return {
    sources = {
      { name = 'nvim_lsp' },
      { name = 'buffer' },
      { name = 'nvim_lua' },
      { name = 'path' },
    },

    mapping = {
      ['<Tab>'] = cmp.mapping(function(fallback)
        local ok, suggestion = pcall(require, 'copilot.suggestion')

        if ok and suggestion.is_visible() then
          if cmp.get_selected_entry() then
            cmp.confirm { select = false }
          else
            suggestion.accept()
          end
        elseif cmp.visible() then
          cmp.confirm { select = true }
        else
          fallback()
        end
      end, {'i', 'c'}),

      ['<Left>'] = cmp.mapping.abort(),
      ['<Down>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior },
      ['<Up>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior },
    },

    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
  }
end

return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    -- autopairing of (){}[] etc
    {
      'windwp/nvim-autopairs',
      opts = {
        fast_wrap = {},
        disable_filetype = { 'TelescopePrompt', 'vim' },
      },
      config = function(_, opts)
        require('nvim-autopairs').setup(opts)

        -- setup cmp for autopairs
        local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
        require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done())
      end,
    },

    -- cmp sources plugins
    {
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
    },
  },
  opts = config,
}
