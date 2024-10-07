return {
  -- nvim-treesitter/nvim-treesitter
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
        "kotlin",
        "xml",
      },
    },
  },
}
