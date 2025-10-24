-- Neovim Lua configuration for luacheck
std = luajit
cache = true

-- Global vim object and common Neovim globals
globals = {
  "vim",
  "jit",
  "bit",
}

-- Read-only globals that shouldn't be modified
read_globals = {
  "awesome",
  "client",
  "root",
}

-- Ignore some common warnings
ignore = {
  "212", -- Unused argument (common in callbacks)
  "213", -- Unused loop variable
  "631", -- Max line length (handled by stylua)
}

-- Don't report unused self arguments in methods
self = false

-- Files to exclude from linting
exclude_files = {
  "lua/plugins/*/spec/*",
  "*/tests/*",
  "*_spec.lua",
}
