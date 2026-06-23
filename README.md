# RCX777's neovim config

## Project structure
```
.
├── init.lua
├── ftplugin
│   └── <lang>.lua
├── lua
│   ├── config
│   │   ├── lazy.lua
│   │   ├── mappings.lua
│   │   ├── options.lua
│   │   └── lsp
│   │       └── <lsp>.lua
│   └── plugins
│       ├── <subdir>/
│       │   └── <plugin>.lua
│       └── <plugin>.lua
├─── secrets
│   └── <secret>
├─── queries
│   └── <lang>
│       └── <query>.scm
├─── README.md
├─── LICENSE
├─── .gitignore
└─── .stylua.toml
```

## Plugin management
This configuration uses [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management.
To add a plugin, create a new file in the `lua/plugins` directory and add the plugin to the `plugins` table.
For example, to add the `nvim-treesitter` plugin, create a file ending in `.lua` in the `lua/plugins` directory,
which must return a table with the plugin configuration. Here is some example code:
```lua
-- lua/plugins/nvim-treesitter.lua

local parsers = {
  'lua',
  'python',
}

return {
  'nvim-treesitter/nvim-treesitter',
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = parsers,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    }
  end,
}
```
> Note: The name of the file does not matter, but it is recommended to use the name of the plugin for clarity.


## Secrets

Secrets are stored in the `secrets/` directory (gitignored). No secrets are currently required — all AI plugins (`avante`, `copilot`, `opencode`) manage their own authentication.

