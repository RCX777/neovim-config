local function configure_mappings()
  local map = vim.keymap.set

  local function goto_definition_with_fallback()
    local params = vim.lsp.util.make_position_params(0, 'utf-8')

    vim.lsp.buf_request(0, 'textDocument/definition', params, function(err, result, _, _)
      if err then
        vim.notify('LSP: Error on definition request: ' .. err.message, vim.log.levels.ERROR)
        return
      end
      if not result or vim.tbl_isempty(result) then
        vim.notify 'LSP: No definition found'
        return
      end

      if #result == 1 then
        vim.lsp.util.show_document(result[1], 'utf-8')
      else
        require('telescope.builtin').lsp_definitions()
      end
    end)
  end

  map('n', 'gD', vim.lsp.buf.declaration, { desc = 'LSP: Go to declaration' })
  map('n', 'gd', goto_definition_with_fallback, { desc = 'LSP: Go to definition' })

  ---@param direction 'next' | 'prev'
  local function diagnostic_goto(direction)
    local get_diagnostic
    if direction == 'next' then
      get_diagnostic = vim.diagnostic.get_next
    elseif direction == 'prev' then
      get_diagnostic = vim.diagnostic.get_prev
    end
    return function()
      vim.diagnostic.jump { diagnostic = get_diagnostic() }
    end
  end

  map('n', ']d', diagnostic_goto 'next', { desc = 'Go to next diagnostic' })
  map('n', '[d', diagnostic_goto 'prev', { desc = 'Go to previous diagnostic' })
end

local function init()
  vim.diagnostic.config {
    virtual_lines = {
      current_line = true,
      format = function(diagnostic)
        local icon = ''
        if diagnostic.source:match 'Lua' then
          icon = ' '
        elseif diagnostic.source:match 'clang' then
          icon = ' '
        elseif diagnostic.source:match 'pyright' then
          icon = ' '
        end
        local message = string.format('%s %s', icon, diagnostic.message)
        return message
      end,
    },
    underline = {
      severity = {
        min = vim.diagnostic.severity.HINT,
        max = vim.diagnostic.severity.ERROR,
      },
    },
    update_in_insert = false,
    severity_sort = true,
  }

  -- Set up borders for floating windows
  local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
  ---@diagnostic disable-next-line: duplicate-set-field
  vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = 'rounded'
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
  end

  require 'config.lsp.lua'
  require 'config.lsp.clangd'
  require 'config.lsp.basedpyright'
  require 'config.lsp.ts_ls'

  configure_mappings()
end

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'williamboman/mason.nvim',
  },
  init = init,
}
