# Quick Reference - Neovim Keybindings

## 🎯 Most Used Shortcuts

### File Operations
- `Ctrl+S` - Save file
- `Ctrl+P` - Find files
- `Ctrl+E` - Recent files
- `Ctrl+1` - Toggle file explorer

### Code Navigation
- `Ctrl+B` - Go to definition
- `Ctrl+U` - Find usages
- `K` - Show documentation
- `F2` - Rename symbol
- `Alt+Enter` - Code actions

### Editing
- `Ctrl+D` - Duplicate line
- `Ctrl+Y` - Delete line
- `Ctrl+/` - Toggle comment
- `Alt+Up/Down` - Move line up/down
- `Ctrl+Alt+L` - Format code

### Completion vs Copilot
**Copilot (Insert Mode):**
- `Tab` - Accept Copilot suggestion 🤖
- `Ctrl+]` - Next suggestion
- `Ctrl+[` - Previous suggestion

**Completion:**
- `Ctrl+Space` - Trigger completion
- `Ctrl+N` - Next item
- `Ctrl+P` - Previous item
- `Enter` - Confirm

### Git
- `]c` - Next change
- `[c` - Previous change
- `<leader>hp` - Preview change
- `<leader>hs` - Stage change
- `<leader>hr` - Reset change

### Tab Management
- `Ctrl+Tab` - Next tab
- `Ctrl+Shift+Tab` - Previous tab
- `Ctrl+F4` - Close tab
- `<leader>1-5` - Go to tab 1-5

## 💡 Important Notes

1. **Tab Key is Reserved for Copilot**
   - Use `Ctrl+N/P` for completion navigation instead

2. **Leader Key is Space**
   - `<leader>` means press Space first

3. **Clipboard Integration**
   - Install `xclip`, `xsel`, or `wl-clipboard` for system clipboard
   - Copy/paste should work automatically

4. **First Launch**
   - Lazy.nvim will auto-install all plugins
   - Mason will auto-install LSP servers
   - Be patient on first startup!

## 🔧 Commands

- `:Lazy` - Plugin manager
- `:Mason` - LSP server manager
- `:checkhealth` - Check system health
- `:Telescope` - Fuzzy finder
- `:NvimTreeToggle` - Toggle file tree
- `:Gitsigns` - Git commands

## 📋 Cheat Sheet by Category

### Search & Replace
- `Ctrl+F` - Find in file
- `Ctrl+R` - Replace in file
- `Ctrl+Shift+F` - Find in project

### Window Management
- `Ctrl+W` + `hjkl` - Navigate windows
- `Ctrl+W` + `s` - Split horizontal
- `Ctrl+W` + `v` - Split vertical

### Diagnostics
- `F8` - Next error
- `Shift+F8` - Previous error
- `<leader>d` - Show error details

### Terminal
- `F12` - Open terminal
- `Ctrl+\` `Ctrl+N` - Exit terminal mode

