vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      workspace = {
        library = {
          vim.fn.expand '$VIMRUNTIME/lua',
          vim.fn.stdpath 'data' .. '/lazy/lazy.nvim/lua/lazy',
        },
      },
    },
  },
})

vim.lsp.enable 'lua_ls'
