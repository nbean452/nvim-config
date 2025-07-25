-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M = {
  base46 = {
    theme = "doomchad",
    -- transparency = true,

    -- hl_override = {
    -- 	Comment = { italic = true },
    -- 	["@comment"] = { italic = true },
    -- },
  },

  ui = {
    telescope = { style = "bordered" }, -- borderless / bordered
  },

  mason = {
    cmd = true,
    pkgs = {
      "intelephense",
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
      "cmake-language-server",
      "spectral-language-server",
      "nginx-language-server",
      "some-sass-language-server",
      "omnisharp",
      "csharpier"
    },
  },
}

return M
