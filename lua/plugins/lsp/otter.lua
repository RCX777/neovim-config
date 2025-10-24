local function init()
  vim.api.nvim_create_autocmd({ 'BufEnter', 'TextChanged', 'TextChangedI' }, {
    callback = function(args)
      if vim.bo[args.buf].filetype == 'markdown' then
        vim.schedule(function()
          -- Skip floating windows and temporary buffers
          local win = vim.fn.bufwinid(args.buf)
          if win ~= -1 then
            local config = vim.api.nvim_win_get_config(win)
            if config.relative ~= '' then
              -- This is a floating window, skip otter activation
              return
            end
          end

          -- Skip unnamed/temporary buffers
          local bufname = vim.api.nvim_buf_get_name(args.buf)
          if bufname == '' or bufname:match('^%s*$') then
            return
          end

          if not vim.b[args.buf].otter_activated then
            pcall(function()
              require('otter').activate()
              vim.b[args.buf].otter_activated = true
            end)
          end
        end)
      end
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
