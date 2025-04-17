local config = {
  ensure_installed = {
    'bash',
    'c',
    'cpp',
    'c_sharp',
    'dockerfile',
    'markdown',
    'lua',
    'luadoc',
    'printf',
    'python',
    'vim',
    'vimdoc',
    'javascript',
    'typescript',
    'tsx',
    'json',
    'html',
    'css',
    'scss',
    'yaml',
    'toml',
    'rust',
    'go',
    'java',
    'php',
    'ruby',
    'swift',
    'kotlin',
    'haskell',
    'xml'
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
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end,
}
