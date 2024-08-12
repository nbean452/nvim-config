require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "kj", "<ESC>")

vim.api.nvim_set_keymap("n", "s", "<Plug>(easymotion-s2)", {})

vim.g.copilot_no_tab_map = true
map("i", "<C-f>", 'copilot#Accept("\\<CR>")', { replace_keycodes = false, silent = true, expr = true })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
