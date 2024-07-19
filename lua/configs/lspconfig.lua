-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = {
  "html",
  "cssls",
  "tsserver",
  "eslint",
  "java_language_server",
  "docker_compose_language_service",
  "dockerls",
  "clangd",
  "tailwindcss",
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
  on_new_config = function(new_config, root_dir)
    local pipfile_exists = require("lspconfig").util.search_ancestors(root_dir, function(path)
      local pipfile = require("lspconfig").util.path.join(path, "Pipfile")
      if require("lspconfig").util.path.is_file(pipfile) then
        return true
      else
        return false
      end
    end)

    if pipfile_exists then
      new_config.cmd = { "pipenv", "run", "pyright-langserver", "--stdio" }
    end
  end,
}
