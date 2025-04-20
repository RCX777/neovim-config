local filetypes = { 'html', 'mdx', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'vue', 'svelte' }

local init_options = {
  userLanguages = {
    eelixir = 'html-eex',
    eruby = 'erb',
  },
}

local settings = {
  tailwindCSS = {
    lint = {
      cssConflict = 'warning',
      invalidApply = 'error',
      invalidConfigPath = 'error',
      invalidScreen = 'error',
      invalidTailwindDirective = 'error',
      invalidVariant = 'error',
      recommendedVariantOrder = 'warning',
    },
    experimental = {
      classRegex = {
        'tw`([^`]*)',
        'tw="([^"]*)',
        'tw={"([^"}]*)',
        'tw\\.\\w+`([^`]*)',
        'tw\\(.*?\\)`([^`]*)',
        { 'clsx\\(([^)]*)\\)', "(?:'|\"|`)([^']*)(?:'|\"|`)" },
        { 'classnames\\(([^)]*)\\)', "'([^']*)'" },
        { 'cva\\(([^)]*)\\)', '["\'`]([^"\'`]*).*?["\'`]' },
        { 'cn\\(([^)]*)\\)', "(?:'|\"|`)([^']*)(?:'|\"|`)" },
      },
    },
    validate = true,
  },
}

vim.lsp.config('tailwindcss', {
  cmd = { 'tailwindcss-language-server', '--stdio' },
  filetypes = filetypes,
  init_options = init_options,
  settings = settings,
})

vim.lsp.enable 'tailwindcss'
