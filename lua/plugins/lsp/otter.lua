local function init()
  vim.api.nvim_create_autocmd({ 'BufEnter', 'TextChanged', 'TextChangedI' }, {
    callback = function(args)
      local bufnr = args.buf
      local ft = vim.bo[bufnr].filetype

      if ft == 'markdown' then
        require('otter').activate()
      end
    end,
  })
end

return {
  'jmbuhr/otter.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {},
  init = init,
}
