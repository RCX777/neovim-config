local config = function()
  local cmp = require 'cmp'

  local ok, suggestion = pcall(require, 'copilot.suggestion')
  local copilot_enabled = true

  local tab_complete
  if ok and copilot_enabled then
    tab_complete = function(fallback)
      if suggestion.is_visible() then
        if cmp.get_selected_entry() then
          cmp.confirm { select = true }
        else
          suggestion.accept()
        end
      elseif cmp.visible() then
        cmp.confirm { select = true }
      else
        fallback()
      end
    end
  else
    tab_complete = function(fallback)
      if cmp.visible() then
        cmp.confirm { select = true }
      else
        fallback()
      end
    end
  end

  return {
    sources = {
      { name = 'nvim_lsp' },
      { name = 'buffer' },
      { name = 'nvim_lua' },
      { name = 'path' },
    },

    mapping = {
      ['<Tab>'] = cmp.mapping(tab_complete),
      ['<Left>'] = cmp.mapping.abort(),
      ['<Down>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior },
      ['<Up>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior },
    },

    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },

    formatting = {
      fields = { 'kind', 'abbr', 'menu' },

      format = function(entry, vim_item)
        local kind = require('lspkind').cmp_format {
          mode = 'symbol_text',
        }(entry, vim.deepcopy(vim_item))
        local highlights_info = require('colorful-menu').cmp_highlights(entry)

        -- highlight_info is nil means we are missing the ts parser, it's
        -- better to fallback to use default `vim_item.abbr`. What this plugin
        -- offers is two fields: `vim_item.abbr_hl_group` and `vim_item.abbr`.
        if highlights_info ~= nil then
          vim_item.abbr_hl_group = highlights_info.highlights
          vim_item.abbr = highlights_info.text
        end
        local strings = vim.split(kind.kind, '%s', { trimempty = true })
        vim_item.kind = ' ' .. (strings[1] or '') .. ' '
        vim_item.menu = ''

        return vim_item
      end,
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

    -- ui plugins
    {
      'xzbdmw/colorful-menu.nvim',
      'onsails/lspkind.nvim',
    },
  },
  opts = config,
}
