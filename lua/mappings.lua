require "nvchad.mappings"

local map = vim.keymap.set
local nomap = vim.keymap.del

local cmp = require "cmp"
local harpoon = require "harpoon"
local opts = { noremap = true, silent = true }

-- Functions
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

local function open_theme_menu()
  require("nvchad.themes").open()
end

local function close_references_window()
  local bufnr = vim.fn.bufnr "%"
  map("n", "<cr>", function()
    vim.api.nvim_command [[execute "normal! \<cr>"]]
    vim.api.nvim_command(bufnr .. "bd")
  end, { buffer = bufnr })
end

-- Basic mappings, other mappings are included in the `configs` folder

map("i", "jk", "<ESC>")
map("i", "kj", "<ESC>")

-- go to next/prev diagnostic
map("n", "]g", vim.diagnostic.goto_next)
map("n", "[g", vim.diagnostic.goto_prev)

-- Close other buffers except this one
map("n", "<leader>db", ":%bd|e#<CR>", opts)

-- Map the toggle completion function to Ctrl+K
map("i", "<C-k>", cmp_toggle, opts)

-- copilot
-- vim.g.copilot_no_tab_map = true
-- map("i", "<C-f>", 'copilot#Accept("\\<CR>")', { replace_keycodes = false, silent = true, expr = true })

-- close references window after pressing enter
vim.api.nvim_create_autocmd("FileType", {
  callback = close_references_window,
  pattern = "qf",
})

-- Disable default NVChad keybindings
-- nomap("n", "<C-i>")
-- nomap("n", "<C-o>")

-- local conf = require("telescope.config").values
-- local function toggle_telescope(harpoon_files)
--   local file_paths = {}
--   for _, item in ipairs(harpoon_files.items) do
--     table.insert(file_paths, item.value)
--   end
--
--   require("telescope.pickers")
--     .new({}, {
--       prompt_title = "Harpoon",
--       finder = require("telescope.finders").new_table {
--         results = file_paths,
--       },
--       previewer = conf.file_previewer {},
--       sorter = conf.generic_sorter {},
--     })
--     :find()
-- end

-- Add current buffer to Harpoon list
map("n", "<leader>q", function()
  -- get current buffer name
  local bufname = vim.fn.bufname "%"

  -- get buffer value given the buffer name that we provided
  -- if `name` is empty, add to harpoon
  local name, _ = harpoon:list():get_by_value(bufname)

  if name == nil then
    harpoon:list():add()
    print("added " .. bufname)
  else
    harpoon:list():remove()
    print("removed " .. bufname)
  end
end, { desc = "add/remove current buffer to harpoon list" })

-- Toggle Harpoon menu
-- using telescope to show harpoon menu
-- map("n", "<C-q>", function()
--   toggle_telescope(harpoon:list())
-- end, { desc = "open harpoon menu" })
-- using native harpoon menu
map("n", "<C-e>", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "open harpoon menu" })

-- Select buffers stored within Harpoon list
map("n", "<C-x>", function()
  harpoon:list():select(1)
end, { desc = "select harpoon file 1" })
map("n", "<C-v>", function()
  harpoon:list():select(2)
end, { desc = "select harpoon file 2" })
map("n", "<C-b>", function()
  harpoon:list():select(3)
end, { desc = "select harpoon file 3" })
map("n", "<C-m>", function()
  harpoon:list():select(4)
end, { desc = "select harpoon file 4" })

-- Toggle previous & next buffers stored within Harpoon list
map("n", "<C-q>p", function()
  harpoon:list():prev()
end, { desc = "cycle to previous harpoon file" })
map("n", "<C-q>n", function()
  harpoon:list():next()
end, { desc = "cycle to next harpoon file" })

-- unmap default keybinding for theme and set it to `<leader>mt`
nomap("n", "<leader>th")
map("n", "<leader>mt", open_theme_menu, { desc = "telescope nvchad themes" })

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

-- Tmux navigation in normal mode
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", opts)
map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", opts)
map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", opts)
map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", opts)
-- map("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<CR>", opts)

-- harpoon extension
harpoon:extend {
  UI_CREATE = function(cx)
    vim.keymap.set("n", "<C-v>", function()
      harpoon.ui:select_menu_item { vsplit = true }
    end, { buffer = cx.bufnr })

    -- vim.keymap.set("n", "<C-x>", function()
    --   harpoon.ui:select_menu_item { split = true }
    -- end, { buffer = cx.bufnr })

    -- vim.keymap.set("n", "<C-t>", function()
    --   harpoon.ui:select_menu_item { tabedit = true }
    -- end, { buffer = cx.bufnr })
  end,
}
