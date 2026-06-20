# Agent Instructions

This Neovim configuration is maintained in two places:

- Active config: `~/.config/nvim`
- Backup/reference repo: `~/code/custom-vim`

When an agent updates this configuration:

1. If `~/.config/nvim` exists, update that active configuration first.
2. Test the active configuration before copying changes into the backup repo.
3. After the active config passes verification, mirror the same changes into
   `~/code/custom-vim` so it remains a backup of the working setup.
4. Keep `README.md` and `docs/` current with every behavior, plugin, keymap, or
   maintenance workflow change. The docs should remain a modern reference for
   anyone who wants to install, understand, or extend this Neovim setup.
5. Do not leave plugin/tooling changes undocumented.

Recommended verification after config edits:

```sh
nvim --headless "+lua print('nvim config ok')" +qa
nvim --headless "+checkhealth vim.lsp" "+checkhealth provider" +qa
```

For plugin changes, also run the relevant lazy-loaded command or filetype check
so errors are caught before mirroring the config.
