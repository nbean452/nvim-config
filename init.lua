vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

-- Additional configurations
vim.schedule(function()
  -- vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })

  -- Set relative number and number
  vim.opt.number = true -- equivalent to 'set nu'
  vim.opt.relativenumber = true -- equivalent to 'set rnu'

  -- Set scrolloff
  vim.opt.scrolloff = 5 -- equivalent to 'set scrolloff=5'

  -- Set linebreak
  vim.opt.linebreak = true -- equivalent to 'set linebreak'
end)
