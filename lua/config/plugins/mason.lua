local config = {
  ui = {
    icons = {
      package_pending = ' ',
      package_installed = ' ',
      package_uninstalled = ' ',
    },
  },

  max_concurrent_installers = 10,
}

return {
  'williamboman/mason.nvim',
  lazy = false, priority = 900,
  opts = config
}
