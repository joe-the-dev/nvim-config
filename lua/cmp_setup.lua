-- ~/.config/nvim/lua/cmp_setup.lua

local cmp = require("cmp")
local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    -- Use Ctrl-n/Ctrl-p for completion navigation (Tab is reserved for Copilot)
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    -- Alternative: Use Down/Up arrows
    ["<Down>"] = cmp.mapping.select_next_item(),
    ["<Up>"] = cmp.mapping.select_prev_item(),
    -- Snippet navigation with Ctrl-j/Ctrl-k
    ["<C-j>"] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-k>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
  },
})
