return {
  -- windwp/nvim-ts-autotag
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
    lazy = false,
  },
}
