# Modern Neovim Configuration

This repository contains Hossam's Neovim configuration. It has been modernized
from the original Vimscript/dein setup to a Lua-based Neovim configuration using
lazy.nvim, Mason, built-in LSP, Treesitter, and contemporary editing plugins.

## Requirements

- Neovim 0.12 or newer.
- Git.
- Curl and tar.
- A C compiler for Treesitter parser builds.
- A terminal with true color support.
- `wl-copy`/`wl-paste` or another clipboard provider for system clipboard
  integration on Linux.
- `duckdb` for in-editor Parquet previews with `:ParquetView`.
- `uv` for creating the dedicated Neovim Python/Jupyter runtime.
- A Nerd Font is recommended for icons.

## Installation

Clone the repository and run:

```sh
./installer.sh
```

The installer creates a backup of any existing `~/.config/nvim` directory and
symlinks this repository as the active Neovim configuration.

Start Neovim:

```sh
nvim
```

On first launch, lazy.nvim bootstraps itself and installs plugins. Mason then
installs language servers, formatters, linters, and the Treesitter CLI.

## Layout

```text
.
├── AGENTS.md
├── init.lua
├── lazy-lock.json
├── docs
│   ├── KEYMAPS.md
│   ├── MAINTENANCE.md
│   └── PLUGINS.md
├── lua
│   ├── config
│   │   ├── autocmds.lua
│   │   ├── keymaps.lua
│   │   ├── lazy.lua
│   │   ├── options.lua
│   │   └── parquet.lua
│   └── plugins
│       ├── colorscheme.lua
│       ├── completion.lua
│       ├── debug.lua
│       ├── editing.lua
│       ├── files.lua
│       ├── format.lua
│       ├── git.lua
│       ├── lsp.lua
│       ├── markdown.lua
│       ├── notebook.lua
│       ├── python.lua
│       ├── rust.lua
│       ├── test.lua
│       ├── treesitter.lua
│       └── ui.lua
├── colors
└── legacy
```

Additional docs:

- [Keymaps](docs/KEYMAPS.md)
- [Plugin Architecture](docs/PLUGINS.md)
- [Maintenance](docs/MAINTENANCE.md)
- [Agent Instructions](AGENTS.md)

## Core Configuration

`init.lua` loads the configuration in this order:

1. `lua/config/options.lua`
2. `lua/config/keymaps.lua`
3. `lua/config/autocmds.lua`
4. `lua/config/parquet.lua`
5. `lua/config/lazy.lua`

`options.lua` defines editor behavior: line numbers, relative numbers,
true-color support, splits, search behavior, indentation, persistent undo,
clipboard integration, and Mason's binary path.

`keymaps.lua` contains the custom mappings. The leader key is comma.

`autocmds.lua` adds small quality-of-life behavior:

- highlight yanked text
- restore cursor position when reopening files
- remove comment continuation from format options
- create missing parent directories for new files opened with `:e` or written
  from another buffer creation path

`parquet.lua` adds `:ParquetView`, a DuckDB-backed Parquet preview command that
opens CSV-formatted results in a scratch tab.

`lazy.lua` bootstraps lazy.nvim and loads plugin specs from `lua/plugins`.

## Plugin Groups

### UI

Defined in `lua/plugins/ui.lua` and `lua/plugins/colorscheme.lua`.

- `catppuccin/nvim`: colorscheme
- `nvim-lualine/lualine.nvim`: statusline
- `folke/which-key.nvim`: keybinding discovery
- `folke/todo-comments.nvim`: highlights TODO/FIXME-style comments
- `stevearc/dressing.nvim`: improved `vim.ui.select` and `vim.ui.input`

### Files and Search

Defined in `lua/plugins/files.lua`.

- `neo-tree.nvim` is the primary right-side VS Code-style file tree, with file
  icons, git status, diagnostics, buffers, and a git status source.
- `oil.nvim` remains available for editable buffer-style filesystem operations.
- `telescope.nvim` replaces CtrlP for fuzzy finding.
- `telescope-fzf-native.nvim` improves Telescope sorting performance.

Useful mappings:

| Mapping | Action |
| --- | --- |
| `-` | Open Oil in the current directory |
| `<C-n>` | Toggle Neo-tree and reveal the current file |
| `<leader>ft` | Focus Neo-tree and reveal the current file |
| `<leader>fT` | Close Neo-tree |
| `<leader>gT` | Open Neo-tree git status in a float |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Find buffers |
| `<leader>fh` | Find help |
| `<leader>fr` | Recent files |
| `<leader>fd` | Diagnostics |

### Data Files

Defined in `lua/config/parquet.lua`.

Parquet files can be previewed inside Neovim when `duckdb` is installed:

```vim
:ParquetView path/to/data.parquet
```

Run `:ParquetView` from an open Parquet buffer to preview the current file. Add
a row limit as the final argument, such as `:ParquetView % 500`; the default
limit is 200 rows. Results open in a read-only CSV scratch tab.

### Notebooks

Defined in `lua/plugins/notebook.lua`.

