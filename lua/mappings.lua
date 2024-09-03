require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

local nomap = vim.keymap.del

map("i", "jk", "<ESC>")
map("i", "kj", "<ESC>")

-- copilot
vim.g.copilot_no_tab_map = true
map("i", "<C-f>", 'copilot#Accept("\\<CR>")', { replace_keycodes = false, silent = true, expr = true })

-- go to next/prev diagnostic
map("n", "]g", vim.diagnostic.goto_next)
map("n", "[g", vim.diagnostic.goto_prev)

-- close references window after pressing enter
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    local bufnr = vim.fn.bufnr "%"
    map("n", "<cr>", function()
      vim.api.nvim_command [[execute "normal! \<cr>"]]
      vim.api.nvim_command(bufnr .. "bd")
    end, { buffer = bufnr })
  end,
  pattern = "qf",
})

local cmp = require "cmp"

-- Create a toggle function
local function cmp_toggle()
  if cmp.visible() then
    cmp.close()
  else
    cmp.complete()
  end
end

local function toggle_line()
  require("Comment.api").toggle.linewise.current()
end

nomap("n", "<leader>th")

map("n", "<leader>mt", "<cmd>Telescope themes<CR>", { desc = "telescope nvchad themes" })

-- if you wanna set theme, uncomment
-- map(
--   "n",
--   "<leader>th",
--   "<cmd>lua require('telescope.builtin').help_tags()<CR>",
--   { noremap = true, silent = true }
-- )

local opts = { noremap = true, silent = true }

-- Map the comment functions to <leader>t
nomap("n", "<leader>/")
nomap("v", "<leader>/")

-- Mapping for normal mode
map("n", "<leader>t", toggle_line, { desc = "Toggle comment line", noremap = true, silent = true })
-- Mapping for visual mode
map(
  "v",
  "<leader>t",
  "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
  { desc = "Toggle selection", noremap = true, silent = true }
)

-- Map the toggle completion function to Ctrl+K
map("i", "<C-k>", cmp_toggle, opts)

-- Tmux navigation in normal mode
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", opts)
map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", opts)
map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", opts)
map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", opts)
map("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<CR>", opts)
