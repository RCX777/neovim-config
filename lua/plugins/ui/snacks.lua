return {
  'folke/snacks.nvim',
  lazy = false,
  priority = 950,
  opts = {
    input = {},
    words = { enabled = true },
    lazygit = {},
    explorer = {},
    picker = {
      ui_select = true,
    },
  },
  init = function()
    local map = vim.keymap.set

    local git_browse_stack = {}
    local git_browse_origin = nil

    -- Picker (replaces Telescope)
    map('n', '<leader>ff', function() Snacks.picker.files() end, { desc = 'Find files' })
    map('n', '<leader>fw', function() Snacks.picker.grep() end, { desc = 'Live grep' })
    map('n', '<leader>fb', function() Snacks.picker.buffers() end, { desc = 'Find buffers' })
    map('n', '<leader>fh', function() Snacks.picker.help() end, { desc = 'Help tags' })
    map('n', '<leader>fo', function() Snacks.picker.recent() end, { desc = 'Recent files' })
    map('n', '<leader>fz', function() Snacks.picker.lines() end, { desc = 'Search current buffer' })
    map('n', '<leader>ma', function() Snacks.picker.marks() end, { desc = 'Find marks' })
    map('n', '<leader>gc', function()
      if #git_browse_stack == 0 then
        local branch = vim.trim(vim.fn.system 'git branch --show-current')
        if branch == '' then
          vim.notify('gc: start from a branch, not detached HEAD', vim.log.levels.WARN)
          return
        end
        git_browse_origin = branch
      end
      local out = vim.fn.system 'git stash'
      local stashed = vim.v.shell_error == 0 and not out:find('No local changes to save', 1, true)
      local confirmed = false
      Snacks.picker.git_log({
        confirm = function(picker, item)
          if not (item and (item.branch or item.commit)) then return end
          confirmed = true
          table.insert(git_browse_stack, { stashed = stashed })
          require('snacks.picker.actions').git_checkout(picker, item)
        end,
        on_close = function()
          if not confirmed then
            if stashed then
              local pop_out = vim.fn.system 'git stash pop'
              if vim.v.shell_error ~= 0 then vim.notify('git stash pop failed: ' .. pop_out, vim.log.levels.ERROR) end
            end
            if #git_browse_stack == 0 then git_browse_origin = nil end
          end
        end,
      })
    end, { desc = 'Git commits' })
    map('n', '<leader>gb', function()
      if #git_browse_stack == 0 then
        vim.notify('Not in git browse mode', vim.log.levels.WARN)
        return
      end
      vim.fn.system 'git checkout -'
      if vim.v.shell_error ~= 0 then
        vim.notify('git checkout - failed', vim.log.levels.ERROR)
        return
      end
      local entry = table.remove(git_browse_stack)
      if entry.stashed then
        local pop_out = vim.fn.system 'git stash pop'
        if vim.v.shell_error ~= 0 then vim.notify('git stash pop failed: ' .. pop_out, vim.log.levels.ERROR) end
      end
      if #git_browse_stack == 0 then git_browse_origin = nil end
    end, { desc = 'Git back' })
    map('n', '<leader>gh', function()
      if #git_browse_stack == 0 then
        vim.notify('Not in git browse mode', vim.log.levels.WARN)
        return
      end
      vim.fn.system { 'git', 'checkout', git_browse_origin }
      if vim.v.shell_error ~= 0 then
        vim.notify('git checkout ' .. git_browse_origin .. ' failed', vim.log.levels.ERROR)
        return
      end
      for i = #git_browse_stack, 1, -1 do
        if git_browse_stack[i].stashed then
          local pop_out = vim.fn.system 'git stash pop'
          if vim.v.shell_error ~= 0 then
            vim.notify('git stash pop failed: ' .. pop_out, vim.log.levels.ERROR)
            break
          end
        end
      end
      git_browse_stack = {}
      git_browse_origin = nil
    end, { desc = 'Git go home' })
    map('n', '<leader>gs', function() Snacks.picker.git_status() end, { desc = 'Git status' })
    map('n', '<leader>fa', function() Snacks.picker.files { hidden = true, ignored = true } end, { desc = 'Find all files' })

    -- Explorer (replaces nvim-tree)
    map('n', '<C-n>', function() Snacks.explorer() end, { desc = 'Toggle explorer' })
    map('n', '<leader>e', function() Snacks.explorer() end, { desc = 'Focus explorer' })

    -- Lazygit (replaces lazygit.nvim)
    if vim.fn.executable 'lazygit' == 1 then
      map('n', '<leader>gg', function() Snacks.lazygit() end, { desc = 'LazyGit' })
      map('n', '<leader>gr', function() Snacks.lazygit.log() end, { desc = 'LazyGit reflog' })
    end
  end,
}
