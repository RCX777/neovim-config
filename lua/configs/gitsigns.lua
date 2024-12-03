local gitsigns = require 'gitsigns'

local config = {
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol',
      delay = 0,
    },
}

local on_attach = function(bufnr)
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

  map('n', '<leader>gs', gitsigns.stage_hunk, { desc = 'stage git hunk' })
  map('v', '<leader>gs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = 'stage git hunk' })
  map('n', '<leader>gr', gitsigns.reset_hunk, { desc = 'reset git hunk' })
  map('v', '<leader>gr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = 'reset git hunk' })
  map('n', '<leader>gu', gitsigns.undo_stage_hunk, { desc = 'undo staging of git hunk' })

end

config.on_attach = on_attach

return { gitsigns.setup(config) }

