return {
  'lukas-reineke/indent-blankline.nvim', lazy = false,
  main = 'ibl',
  opts = {
    indent = {
      char = "▏",           -- Use a thin vertical line for indentation
      tab_char = "▏",       -- Same for tab characters
      smart_indent_cap = true,
    },
    scope = {
      enabled = false,
    },
  },
}

