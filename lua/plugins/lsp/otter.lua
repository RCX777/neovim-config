local function init()
  vim.api.nvim_create_autocmd({ 'BufEnter', 'TextChanged', 'TextChangedI' }, {
    callback = function(args)
      if vim.bo[args.buf].filetype == 'markdown' then vim.schedule(function() require('otter').activate() end) end
    end,
  })
end

return {
  'jmbuhr/otter.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  ft = { 'markdown' },
  opts = {},
  init = init,
}
