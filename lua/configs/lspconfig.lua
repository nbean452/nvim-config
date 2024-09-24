local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = {
  "html",
  "cssls",
  "ts_ls",
  "eslint",
  "jdtls",
  "docker_compose_language_service",
  "dockerls",
  "clangd",
  "tailwindcss",
  "jsonls",
  "lemminx",
  -- something wrong with this lsp
  -- "kotlin_language_server",
  "phpactor",
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- lsps with custom config
lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.jdtls.setup {}
