-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local buf_map = vim.api.nvim_buf_set_keymap
local opts = { noremap = true, silent = true }

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
  "intelephense",
  "pyright",
  "jdtls",
  "cmake",
  "spectral",
  "nginx_language_server",
  "somesass_ls",
  "astro",
  "prismals",
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

lspconfig.omnisharp.setup {
  cmd = { vim.fn.stdpath "data" .. "/mason/bin/omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
  filetypes = { "cs", "vb" },

  on_attach = function(client, bufnr)
    -- Custom keymaps for omnisharp_extended
    buf_map(bufnr, "n", "gd", "<cmd>lua require('omnisharp_extended').lsp_definition()<CR>", opts)
    buf_map(bufnr, "n", "<leader>D", "<cmd>lua require('omnisharp_extended').lsp_type_definition()<CR>", opts)
    buf_map(bufnr, "n", "gr", "<cmd>lua require('omnisharp_extended').lsp_references()<CR>", opts)
    buf_map(bufnr, "n", "gi", "<cmd>lua require('omnisharp_extended').lsp_implementation()<CR>", opts)
  end,

  settings = {
    FormattingOptions = {
      -- Enables support for reading code style, naming convention and analyzer
      -- settings from .editorconfig.
      EnableEditorConfigSupport = true,
      -- Specifies whether 'using' directives should be grouped and sorted during
      -- document formatting.
      OrganizeImports = nil,
    },
    MsBuild = {
      -- If true, MSBuild project system will only load projects for files that
      -- were opened in the editor. This setting is useful for big C# codebases
      -- and allows for faster initialization of code navigation features only
      -- for projects that are relevant to code that is being edited. With this
      -- setting enabled OmniSharp may load fewer projects and may thus display
      -- incomplete reference lists for symbols.
      LoadProjectsOnDemand = nil,
    },
    RoslynExtensionsOptions = {
      -- Enables support for roslyn analyzers, code fixes and rulesets.
      EnableAnalyzersSupport = nil,
      -- Enables support for showing unimported types and unimported extension
      -- methods in completion lists. When committed, the appropriate using
      -- directive will be added at the top of the current file. This option can
      -- have a negative impact on initial completion responsiveness,
      -- particularly for the first few completion sessions after opening a
      -- solution.
      EnableImportCompletion = nil,
      -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
      -- true
      AnalyzeOpenDocumentsOnly = nil,
    },
    Sdk = {
      -- Specifies whether to include preview versions of the .NET SDK when
      -- determining which version to use for project loading.
      IncludePrereleases = true,
    },
  },
}
