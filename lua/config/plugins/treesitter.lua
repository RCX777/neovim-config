local config = {
  ensure_installed = {
    'bash', 'c', 'cpp', 'c_sharp', 'dockerfile', 'markdown',
    'lua', 'luadoc', 'printf', 'vim', 'vimdoc',
  },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = { enable = true },
}

return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPost', 'BufNewFile' },
  cmd = { 'TSInstall', 'TSBufEnable', 'TSBufDisable', 'TSModuleInfo' },
  build = ':TSUpdate',
  opts = config,
}

