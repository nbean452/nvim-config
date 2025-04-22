return {
  -- neovim/nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "Hoffs/omnisharp-extended-lsp.nvim",
    },
    config = function()
      require "configs.nvim-lspconfig"
    end,
  },
}
