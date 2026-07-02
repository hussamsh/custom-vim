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
| `:checkhealth neo-tree` | Diagnose Neo-tree dependencies and config |
| `:checkhealth molten` | Diagnose notebook runtime support |
| `:ConformInfo` | Diagnose formatting |
| `:MasonInstall rust-analyzer codelldb debugpy basedpyright ruff taplo` | Install Rust/Python tools |
| `:Neotree filesystem reveal right` | Open the primary file tree |
| `:MoltenInit nvim-python` | Start the dedicated Neovim notebook kernel |
| `:RenderMarkdown toggle` | Toggle Markdown preview rendering |
| `:ParquetView path/to/data.parquet` | Preview a Parquet file with DuckDB |
| `:DiffviewOpen` | Review working tree/index changes in Diffview |
| `:DiffviewFileHistory` | Review repository history in Diffview |

## Editing New Nested Files

Opening a new file with a missing parent directory now creates that directory
automatically:

```vim
:e lua/new/module/init.lua
```

The same helper also runs before writes, so buffers created through other
commands still get their parent directories created before saving.

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

## Git Graph And Diff Review

The Git graph workflow lives in `lua/plugins/git.lua` and uses
`gitgraph.nvim` with `diffview.nvim`.

Use `<leader>gl` to open the commit graph. Press `Enter` on a commit to open
that commit's changed files in Diffview. Visual-select a range in the graph and
press `Enter` to review the range.

Useful direct commands:

```vim
:DiffviewOpen
:DiffviewFileHistory
:DiffviewFileHistory %
```

After changing this workflow, verify startup and plugin loading:

```sh
nvim --headless "+lua require('diffview')" "+lua require('gitgraph')" "+lua print('git graph plugins ok')" +qa
```

## Parquet Preview

`:ParquetView` is a local command, not a lazy.nvim plugin. It lives in
`lua/config/parquet.lua` and requires the `duckdb` CLI on `PATH`.

Usage:

```vim
:ParquetView path/to/data.parquet
:ParquetView % 500
```

The final numeric argument is the row limit. If no file is provided, the command
uses the current buffer path. Keep this documented when changing the output
format, command name, or dependency.

## Notebook Runtime

Notebook execution uses a dedicated Python virtualenv:

```sh
uv venv ~/.local/share/nvim/python
uv pip install --python ~/.local/share/nvim/python/bin/python pynvim jupyter jupytext jupyter_client nbformat ipykernel pillow cairosvg plotly pnglatex pyperclip
~/.local/share/nvim/python/bin/python -m ipykernel install --user --name nvim-python --display-name "Python (nvim)"
mkdir -p ~/.local/share/jupyter/runtime
```

`lua/config/options.lua` uses this virtualenv for Neovim's Python provider when
it exists. Keep the runtime available if changing Molten, Jupytext, or notebook
keymaps.

After notebook plugin updates, run:

```vim
:UpdateRemotePlugins
:checkhealth provider
:checkhealth molten
:MoltenInit nvim-python
```

If Molten reports a missing `kernel-*.json` connection file, recreate
`~/.local/share/jupyter/runtime`.

### Project Virtualenv Kernels

Molten executes code through Jupyter kernels. `:VenvSelect` changes editor
tooling, but it does not change the notebook execution target. Register each
project `.venv` as a Jupyter kernel, then select that kernel with
`:MoltenInit`.

From a project root with `.venv`:

```sh
uv pip install --python .venv/bin/python ipykernel
.venv/bin/python -m ipykernel install --user --name project-name --display-name "Python (project-name)"
```

Use a short, stable `--name`; this is what `:MoltenInit` uses. The display name
is only the human-readable label.

List available kernels:

```sh
~/.local/share/nvim/python/bin/jupyter kernelspec list
```

Start a specific project kernel inside Neovim:

```vim
:MoltenInit project-name
```

If you run `:MoltenInit` without an argument, Molten prompts with the available
kernels.

Delete a stale kernel:

```sh
~/.local/share/nvim/python/bin/jupyter kernelspec uninstall project-name
```

Inspect a kernel definition when debugging:

```sh
cat ~/.local/share/jupyter/kernels/project-name/kernel.json
```

The `argv[0]` entry should point at the intended virtualenv Python executable,
such as `/path/to/project/.venv/bin/python`.

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

## Go, Rust, and Python Tooling

Go uses `gopls` through `mason-lspconfig`. Mason installs `goimports`, and
Conform formats Go files with `goimports` and `gofmt`. Treesitter installs the
`go` parser for Go highlighting, indentation, and folding.

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
