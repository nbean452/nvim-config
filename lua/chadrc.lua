-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M = {
  ui = {
    theme = "everforest",

    telescope = { style = "bordered" }, -- borderless / bordered

    -- hl_override = {
    -- 	Comment = { italic = true },
    -- 	["@comment"] = { italic = true },
    -- },
  },

  mason = {
    pkgs = {
      "clang-format",
      "jdtls",
      "isort",
      "black",
      "pyright",
      "clangd",
      "prettierd",
      "google-java-format",
      "eslint_d",
      "typescript-language-server",
      "css-lsp",
      "eslint-lsp",
      "html-lsp",
      "lua-language-server",
      "tailwindcss-language-server",
      "stylua",
      "dockerfile-language-server",
      "docker-compose-language-service",
      "prettier",
    },
  },
}

return M
