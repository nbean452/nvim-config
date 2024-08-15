require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "kj", "<ESC>")

-- easymotion-s2
vim.api.nvim_set_keymap("n", "s", "<Plug>(easymotion-s2)", {})

-- copilot
vim.g.copilot_no_tab_map = true
map("i", "<C-f>", 'copilot#Accept("\\<CR>")', { replace_keycodes = false, silent = true, expr = true })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- go to next/prev diagnostic
vim.keymap.set("n", "]g", vim.diagnostic.goto_next)
vim.keymap.set("n", "[g", vim.diagnostic.goto_prev)

-- close references window after pressing enter
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    local bufnr = vim.fn.bufnr "%"
    vim.keymap.set("n", "<cr>", function()
      vim.api.nvim_command [[execute "normal! \<cr>"]]
      vim.api.nvim_command(bufnr .. "bd")
    end, { buffer = bufnr })
  end,
  pattern = "qf",
})

local cmp = require "cmp"

-- Create a toggle function
function _G.cmp_toggle()
  if cmp.visible() then
    cmp.close()
  else
    cmp.complete()
  end
end

-- Map the toggle function to Ctrl+K
vim.api.nvim_set_keymap("i", "<C-k>", "<Cmd>lua cmp_toggle()<CR>", { noremap = true, silent = true })
