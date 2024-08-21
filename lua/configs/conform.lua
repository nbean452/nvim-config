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

formatters_by_ft["java"] = { "google-java-format" }

local options = {
  formatters_by_ft = formatters_by_ft,

  format_on_save = {
    -- These options will be passed to conform.format()
    lsp_format = true,
  },
}

require("conform").setup(options)
