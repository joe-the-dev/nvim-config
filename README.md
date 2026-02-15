# Neovim Configuration

A modern, IntelliJ IDEA-inspired Neovim configuration with LSP, GitHub Copilot, and a beautiful UI.

## ✨ Features

- 🤖 **GitHub Copilot** integration with Tab key
- 🔍 **LSP Support** with Mason auto-installation
- 🎨 **Beautiful UI** with Catppuccin & NeoSolarized themes
- 📁 **File Explorer** with nvim-tree
- 🔎 **Fuzzy Finding** with Telescope
- 🎯 **Auto-formatting** on save with conform.nvim
- ✅ **Linting** with nvim-lint
- 🌳 **Git Integration** with gitsigns
- 💬 **Smart Commenting** with Comment.nvim
- ⌨️ **IntelliJ-like Keybindings**
- 📝 **Tab Management** with bufferline

## 📋 Requirements

- Neovim >= 0.11.0 (uses new `vim.lsp.config` API)
- Git
- Node.js (for LSP servers)
- A [Nerd Font](https://www.nerdfonts.com/) for icons
- Clipboard tool: `xclip`, `xsel`, or `wl-clipboard` (Linux)

## 🚀 Quick Start

1. **Backup your existing config**
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **This config is already in place at ~/.config/nvim**

3. **Launch Neovim**
   ```bash
   nvim
   ```
   First launch will automatically install all plugins and LSP servers (be patient!).

4. **Install clipboard support** (Linux)
   ```bash
   # X11 systems
   sudo pacman -S xclip
   # or
   sudo apt install xclip

   # Wayland systems  
   sudo pacman -S wl-clipboard
   # or
   sudo apt install wl-clipboard
   ```

## 📚 Documentation

- **[KEYBINDINGS.md](KEYBINDINGS.md)** - Quick reference for all shortcuts
- **[CHANGELOG.md](CHANGELOG.md)** - Recent changes and fixes
- **[MIGRATION_GUIDE.md](MIGRATION_GUIDE.md)** - Guide to vim.lsp.config API (Neovim 0.11+)

## ⌨️ Key Shortcuts

### Essential Shortcuts

| Action | Shortcut |
|--------|----------|
| Find Files | `Ctrl+P` |
| Find in Project | `Ctrl+Shift+F` |
| Recent Files | `Ctrl+E` |
| Save File | `Ctrl+S` |
| File Explorer | `Ctrl+1` |
| Accept Copilot | `Tab` (insert mode) |
| Trigger Completion | `Ctrl+Space` |
| Navigate Completion | `Ctrl+N` / `Ctrl+P` |
| Go to Definition | `Ctrl+B` |
| Find Usages | `Ctrl+U` |
| Rename | `F2` |
| Show Docs | `K` |
| Code Actions | `Alt+Enter` |
| Toggle Comment | `Ctrl+/` |
| Format Code | `Ctrl+Alt+L` (or auto on save) |

See [KEYBINDINGS.md](KEYBINDINGS.md) for complete list.

## 🔧 Configuration Structure

```
~/.config/nvim/
├── init.lua                    # Entry point
├── lazy-lock.json             # Plugin versions lock file
├── lua/
│   ├── lazy_setup.lua         # Plugin definitions
│   ├── options.lua            # Neovim options
│   ├── keymaps.lua            # Keybindings
│   ├── lsp_setup.lua          # LSP configuration
│   ├── cmp_setup.lua          # Completion setup
│   ├── formatting_setup.lua   # Formatting & linting
│   ├── telescope_setup.lua    # Fuzzy finder config
│   ├── tree_setup.lua         # File explorer config
│   └── theme.lua              # Colorscheme setup
├── KEYBINDINGS.md            # Quick reference
├── CHANGELOG.md              # Change history
└── README.md                 # This file
```

## 🎨 Themes

Two colorschemes are included:

1. **NeoSolarized** (default) - Classic Solarized theme
2. **Catppuccin** - Modern, vibrant theme

To switch themes, edit `lua/theme.lua` or `lua/lazy_setup.lua`.

## 🔌 Plugins

### Core
- [lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin manager
- [mason.nvim](https://github.com/williamboman/mason.nvim) - LSP installer
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - LSP configurations

### UI
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) - Status line
- [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) - Tab line
- [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) - File explorer
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) - Icons

### Editing
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Syntax highlighting
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - Completion engine
- [LuaSnip](https://github.com/L3MON4D3/LuaSnip) - Snippet engine
- [Comment.nvim](https://github.com/numToStr/Comment.nvim) - Commenting
- [copilot.vim](https://github.com/github/copilot.vim) - GitHub Copilot

### Tools
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy finder
- [conform.nvim](https://github.com/stevearc/conform.nvim) - Formatting
- [nvim-lint](https://github.com/mfussenegger/nvim-lint) - Linting
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Git integration

## 🛠️ Customization

### Adding LSP Servers

Edit `lua/lsp_setup.lua`:

```lua
ensure_installed = {
  "lua_ls",
  "ts_ls",
  "pyright",  -- Add Python support
  "gopls",    -- Add Go support
  -- Add more servers here
},
```

### Adding Formatters

Edit `lua/formatting_setup.lua`:

```lua
formatters_by_ft = {
  lua = { "stylua" },
  python = { "black", "isort" },  -- Add Python formatting
  go = { "gofmt" },                -- Add Go formatting
  -- Add more formatters here
},
```

### Changing Leader Key

Edit `lua/options.lua`:

```lua
vim.g.mapleader = " "  -- Change from space to something else
```

## 🐛 Troubleshooting

### Plugins won't install
```vim
:Lazy sync
```

### LSP not working
```vim
:Mason
" Then press 'i' to install servers
```

### Copilot not working
```vim
:Copilot setup
" Follow authentication prompts
```

### Check system health
```vim
:checkhealth
```

### View error messages
```vim
:messages
```

## 📖 Learning Resources

- `:help` - Built-in help system
- `:Tutor` - Interactive Vim tutorial
- [Neovim Documentation](https://neovim.io/doc/)
- [LSP Guide](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)

## 🤝 Support

For issues or questions:
1. Check `:checkhealth`
2. Review error messages with `:messages`
3. Check plugin documentation
4. Search GitHub issues for specific plugins

## 📝 License

This configuration is free to use and modify.

---

**Last Updated:** February 15, 2026
**Status:** ✅ Production Ready

