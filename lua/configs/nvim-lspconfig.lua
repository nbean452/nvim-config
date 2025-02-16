-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

local servers = {
  "html",
  "cssls",
  "ts_ls",
  "eslint",
  "docker_compose_language_service",
  "dockerls",
  "clangd",
  "tailwindcss",
  "jsonls",
  "lemminx",
  "phpactor",
  "pyright",
  "jdtls",
  "cmake",
  "spectral",
  "nginx_language_server",
  "somesass_ls",
  "astro",
  "prismals"
}
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- config for `harper-ls` for better grammar
lspconfig.harper_ls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,

  -- change filetypes that are supported
  filetypes = { "markdown", "txt", "pandoc" },
}
