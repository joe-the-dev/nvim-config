-- ~/.config/nvim/lua/lsp_setup.lua

-- Initialize mason
require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

-- Setup mason-lspconfig without ensure_installed
-- We'll install servers manually via :Mason or let them install on-demand
require("mason-lspconfig").setup({
  automatic_installation = true,  -- Auto-install when opening file types
})

-- Get default capabilities from nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Define on_attach callback
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
end

-- Setup LSP servers using new vim.lsp.config API (Neovim 0.11+)
-- See :help lspconfig-nvim-0.11

-- Lua Language Server
vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
})

-- TypeScript Language Server
vim.lsp.config("ts_ls", {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
  capabilities = capabilities,
  on_attach = on_attach,
})

-- HTML Language Server
vim.lsp.config("html", {
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html", "templ" },
  root_markers = { "package.json", ".git" },
  capabilities = capabilities,
  on_attach = on_attach,
})

-- CSS Language Server
vim.lsp.config("cssls", {
  cmd = { "vscode-css-language-server", "--stdio" },
  filetypes = { "css", "scss", "less" },
  root_markers = { "package.json", ".git" },
  capabilities = capabilities,
  on_attach = on_attach,
})

-- JSON Language Server
vim.lsp.config("jsonls", {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  root_markers = { "package.json", ".git" },
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Bash Language Server
vim.lsp.config("bashls", {
  cmd = { "bash-language-server", "start" },
  filetypes = { "sh", "bash" },
  root_markers = { ".git" },
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Markdown Language Server
vim.lsp.config("marksman", {
  cmd = { "marksman", "server" },
  filetypes = { "markdown", "markdown.mdx" },
  root_markers = { ".marksman.toml", ".git" },
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Enable LSP servers for configured filetypes
vim.lsp.enable({ "lua_ls", "ts_ls", "html", "cssls", "jsonls", "bashls", "marksman" })