- `jupytext.nvim` opens `.ipynb` files as editable Python buffers with
  `# %%` cell markers.
- `molten-nvim` runs cells through a Jupyter kernel and shows output in
  Neovim.
- `NotebookNavigator.nvim` moves between cells and sends cells to Molten.

Notebook execution uses a dedicated Python runtime at:

```text
~/.local/share/nvim/python
```

Project `.venv` environments must be registered as Jupyter kernels before
Molten can run them:

```sh
uv pip install --python .venv/bin/python ipykernel
.venv/bin/python -m ipykernel install --user --name project-name --display-name "Python (project-name)"
```

Then select it in Neovim with `:MoltenInit project-name`. List and remove
kernels with:

```sh
~/.local/share/nvim/python/bin/jupyter kernelspec list
~/.local/share/nvim/python/bin/jupyter kernelspec uninstall project-name
```

Useful mappings:

| Mapping | Action |
| --- | --- |
| `<leader>ni` | Initialize a notebook kernel |
| `<leader>nn` | Run current notebook cell |
| `<leader>nm` | Run current notebook cell and move down |
| `<leader>na` | Run all notebook cells |
| `]n` / `[n` | Move to next/previous notebook cell |
| `<leader>nl` | Run current line |
| `<leader>ne` | Run operator or visual selection |
| `<leader>no` / `<leader>nH` | Show/hide notebook output |
| `<leader>nR` / `<leader>nq` | Restart/stop notebook kernel |
| `<leader>nI` / `<leader>nE` | Import/export notebook outputs |

### Editing

Defined in `lua/plugins/editing.lua`.

- `nvim-surround`: add/change/delete surrounding pairs
- `Comment.nvim`: line/block commenting
- `nvim-autopairs`: automatic paired characters
- `flash.nvim`: fast visible-text jumping

Useful mappings:

| Mapping | Action |
| --- | --- |
| `gc` | Toggle comments |
| `s` | Flash jump |
| `S` | Flash Treesitter jump |
| `jk` | Exit insert mode |
| `<leader><space>` | Clear search highlight |
| `<leader>b` | Alternate buffer |

### Git

Defined in `lua/plugins/git.lua`.

- `vim-fugitive`: Git command integration
- `diffview.nvim`: full-tab changed-file and commit diff review
- `gitgraph.nvim`: interactive commit graph with Diffview integration
- `gitsigns.nvim`: inline hunk signs/actions

Useful mappings:

| Mapping | Action |
| --- | --- |
| `<leader>gg` | Git status |
| `<leader>gl` | Commit graph for all branches |
| `<leader>gd` | Diff working tree/index changes |
| `<leader>gD` | Close Diffview |
| `<leader>gh` | Repository file history |
| `<leader>gH` | Current file history |
| `]c` | Next Git hunk |
| `[c` | Previous Git hunk |
| `<leader>gb` | Blame current line |
| `<leader>gp` | Preview hunk |
| `<leader>gr` | Reset hunk |
| `<leader>gs` | Stage hunk |

In the graph opened by `<leader>gl`, press `Enter` on a commit to open that
commit's changed files in Diffview. Select a visual range of commits and press
`Enter` to diff that range.

### Treesitter

Defined in `lua/plugins/treesitter.lua`.

Treesitter provides modern syntax highlighting, indentation, folding, and
injections. The config installs parsers for Bash, CSS, Go, HTML, JavaScript,
JSON, Lua, Markdown, Python, Rust, TOML, TSX, TypeScript, Vim, Vimdoc, and
YAML.

TOML support includes the Treesitter parser, `taplo` LSP, and `taplo`
formatting through Conform. This covers project files such as `Cargo.toml`,
`pyproject.toml`, and other TOML config files.

Run this after plugin updates:

```vim
:TSUpdate
```

### LSP and Tooling

Defined in `lua/plugins/lsp.lua`.

This setup uses Neovim's modern built-in LSP API:

- `vim.lsp.config()`
- `vim.lsp.enable()`

It intentionally avoids the deprecated
`require("lspconfig").server.setup({ ... })` pattern.

Installed LSP servers:

- Python: `basedpyright`, `ruff`
- Bash: `bashls`
- CSS: `cssls`
- Go: `gopls`
- HTML: `html`
- JSON: `jsonls`
- Lua: `lua_ls`
- Tailwind CSS: `tailwindcss`
- TOML: `taplo`
- TypeScript/JavaScript: `ts_ls`
- YAML: `yamlls`

Mason-managed tools:

- `basedpyright`
- `codelldb`
- `debugpy`
- `goimports`
- `rust-analyzer`
- `ruff`
- `taplo`
- `tree-sitter-cli`
- `prettier`
- `stylua`
- `shfmt`
- `eslint_d`

Rust is handled by `rustaceanvim` instead of `mason-lspconfig` so it can expose
Rust-specific actions, runnables, testables, macro expansion, and LLDB-backed
debuggables without conflicting with a generic `rust_analyzer` setup.

Useful LSP mappings:

