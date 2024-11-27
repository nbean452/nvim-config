return {
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function(_, conf)
      return require("configs.nvimtree").setup(conf)
    end,
  },
}
