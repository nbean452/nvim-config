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

        -- writing resume lol
        "latex",

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
        "prisma",

        "nginx",
        "svelte",

        -- general purpose
        "python",

        -- heavy stuff
        "c",
        "c_sharp",
        "cmake",
        "cpp",
        "java",
        "kotlin",
        "xml",
      },
    },
  },
}
