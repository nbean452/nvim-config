local prettier_filetypes = {
  "css",
  "html",
  "javascript",
  "javascriptreact",
  "json",
  "markdown",
  "scss",
  "typescript",
  "typescriptreact",
}

local formatters_by_ft = {
  lua = { "stylua" },
  python = { "isort", "black" },
}

for _, filetype in ipairs(prettier_filetypes) do
  formatters_by_ft[filetype] = { "prettier" }
end

local options = {
  formatters_by_ft = formatters_by_ft,

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

require("conform").setup(options)
