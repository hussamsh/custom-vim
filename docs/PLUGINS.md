# Plugin Architecture

Plugins are managed by lazy.nvim and live in `lua/plugins/*.lua`. Each file
returns a lazy.nvim plugin spec or a list of specs.

## Bootstrap

`lua/config/lazy.lua` checks whether lazy.nvim exists in:

```text
~/.local/share/nvim/lazy/lazy.nvim
```

If it is missing, Neovim clones it automatically. Then lazy.nvim imports every
plugin spec from `lua/plugins`.

## Plugin Files

| File | Purpose |
| --- | --- |
| `colorscheme.lua` | Catppuccin theme and integrations |
| `ui.lua` | Statusline, which-key, TODO comments, UI input/select polish |
| `editing.lua` | Surround, comments, autopairs, Flash navigation |
| `files.lua` | Oil file explorer and Telescope fuzzy finding |
| `git.lua` | Fugitive and Gitsigns |
| `treesitter.lua` | Treesitter parser installation and startup |
| `lsp.lua` | Mason, LSP server setup, external tools |
| `completion.lua` | blink.cmp completion |
| `format.lua` | conform.nvim formatting and nvim-lint linting |

## Lazy Loading

The config lazy-loads most plugins by event, command, filetype, or keymap:

- UI plugins load on `VeryLazy`.
- Completion loads on `InsertEnter`.
- Formatters load on `BufWritePre` or `:ConformInfo`.
- Oil loads on `:Oil`, `-`, or `<C-n>`.
- Telescope loads on `:Telescope` or the configured Telescope mappings.
- LSP tooling loads before reading or creating files.

Catppuccin and Treesitter are intentionally not lazy-loaded because they affect
the editing experience immediately.

## LSP Design

The config uses Neovim's modern LSP API:

```lua
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
    },
  },
})

vim.lsp.enable("lua_ls")
```

`mason-lspconfig.nvim` handles automatic enabling for Mason-installed servers.
This avoids the deprecated `require("lspconfig").server.setup({})` API.

## Mason Packages

Language servers:

- `bash-language-server`
- `css-lsp`
- `html-lsp`
- `intelephense`
- `json-lsp`
- `lua-language-server`
- `tailwindcss-language-server`
- `typescript-language-server`
- `yaml-language-server`

Developer tools:

- `eslint_d`
- `php-cs-fixer`
- `prettier`
- `shfmt`
- `stylua`
- `tree-sitter-cli`

## Completion

Completion is handled by `blink.cmp`. Sources are:

- LSP
- filesystem paths
- snippets
- current buffer

`friendly-snippets` provides snippet definitions. Native Neovim snippets are
used through blink.cmp.

## Formatting

`conform.nvim` formats on save using these defaults:

| Filetype | Formatter |
| --- | --- |
| CSS/HTML/JS/JSON/Markdown/TS/YAML | `prettier` |
| Lua | `stylua` |
| PHP | `php-cs-fixer` |
| Shell | `shfmt` |

Manual formatting is available with `<leader>cf`.

## Linting

`nvim-lint` runs `eslint_d` for JavaScript and TypeScript filetypes. It triggers
on buffer read, buffer write, and leaving insert mode.
