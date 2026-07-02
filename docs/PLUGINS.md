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
| `../config/parquet.lua` | DuckDB-backed `:ParquetView` command |
| `ui.lua` | Statusline, which-key, TODO comments, UI input/select polish |
| `editing.lua` | Surround, comments, autopairs, Flash navigation |
| `files.lua` | Right-side Neo-tree explorer, Oil editable explorer, and Telescope fuzzy finding |
| `git.lua` | Fugitive, Diffview, GitGraph, and Gitsigns |
| `treesitter.lua` | Treesitter parser installation and startup |
| `lsp.lua` | Mason, LSP server setup, external tools |
| `markdown.lua` | In-editor Markdown preview rendering |
| `notebook.lua` | Jupytext `.ipynb` editing, Molten execution, and cell navigation |
| `rust.lua` | rustaceanvim and Rust-specific actions |
| `python.lua` | Python virtualenv selection |
| `debug.lua` | nvim-dap, DAP UI, Python debugging |
| `test.lua` | neotest adapters for Python and Rust |
| `completion.lua` | blink.cmp completion |
| `format.lua` | conform.nvim formatting and nvim-lint linting |

## Lazy Loading

The config lazy-loads most plugins by event, command, filetype, or keymap:

- UI plugins load on `VeryLazy`.
- Completion loads on `InsertEnter`.
- Formatters load on `BufWritePre` or `:ConformInfo`.
- Git graph and diff review plugins load through their Git keymaps and
  `:Diffview*` commands.
- Neo-tree loads at startup so it can own directory buffers and provide the
  default right-side tree.
- Oil loads on `:Oil` or `-`.
- Telescope loads on `:Telescope` or the configured Telescope mappings.
- LSP tooling loads before reading or creating files.
- Debugging and test tooling loads from its keymaps.
- Markdown preview loads for Markdown files or from `:RenderMarkdown`.
- Jupytext and Molten load at startup so `.ipynb` buffers and remote-plugin
  commands are available immediately. NotebookNavigator loads from notebook
  movement and execution mappings.

Catppuccin and Treesitter are intentionally not lazy-loaded because they affect
the editing experience immediately. rustaceanvim is also loaded at startup
because it installs Rust filetype integration and owns the `rust-analyzer`
client.

## Notebook Execution

Notebook support combines three plugins:

- `jupytext.nvim` converts `.ipynb` files to editable Python buffers with
  `# %%` cells.
- `molten-nvim` runs code through Jupyter kernels and displays output inside
  Neovim.
- `NotebookNavigator.nvim` moves between cells and sends cells to Molten.

The Python provider and notebook commands use a dedicated runtime at
`~/.local/share/nvim/python`. `lua/config/options.lua` prepends that runtime's
`bin` directory to `PATH` and sets `vim.g.python3_host_prog` when the runtime
exists.

Runtime packages installed there include `pynvim`, `jupyter`, `jupytext`,
`jupyter_client`, `nbformat`, `ipykernel`, `pillow`, `cairosvg`, `plotly`,
`pnglatex`, and `pyperclip`. The `nvim-python` kernelspec points at the same
runtime.

Project `.venv` environments are selected by registering them as Jupyter
kernels, then passing the kernel name to `:MoltenInit`. For example:

```sh
uv pip install --python .venv/bin/python ipykernel
.venv/bin/python -m ipykernel install --user --name project-name --display-name "Python (project-name)"
```

Then run `:MoltenInit project-name`. Use
`~/.local/share/nvim/python/bin/jupyter kernelspec list` to list kernels and
`~/.local/share/nvim/python/bin/jupyter kernelspec uninstall project-name` to
delete stale kernels.

Useful commands:

| Command | Purpose |
| --- | --- |
| `:MoltenInit nvim-python` | Start the dedicated Neovim Python kernel |
| `:MoltenEvaluateLine` | Run the current line |
| `:MoltenReevaluateCell` | Re-run the active Molten cell |
| `:MoltenShowOutput` / `:MoltenHideOutput` | Show or hide output |
| `:MoltenImportOutput` / `:MoltenExportOutput` | Read/write notebook outputs |
| `:checkhealth molten` | Diagnose Molten runtime support |

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
On `LspAttach`, the config also adds buffer-local `gd`, `gD`, and `gy`
navigation mappings for definition, declaration, and type definition jumps.

