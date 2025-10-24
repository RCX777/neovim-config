return {
  "kdheepak/lazygit.nvim",
  lazy = true,
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitFilter",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = function()
    if vim.fn.executable("lazygit") == 1 then
      return {
        { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
        { "<leader>gr", "<cmd>LazyGitFilter<cr>", desc = "LazyGit Reflog" }
      }
    end
    return {}
  end
}

