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
    'meson',
    'make',
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

    -- Neovim 0.12 removed the `all=false` unwrapping from add_directive, so
    -- nvim-treesitter's directive handlers now receive TSNode[] instead of TSNode.
    -- Override the affected directives to unpack nodes[1] before use.
    local ts_query = vim.treesitter.query

    local non_filetype_aliases = {
      ex = 'elixir', pl = 'perl', sh = 'bash', uxn = 'uxntal', ts = 'typescript',
    }
    local html_script_types = {
      importmap = 'json',
      module = 'javascript',
      ['application/ecmascript'] = 'javascript',
      ['text/ecmascript'] = 'javascript',
    }

    ts_query.add_directive('set-lang-from-info-string!', function(match, _, bufnr, pred, metadata)
      local nodes = match[pred[2]]
      local node = nodes and nodes[1]
      if not node then return end
      local alias = vim.treesitter.get_node_text(node, bufnr):lower()
      local lang = vim.filetype.match { filename = 'a.' .. alias }
      metadata['injection.language'] = lang or non_filetype_aliases[alias] or alias
    end, { force = true })

    ts_query.add_directive('set-lang-from-mimetype!', function(match, _, bufnr, pred, metadata)
      local nodes = match[pred[2]]
      local node = nodes and nodes[1]
      if not node then return end
      local type_attr = vim.treesitter.get_node_text(node, bufnr)
      local configured = html_script_types[type_attr]
      if configured then
        metadata['injection.language'] = configured
      else
        local parts = vim.split(type_attr, '/', {})
        metadata['injection.language'] = parts[#parts]
      end
    end, { force = true })

    ts_query.add_directive('downcase!', function(match, _, bufnr, pred, metadata)
      local id = pred[2]
      local nodes = match[id]
      local node = nodes and nodes[1]
      if not node then return end
      local text = vim.treesitter.get_node_text(node, bufnr, { metadata = metadata[id] }) or ''
      if not metadata[id] then metadata[id] = {} end
      metadata[id].text = string.lower(text)
    end, { force = true })
  end,
}
