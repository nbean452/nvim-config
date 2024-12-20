return {
  -- lukas-reineke/indent-blankline.nvim
  {
    "lukas-reineke/indent-blankline.nvim",
    lazy = false,
    main = "ibl",
    ---@module "ibl"
    opts = function(_, conf)
      return require("configs.indent-blankline").setup(conf)
    end,
  },
}
