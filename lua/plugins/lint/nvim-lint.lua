return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require('lint')

    -- Set up linters by filetype
    lint.linters_by_ft = {
      python = { 'ruff' },
    }

    -- Only add luacheck if it's installed
    if vim.fn.executable('luacheck') == 1 then
      lint.linters_by_ft.lua = { 'luacheck' }

      -- Configure luacheck for Neovim development
      lint.linters.luacheck.args = {
        '--globals', 'vim',
        '--read-globals', 'jit',
        '--no-unused-args',
        '--no-max-line-length',
        '--codes',
      }
    end

    -- Auto-lint on save and when entering buffer
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      callback = function()
        require('lint').try_lint()
      end,
    })
  end,
}
