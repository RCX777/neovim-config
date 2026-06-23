# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Formatting and linting

```bash
stylua .                  # format all Lua files
stylua lua/plugins/foo.lua  # format a single file
luacheck .                # lint (only if luacheck is installed)
```

Stylua config (`.stylua.toml`): 120-column width, 2-space indent, single quotes preferred, no call parentheses, `collapse_simple_statement = 'Always'`.

## Architecture

### Entry point and load order

`init.lua` sets `mapleader` to `<Space>`, then loads:
1. `config.lazy` — bootstraps lazy.nvim and registers all plugin specs
2. `config.mappings` — global keymaps (not LSP-specific)
3. `config.options` — vim options

### Plugin specs (`lua/plugins/`)

Each file returns a lazy.nvim spec table. Subdirectories group plugins by concern: `ai/`, `cmp/`, `fmt/`, `git/`, `lint/`, `lsp/`, `ui/`. All subdirectories are imported explicitly in `config/lazy.lua`.

Lazy.nvim convention used here: `init` runs before the plugin loads (safe for global keymaps even on lazy plugins); `config` runs when the plugin actually loads.

### LSP setup

LSP uses **Neovim 0.11+ built-in APIs** (`vim.lsp.config()` / `vim.lsp.enable()`), not `require('lspconfig').server.setup()`. Each server has its own file in `lua/config/lsp/<server>.lua`. `lua/plugins/lsp/lspconfig.lua` auto-loads all of them at startup by scanning that directory with `vim.fn.readdir`. Inlay hints are enabled globally (`vim.lsp.inlay_hint.enable(true)`).

Two servers are handled differently:
- **Java** (`jdtls`): started via `ftplugin/java.lua` using `nvim-jdtls`, not lspconfig
- **C#** (`roslyn`): handled entirely by `roslyn.nvim` (`lua/plugins/lsp/roslyn.lua`)

To add a new LSP server: create `lua/config/lsp/<server>.lua` calling `vim.lsp.config()` and `vim.lsp.enable()`. It will be picked up automatically.

### Diagnostics and LSP keymaps

Configured in `lua/plugins/lsp/lspconfig.lua` (`init` function). Diagnostics show as virtual lines on the current line only. LSP keymaps (`gd`, `gD`, `]d`, `[d`) are global, not buffer-local. `gd` has a custom fallback: single result jumps directly; multiple results open Snacks picker (`Snacks.picker.lsp_definitions()`).

### Treesitter

`lua/plugins/treesitter.lua` contains Neovim 0.12 compatibility patches applied after `nvim-treesitter.configs.setup()`. They override the `set-lang-from-info-string!`, `set-lang-from-mimetype!`, and `downcase!` directives with `force = true` to handle the `TSNode[]` match format that Neovim 0.12 introduced (nvim-treesitter's handlers still expect `TSNode`).

Custom tree-sitter query overrides live in `queries/<lang>/`. These take precedence over nvim-treesitter's bundled queries for that language.

### ftplugin

`ftplugin/<lang>.lua` runs when a buffer's filetype is set. Used for per-language indent settings and (for Java) starting the jdtls client.

`ftplugin/markdown.lua` overrides `gd` buffer-locally: if the cursor is on a `[text](path)` link it opens the target file; otherwise it falls back to `vim.lsp.buf.definition()`.