## Mason Packages

Language servers:

- `basedpyright`
- `bash-language-server`
- `css-lsp`
- `gopls`
- `html-lsp`
- `json-lsp`
- `lua-language-server`
- `ruff`
- `tailwindcss-language-server`
- `taplo`
- `typescript-language-server`
- `yaml-language-server`

Developer tools:

- `codelldb`
- `debugpy`
- `eslint_d`
- `goimports`
- `prettier`
- `rust-analyzer`
- `shfmt`
- `stylua`
- `tree-sitter-cli`

`rust-analyzer` is installed by Mason but excluded from generic
`mason-lspconfig` auto-enable. rustaceanvim starts it so Rust-specific features
and DAP integration work correctly.

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
| Go | `goimports`, `gofmt` |
| Lua | `stylua` |
| Python | `ruff_organize_imports`, `ruff_format` |
| Rust | `rustfmt` |
| Shell | `shfmt` |
| TOML | `taplo` |

Manual formatting is available with `<leader>cf`.

## Markdown Preview

`render-markdown.nvim` renders Markdown structure directly inside Neovim. It is
configured in `lua/plugins/markdown.lua` and loads for Markdown buffers or the
`:RenderMarkdown` command.

Useful commands and mappings:

| Command or mapping | Purpose |
| --- | --- |
| `:RenderMarkdown toggle` / `<leader>mp` | Toggle rendered Markdown preview |
| `:RenderMarkdown expand` / `<leader>me` | Expand rendered Markdown sections |
| `:RenderMarkdown contract` / `<leader>mc` | Contract rendered Markdown sections |

## Parquet Preview

Parquet preview is implemented as a local command in `lua/config/parquet.lua`
rather than a lazy.nvim plugin. It shells out through `vim.system()` with an
argument list, so file paths are not passed through a shell.

Useful commands:

| Command | Purpose |
| --- | --- |
| `:ParquetView` | Preview the current buffer as Parquet |
| `:ParquetView path/to/data.parquet` | Preview a specific Parquet file |
| `:ParquetView % 500` | Preview the current file with a 500-row limit |

The command requires `duckdb` on `PATH`, reads data with DuckDB's
`read_parquet()`, and opens CSV output in a read-only scratch tab. The default
row limit is 200.

## TOML Tooling

TOML support uses three layers:

- Treesitter parser: syntax, indentation, and folding.
- `taplo` LSP: diagnostics, completion, hover, and document symbols.
- `taplo` formatter: format on save through Conform.

This applies to files such as `Cargo.toml`, `pyproject.toml`, and other
`*.toml` configuration files.

## Linting

`nvim-lint` runs `eslint_d` for JavaScript and TypeScript filetypes. It triggers
on buffer read, buffer write, and leaving insert mode.

## Python Tooling

Python support is centered on fast project feedback:

- `basedpyright` for type checking, go-to-definition, imports, and symbols.
- `ruff` for lint diagnostics plus import organization and formatting on save.
- `venv-selector.nvim` for switching the active virtualenv from Telescope.
- `nvim-dap-python` plus Mason's `debugpy-adapter` for debugging.
- `neotest-python` for pytest runs and debug sessions.

Use `<leader>cv` to select a virtualenv for the current project. Use
`:ConformInfo`, `:LspInfo`, and `:checkhealth vim.lsp` when diagnosing Python
tooling.

## Rust Tooling

Rust support is intentionally not a plain `lspconfig.rust_analyzer` setup.
`rustaceanvim` configures `rust-analyzer` and exposes Rust-specific commands:

- code actions
- hover actions
- Cargo runnables
- testables
- LLDB-backed debuggables
- macro expansion

The config enables all Cargo features by default and runs `clippy` for checks
when rust-analyzer asks Cargo to check the project. `codelldb` is installed by
Mason for Rust debugging.
