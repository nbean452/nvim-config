local prettier_filetypes = {
  "css",
  "html",
  "json",
  "markdown",
  "scss",
}

local eslint_prettier_filetypes = {
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
}

local clang_format_filetypes = {
  "c",
  "cpp",
}

local formatters_by_ft = {
  lua = { "stylua" },
  python = { "isort", "black" },
}

for _, filetype in ipairs(prettier_filetypes) do
  formatters_by_ft[filetype] = { "prettierd" }
end

for _, filetype in ipairs(eslint_prettier_filetypes) do
  formatters_by_ft[filetype] = { "prettierd", "eslint_d" }
end

for _, filetype in ipairs(clang_format_filetypes) do
  formatters_by_ft[filetype] = { "clang-format" }
end

formatters_by_ft["java"] = { "google-java-format" }
formatters_by_ft["xml"] = { "xmlformatter" }
formatters_by_ft["php"] = { "phpactor" }
formatters_by_ft["sh"] = { "shfmt" }
formatters_by_ft["yaml"] = { "yamlfix" }
formatters_by_ft["astro"] = { "prettier" }

local options = {
  formatters_by_ft = formatters_by_ft,

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   lsp_format = true,
  -- },
}

return options
