return {
  'ray-x/lsp_signature.nvim',
  opts = {
    bind = true,
    handler_opts = {
      border = 'rounded', -- double, rounded, single, shadow
    },
    floating_window_opts = {
      winblend = 0,
    },
    hint_enable = false,
    hi_parameter = 'LspSignatureActiveParameter',
  },
}
