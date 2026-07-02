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
| `<C-n>` | Normal | Toggle Neo-tree and reveal current file |
| `<leader>ft` | Normal | Focus Neo-tree and reveal current file |
| `<leader>fT` | Normal | Close Neo-tree |
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

## Notebooks

These mappings are for `.ipynb` files opened through Jupytext or Python files
using `# %%` cell markers.

| Mapping | Mode | Action |
| --- | --- | --- |
| `<leader>ni` | Normal | Initialize notebook kernel |
| `<leader>nn` | Normal | Run current notebook cell |
| `<leader>nm` | Normal | Run current notebook cell and move down |
| `<leader>na` | Normal | Run all notebook cells |
| `<leader>nb` | Normal | Add notebook cell below |
| `<leader>nB` | Normal | Add notebook cell above |
| `]n` | Normal | Move to next notebook cell |
| `[n` | Normal | Move to previous notebook cell |
| `<leader>nl` | Normal | Run current notebook line |
| `<leader>nr` | Normal | Re-run active notebook cell |
| `<leader>ne` | Normal/Visual | Run operator or visual selection |
| `<leader>no` | Normal | Show notebook output |
| `<leader>nH` | Normal | Hide notebook output |
| `<leader>nd` | Normal | Delete notebook output |
| `<leader>nI` | Normal | Import notebook outputs |
| `<leader>nE` | Normal | Export notebook outputs |
| `<leader>nR` | Normal | Restart notebook kernel |
| `<leader>nq` | Normal | Stop notebook kernel |

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
| `<leader>gl` | Normal | Open interactive commit graph |
| `<leader>gd` | Normal | Open working tree/index diff in Diffview |
| `<leader>gD` | Normal | Close Diffview |
| `<leader>gh` | Normal | Open repository history in Diffview |
| `<leader>gH` | Normal | Open current file history in Diffview |
| `<leader>gT` | Normal | Open Neo-tree git status tree |
| `]c` | Normal | Next Git hunk |
| `[c` | Normal | Previous Git hunk |
| `<leader>gb` | Normal | Blame current line |
| `<leader>gp` | Normal | Preview current hunk |
| `<leader>gr` | Normal | Reset current hunk |
| `<leader>gs` | Normal | Stage current hunk |

Inside the commit graph, press `Enter` on a commit to open that commit in
Diffview. Visual-select a commit range and press `Enter` to diff the selected
range.

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
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gy` | Go to type definition |
| `grn` | Rename symbol |
| `gra` | Code action |
| `grr` | References |
| `gri` | Implementation |
| `gO` | Document symbols |
| `K` | Hover documentation |
| `<C-s>` in insert mode | Signature help |

Use `:checkhealth vim.lsp` and `:LspInfo` to inspect attached clients.
