local config = {
  ensure_installed = {
    'bash',
    'c',
    'cpp',
    'c_sharp',
    'dockerfile',
    'doxygen',
    'markdown',
    'lua',
    'luadoc',
    'printf',
    'python',
    'vim',
    'vimdoc',
    'javascript',
    'typescript',
    'jsdoc',
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
    'groovy',
    'php',
    'ruby',
    'swift',
    'kotlin',
    'haskell',
    'xml',
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
    -- This is done as jinja2 files ending in `.html` are recognized as htmldjango files
    vim.treesitter.language.register('html', 'htmldjango')

    require('nvim-treesitter.configs').setup(opts)
  end,
}
