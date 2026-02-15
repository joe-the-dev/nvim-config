-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- UI
  { "nvim-lualine/lualine.nvim", opts = {} },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "nvim-tree/nvim-web-devicons" },

  -- File Tabs (Bufferline)
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers", -- set to "tabs" to only show tabpages instead
          style_preset = require("bufferline").style_preset.default, -- or style_preset.minimal,
          themable = true,
          numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
          close_command = "bdelete! %d", -- can be a string | function, | false see "Mouse actions"
          right_mouse_command = "bdelete! %d", -- can be a string | function | false, see "Mouse actions"
          left_mouse_command = "buffer %d", -- can be a string | function, | false see "Mouse actions"
          middle_mouse_command = nil, -- can be a string | function, | false see "Mouse actions"
          indicator = {
            icon = '▎', -- this should be omitted if indicator style is not 'icon'
            style = 'icon', -- | 'underline' | 'none',
          },
          buffer_close_icon = '󰅖',
          modified_icon = '●',
          close_icon = '',
          left_trunc_marker = '',
          right_trunc_marker = '',
          max_name_length = 30,
          max_prefix_length = 30,
          truncate_names = true,
          tab_size = 21,
          diagnostics = "nvim_lsp",
          diagnostics_update_in_insert = false,
          color_icons = true,
          show_buffer_icons = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          show_tab_indicators = true,
          show_duplicate_prefix = true,
          persist_buffer_sort = true,
          move_wraps_at_ends = false,
          separator_style = "slant", -- | "slope" | "thick" | "thin" | { 'any', 'any' },
          enforce_regular_tabs = false,
          always_show_bufferline = true,
          hover = {
            enabled = true,
            delay = 200,
            reveal = {'close'}
          },
          sort_by = 'insert_after_current',
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "left",
              separator = true
            }
          }
        }
      })
    end,
  },

  -- File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("tree_setup")
    end,
  },

  -- LSP and Linting
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim", build = ":MasonUpdate" },
  { "williamboman/mason-lspconfig.nvim" },

  -- Modern formatting and linting (replacing null-ls)
  { "stevearc/conform.nvim" },
  { "mfussenegger/nvim-lint" },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    config = function()
      -- Check if the module exists before requiring
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if not ok then
        vim.notify("nvim-treesitter.configs not available yet", vim.log.levels.WARN)
        return
      end

      configs.setup({
        ensure_installed = { "lua", "vim", "vimdoc", "javascript", "typescript", "json", "bash", "markdown", "markdown_inline" },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      })
    end,
  },

  -- Autocompletion
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "saadparwaiz1/cmp_luasnip" },
    build = "make install_jsregexp"
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }
  },

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add          = { text = '│' },
          change       = { text = '│' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
        numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          follow_files = true
        },
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, {expr=true, desc = 'Next git hunk'})

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, {expr=true, desc = 'Previous git hunk'})

          -- Actions
          map('n', '<leader>hs', gs.stage_hunk, {desc = 'Stage hunk'})
          map('n', '<leader>hr', gs.reset_hunk, {desc = 'Reset hunk'})
          map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc = 'Stage hunk'})
          map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc = 'Reset hunk'})
          map('n', '<leader>hS', gs.stage_buffer, {desc = 'Stage buffer'})
          map('n', '<leader>hu', gs.undo_stage_hunk, {desc = 'Undo stage hunk'})
          map('n', '<leader>hR', gs.reset_buffer, {desc = 'Reset buffer'})
          map('n', '<leader>hp', gs.preview_hunk, {desc = 'Preview hunk'})
          map('n', '<leader>hb', function() gs.blame_line{full=true} end, {desc = 'Blame line'})
          map('n', '<leader>tb', gs.toggle_current_line_blame, {desc = 'Toggle blame line'})
          map('n', '<leader>hd', gs.diffthis, {desc = 'Diff this'})
          map('n', '<leader>hD', function() gs.diffthis('~') end, {desc = 'Diff this ~'})
          map('n', '<leader>td', gs.toggle_deleted, {desc = 'Toggle deleted'})

          -- Text object
          map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', {desc = 'Select hunk'})
        end
      })
    end,
  },

  -- GitHub Copilot
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      -- Enable copilot for all filetypes
      vim.g.copilot_filetypes = {
        ["*"] = true,
      }

      -- Copilot keybindings
      vim.keymap.set('i', '<Tab>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false
      })
      vim.g.copilot_no_tab_map = true

      -- Alternative accept with Ctrl+J (if you prefer)
      vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false
      })

      -- Navigate suggestions
      vim.keymap.set('i', '<C-]>', '<Plug>(copilot-next)')
      vim.keymap.set('i', '<C-[>', '<Plug>(copilot-previous)')
      vim.keymap.set('i', '<C-\\>', '<Plug>(copilot-suggest)')
    end,
  },

  -- Commenting support (IntelliJ-style Ctrl+/)
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        -- Add mappings
        toggler = {
          line = 'gcc',  -- Line-comment toggle
          block = 'gbc', -- Block-comment toggle
        },
        opleader = {
          line = 'gc',   -- Line-comment operator
          block = 'gb',  -- Block-comment operator
        },
        extra = {
          above = 'gcO', -- Add comment on the line above
          below = 'gco', -- Add comment on the line below
          eol = 'gcA',   -- Add comment at the end of line
        },
      })
    end,
  },

  -- Useful Lua dev tools
  { "folke/neodev.nvim" },

  -- Solarized colorscheme
  {
    "Tsuzat/NeoSolarized.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        vim.cmd [[ colorscheme NeoSolarized ]]
    end
  }
},
{
  -- Disable luarocks support to avoid warnings
  rocks = {
    enabled = false,
  },
}
)
