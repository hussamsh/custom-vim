# Keymaps

The leader key is comma: `,`.

## Navigation

| Mapping | Mode | Action |
| --- | --- | --- |
| `<C-h>` | Normal | Move to left window |
| `<C-j>` | Normal | Move to lower window |
| `<C-k>` | Normal | Move to upper window |
| `<C-l>` | Normal | Move to right window |
| `<leader>b` | Normal | Jump to alternate buffer |
| `<leader>s` | Normal/Visual | Jump to first non-blank character |
| `<leader>d` | Normal/Visual | Jump to end of line |
| `jk` | Insert | Exit insert mode |

## Search and Files

| Mapping | Mode | Action |
| --- | --- | --- |
| `<leader><space>` | Normal | Clear search highlights |
| `<leader>nh` | Normal | Clear search highlights |
| `-` | Normal | Open Oil file explorer |
| `<C-n>` | Normal | Open Oil file explorer |
| `<leader>ff` | Normal | Telescope find files |
| `<leader>fg` | Normal | Telescope live grep |
| `<leader>fb` | Normal | Telescope buffers |
| `<leader>fh` | Normal | Telescope help tags |
| `<leader>fr` | Normal | Telescope recent files |
| `<leader>fd` | Normal | Telescope diagnostics |

## Editing

| Mapping | Mode | Action |
| --- | --- | --- |
| `gc` | Normal/Visual | Toggle comment |
| `gb` | Normal/Visual | Toggle block comment |
| `s` | Normal/Visual/Operator | Flash jump |
| `S` | Normal/Visual/Operator | Flash Treesitter jump |
| `<leader>re` | Normal | Replace word under cursor |
| `<leader>m` | Insert | Append semicolon to end of line |
| `<leader>cf` | Normal/Visual | Format buffer or range |

## Markdown

| Mapping | Mode | Action |
| --- | --- | --- |
| `<leader>mp` | Normal | Toggle Markdown preview |
| `<leader>me` | Normal | Expand Markdown preview |
| `<leader>mc` | Normal | Contract Markdown preview |

## Registers and Clipboard

| Mapping | Mode | Action |
| --- | --- | --- |
| `<leader>cpa` | Visual | Copy selection to register `a` |
| `<leader>cpwa` | Normal | Copy word to register `a` |
| `<leader>cpla` | Normal | Copy line to register `a` |
| `<leader>pa` | Normal | Paste register `a` |
| `<leader>cpb` | Visual | Copy selection to register `b` |
| `<leader>cpwb` | Normal | Copy word to register `b` |
| `<leader>cplb` | Normal | Copy line to register `b` |
| `<leader>pb` | Normal | Paste register `b` |
| `<leader>cp+` | Visual | Copy selection to system clipboard |
| `<leader>cpw+` | Normal | Copy word to system clipboard |
| `<leader>cpl+` | Normal | Copy line to system clipboard |
| `<leader>p+` | Normal | Paste system clipboard |

## Git

| Mapping | Mode | Action |
| --- | --- | --- |
| `<leader>gg` | Normal | Open Fugitive Git status |
| `]c` | Normal | Next Git hunk |
| `[c` | Normal | Previous Git hunk |
| `<leader>gb` | Normal | Blame current line |
| `<leader>gp` | Normal | Preview current hunk |
| `<leader>gr` | Normal | Reset current hunk |
| `<leader>gs` | Normal | Stage current hunk |

## Configuration

| Mapping | Mode | Action |
| --- | --- | --- |
| `<leader>ev` | Normal | Edit main Neovim config |
| `<leader>epl` | Normal | Edit plugin specs directory |
| `<leader>ecs` | Normal | Edit core config directory |

## Python

| Mapping | Mode | Action |
| --- | --- | --- |
| `<leader>cv` | Normal | Select Python virtualenv |

## Rust

These mappings are available in Rust buffers.

| Mapping | Mode | Action |
| --- | --- | --- |
| `<leader>ra` | Normal | Rust code action |
| `<leader>rh` | Normal | Rust hover actions |
| `<leader>rr` | Normal | Rust runnables |
| `<leader>rt` | Normal | Rust testables |
| `<leader>rd` | Normal | Rust debuggables |
| `<leader>rm` | Normal | Expand Rust macro |

## Tests

| Mapping | Mode | Action |
| --- | --- | --- |
| `<leader>tn` | Normal | Run nearest test |
| `<leader>tf` | Normal | Run current file's tests |
| `<leader>td` | Normal | Debug nearest test |
| `<leader>ts` | Normal | Toggle test summary |
| `<leader>to` | Normal | Open test output |

## Debugging

| Mapping | Mode | Action |
| --- | --- | --- |
| `<leader>Db` | Normal | Toggle breakpoint |
| `<leader>Dc` | Normal | Continue debugging |
| `<leader>Di` | Normal | Step into |
| `<leader>Do` | Normal | Step over |
| `<leader>DO` | Normal | Step out |
| `<leader>Dl` | Normal | Run last debug session |
| `<leader>Dr` | Normal | Open debug REPL |
| `<leader>Du` | Normal | Toggle debug UI |

## LSP Defaults

Neovim 0.12 provides default LSP mappings when an LSP client attaches:

| Mapping | Action |
| --- | --- |
| `grn` | Rename symbol |
| `gra` | Code action |
| `grr` | References |
| `gri` | Implementation |
| `gO` | Document symbols |
| `K` | Hover documentation |
| `<C-s>` in insert mode | Signature help |

Use `:checkhealth vim.lsp` and `:LspInfo` to inspect attached clients.
