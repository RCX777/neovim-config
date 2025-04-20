# RCX777's neovim config

## Project structure
```
.
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
│       └── <plugin>.lua
└── secrets
    └── <secret>
```


## Secrets

The secrets are stored in the `secrets` directory. Here are the secrets you can set:
- `openai.key`: Your OpenAI API key, used by the `chatgpt.nvim` plugin. If not set, the plugin will not be loaded.

