local config = {
  signs = {
    delete = { text = '󰍵' },
    changedelete = { text = '󱕖' },
  },
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol',
    delay = 0,
  }
}

local on_attach = function(bufnr)
  local gitsigns = require 'gitsigns'

  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end

  map('n', ']', function()
    if vim.wo.diff then
      vim.cmd.normal({']', bang = true})
    else
      gitsigns.nav_hunk('next')
    end
  end)

  map('n', '[', function()
    if vim.wo.diff then
      vim.cmd.normal({'[', bang = true})
    else
      gitsigns.nav_hunk('prev')
    end
  end)
end

config.on_attach = on_attach

return {
  'lewis6991/gitsigns.nvim',
  enable = true, lazy = false,
  event = 'User FilePost',
  opts = config
}

