return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
    lazy = false,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {},
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- vim stuff
        "vim",
        "lua",
        "vimdoc",

        -- scripting languages
        "bash",

        -- docs
        "markdown",
        "markdown_inline",

        -- CI/CD
        "dockerfile",
        "yaml",

        -- web dev
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "php",

        -- general purpose
        "python",

        -- heavy stuff
        "c",
        "cpp",
        "java",
      },
    },
  },
}
