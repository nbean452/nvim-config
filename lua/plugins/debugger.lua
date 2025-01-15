return {
  -- mfussenegger/nvim-dap
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",

      "mfussenegger/nvim-dap-python",
    },
    config = function()
      require("configs.debugger").setup()
    end,
    lazy = false,
  },
}
