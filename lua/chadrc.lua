-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M = {
  base46 = {
    theme = "everforest",
    transparency = false,

    -- hl_override = {
    -- 	Comment = { italic = true },
    -- 	["@comment"] = { italic = true },
    -- },
  },

  ui = {
    telescope = { style = "borderless" }, -- borderless / bordered
  },

  mason = {
    cmd = true,
    pkgs = {
      "phpactor",
      "lemminx",
      "xmlformatter",
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