| Mapping | Action |
| --- | --- |
| `gd` | Definition |
| `gD` | Declaration |
| `gy` | Type definition |
| `grn` | Rename |
| `gra` | Code action |
| `grr` | References |
| `gri` | Implementation |
| `gO` | Document symbols |
| `K` | Hover |
| `<C-s>` in insert mode | Signature help |

Useful commands:

```vim
:checkhealth vim.lsp
:LspInfo
:Mason
```

### Completion

Defined in `lua/plugins/completion.lua`.

Completion is powered by `blink.cmp`, using LSP, path, snippets, and buffer
sources. It uses `friendly-snippets` for snippet data.

Useful completion keys:

| Mapping | Action |
| --- | --- |
| `<C-space>` | Show completion/documentation |
| `<C-y>` | Accept selected completion |

### Markdown

Defined in `lua/plugins/markdown.lua`.

- `render-markdown.nvim` provides an in-editor rendered preview for Markdown.
- It uses Treesitter and devicons; it does not require a browser, Node, or an
  external Markdown server.
- Use `<leader>mp` to toggle preview rendering in Markdown buffers.

Useful mappings:

| Mapping | Action |
| --- | --- |
| `<leader>mp` | Toggle Markdown preview |
| `<leader>me` | Expand Markdown preview |
| `<leader>mc` | Contract Markdown preview |

### Formatting and Linting

Defined in `lua/plugins/format.lua`.

`conform.nvim` formats files on save when a formatter exists. It uses:

- `prettier` for web formats
- `goimports` and `gofmt` for Go
- `stylua` for Lua
- `ruff` for Python imports and formatting
- `rustfmt` for Rust
- `taplo` for TOML
- `shfmt` for shell scripts

Manual format:

```vim
<leader>cf
```

`nvim-lint` runs `eslint_d` for JavaScript and TypeScript projects.

### Go

Defined in `lua/plugins/lsp.lua`, `lua/plugins/treesitter.lua`, and
`lua/plugins/format.lua`.

- `gopls` provides Go language intelligence through Neovim LSP.
- Treesitter installs the `go` parser for syntax highlighting, indentation,
  and folding.
- Conform formats Go files on save with `goimports` and `gofmt`.

### Python

Defined in `lua/plugins/python.lua`, `lua/plugins/debug.lua`,
`lua/plugins/test.lua`, `lua/plugins/lsp.lua`, and `lua/plugins/format.lua`.

- `basedpyright` provides Python type checking and language intelligence.
- `ruff` provides fast lint diagnostics, import organization, and formatting.
- `venv-selector.nvim` switches project virtualenvs with `<leader>cv`.
- `nvim-dap-python` uses Mason's `debugpy-adapter` for Python debugging.
- `neotest-python` runs and debugs pytest tests through neotest.

### Rust

Defined in `lua/plugins/rust.lua`, with debug and test support from
`lua/plugins/debug.lua` and `lua/plugins/test.lua`.

- `rustaceanvim` owns `rust-analyzer` setup and Rust-specific commands.
- `rustfmt` formats Rust files through Conform.
- `codelldb` provides the debug adapter for Rust debugging.
- neotest integrates with rustaceanvim for Rust test runs.

Useful Rust mappings are buffer-local to Rust files:

| Mapping | Action |
| --- | --- |
| `<leader>ra` | Rust code action |
| `<leader>rh` | Rust hover actions |
| `<leader>rr` | Rust runnables |
| `<leader>rt` | Rust testables |
| `<leader>rd` | Rust debuggables |
| `<leader>rm` | Expand macro |

Useful test/debug mappings:

| Mapping | Action |
| --- | --- |
| `<leader>tn` | Run nearest test |
| `<leader>tf` | Run current file's tests |
| `<leader>td` | Debug nearest test |
| `<leader>ts` | Toggle test summary |
| `<leader>to` | Open test output |
| `<leader>Db` | Toggle breakpoint |
| `<leader>Dc` | Continue debugging |
| `<leader>Du` | Toggle debug UI |

## Personal Mappings Preserved

Several mappings from the old Vimscript configuration were kept:

| Mapping | Action |
| --- | --- |
| `<leader>s` | Jump to first non-blank character |
| `<leader>d` | Jump to end of line |
| `<leader>re` | Replace word under cursor |
| `<leader>m` in insert mode | Append semicolon |
| `<leader>cpa` / `<leader>pa` | Copy/paste register `a` |
| `<leader>cpb` / `<leader>pb` | Copy/paste register `b` |
| `<leader>cp+` / `<leader>p+` | Copy/paste system clipboard |
| `<leader>ev` | Edit main Neovim config |
| `<leader>epl` | Edit plugin specs |
| `<leader>ecs` | Edit core config |

## Maintenance

Update plugins:

```vim
:Lazy sync
```

Update Mason tools:

```vim
:MasonToolsUpdate
```

Update Treesitter parsers:

```vim
:TSUpdate
```

Run health checks:

```vim
:checkhealth
```

## Legacy Files

The original Vimscript/dein configuration lives in `legacy/`. It is kept for
reference only and is not loaded by Neovim.

The old colorschemes remain in `colors/`, but the active colorscheme is
Catppuccin.
