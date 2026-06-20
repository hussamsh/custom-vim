# Maintenance

## Common Commands

| Command | Purpose |
| --- | --- |
| `:Lazy` | Open plugin manager UI |
| `:Lazy sync` | Install, update, and clean plugins |
| `:Lazy update` | Update plugins |
| `:Lazy restore` | Restore versions from `lazy-lock.json` |
| `:Mason` | Open Mason UI |
| `:MasonToolsUpdate` | Update configured tools |
| `:TSUpdate` | Update Treesitter parsers |
| `:checkhealth` | Run full health checks |
| `:checkhealth vim.lsp` | Diagnose LSP |
| `:ConformInfo` | Diagnose formatting |
| `:MasonInstall rust-analyzer codelldb debugpy basedpyright ruff taplo` | Install Rust/Python tools |
| `:RenderMarkdown toggle` | Toggle Markdown preview rendering |

## Updating Everything

Run these inside Neovim:

```vim
:Lazy sync
:MasonToolsUpdate
:TSUpdate
:checkhealth
```

If `lazy-lock.json` changes after plugin updates, review it and commit it with
the config. The lockfile makes plugin versions reproducible.

## Adding a Plugin

1. Create or edit a file in `lua/plugins`.
2. Add a lazy.nvim spec.
3. Prefer lazy-loading by command, event, filetype, or keys unless the plugin
   must load at startup.
4. Restart Neovim or run `:Lazy reload`.
5. Run `:checkhealth`.

Example:

```lua
return {
  {
    "author/plugin.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
```

## Adding an LSP Server

1. Add the server name to `ensure_installed` in `lua/plugins/lsp.lua`.
2. If custom settings are needed, add `vim.lsp.config("server_name", { ... })`.
3. Run `:Mason` or restart Neovim.
4. Open a matching filetype and run `:checkhealth vim.lsp`.

Use `:help lspconfig-all` to inspect available server names and root markers.

## Adding a Formatter

1. Add the Mason package to `ensure_installed` in `lua/plugins/lsp.lua`.
2. Add the formatter to `formatters_by_ft` in `lua/plugins/format.lua`.
3. Run `:MasonToolsUpdate`.
4. Run `:ConformInfo` in a matching file.

## Rust and Python Tooling

Rust uses `rustaceanvim`, so do not add `rust_analyzer` to generic
`mason-lspconfig` auto-enable. Mason installs `rust-analyzer` and `codelldb`,
but rustaceanvim owns the LSP client and Rust-specific commands.

Python uses `basedpyright` and `ruff`. Mason installs both. Conform uses Ruff
for import organization and formatting, and `venv-selector.nvim` provides
`<leader>cv` for selecting project virtualenvs.

Useful stack checks:

```vim
:Mason
:LspInfo
:ConformInfo
:checkhealth vim.lsp
```

## Troubleshooting

### Plugins did not install

Run:

```vim
:Lazy sync
```

Check that `git` and network access work.

### Treesitter parser errors

Run:

```vim
:MasonToolsUpdate
:TSUpdate
```

The modern Treesitter plugin requires `tree-sitter-cli`. This config installs it
through Mason and prepends Mason's `bin` directory to `PATH`.

### LSP does not attach

Run:

```vim
:checkhealth vim.lsp
:LspInfo
:Mason
```

Common causes:

- the language server is not installed
- the filetype is not detected
- the project does not contain an expected root marker such as `.git` or
  `package.json`
- Rust projects should contain `Cargo.toml`
- Python projects should use a detectable root such as `.git`, `pyproject.toml`,
  `setup.py`, or `requirements.txt`

### Formatting does not run

Run:

```vim
:ConformInfo
```

Confirm the formatter is installed in Mason and mapped in
`lua/plugins/format.lua`.

### Markdown preview does not render

Open a Markdown file and run:

```vim
:RenderMarkdown toggle
```

If the command is missing, run `:Lazy sync` and reopen Neovim. If the buffer is
not detected as Markdown, run `:set filetype?`.

### TOML tooling does not attach

Run:

```vim
:LspInfo
:Mason
:ConformInfo
```

Confirm `taplo` is installed and the buffer filetype is `toml`.

### Python virtualenv is wrong

Run:

```vim
:VenvSelect
```

Pick the project virtualenv, then reopen the Python buffer or restart the LSP
client with `:LspRestart`.

### Rust debugging is unavailable

Confirm `codelldb` is installed:

```vim
:Mason
```

Rust debuggables are exposed through rustaceanvim with `<leader>rd` in a Rust
buffer.

## Legacy Config

The original Vimscript setup is preserved under `legacy/` for reference. It is
not loaded by Neovim. The active configuration starts at `init.lua`.
