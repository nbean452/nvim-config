require "nvchad.mappings"

local map = vim.keymap.set
local nomap = vim.keymap.del
local create_autocmd = vim.api.nvim_create_autocmd

local cmp = require "cmp"
local harpoon = require "harpoon"
local gitsigns = require "gitsigns"
local todo_comments = require("todo-comments")

local previewers = require "telescope.previewers"
local builtin = require "telescope.builtin"

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

local delta = previewers.new_termopen_previewer {
  get_command = function(entry)
    -- this is for status
    -- You can get the AM things in entry.status. So we are displaying file if entry.status == '??' or 'A '
    -- just do an if and return a different command
    if entry.status == "??" or "A " then
      return { "git", "-c", "delta.side-by-side=false", "diff", entry.value }
    else
      -- note we can't use pipes
      -- this command is for git_commits and git_bcommits
      return { "git", "-c", "delta.side-by-side=false", "diff", entry.value .. "^!" }
    end
  end,
}

local delta_git_status = function(opts)
  opts = opts or {}
  opts.previewer = delta

  builtin.git_status(opts)
end

local delta_git_commits = function(opts)
  opts = opts or {}
  opts.previewer = delta

  builtin.git_commits(opts)
end

nomap("n", "<leader>gt")
nomap("n", "<leader>cm")

map("n", "<leader>gp", function()
  delta_git_status()
end, { desc = "View changed git files with delta pager" })

map("n", "<leader>gb", function()
  gitsigns.blame_line()
end, { desc = "Show git blame" })

map("n", "<leader>gt", function()
  gitsigns.toggle_current_line_blame { full = true }
end, { desc = "Toggle git blame current line" })

map("n", "]c", function()
  if vim.wo.diff then
    vim.cmd.normal { "]c", bang = true }
  else
    gitsigns.nav_hunk "next"
  end
end, { desc = "Jump to next hunk" })

map("n", "[c", function()
  if vim.wo.diff then
    vim.cmd.normal { "[c", bang = true }
  else
    gitsigns.nav_hunk "prev"
  end
end, { desc = "Jump to previous hunk" })

map("n", "<leader>ft", "<CMD>TodoTelescope<CR>", { desc = "Search todos via Telescope" })

map("n", "]t", function()
  todo_comments.jump_next()
end, { desc = "Next todo comment" })

map("n", "[t", function()
  todo_comments.jump_prev()
end, { desc = "Previous todo comment" })

map("n", "<leader>da", "<CMD>DBUI<CR>", { desc = "Open DB UI" })

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
map("n", "zR", require("ufo").openAllFolds)
map("n", "zM", require("ufo").closeAllFolds)

map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })

map("n", "<leader>cm", function()
  delta_git_commits()
end, { desc = "View git commits with delta pager" })

-- Basic mappings, other mappings are included in the `configs` folder

map("i", "jk", "<ESC>")
map("i", "kj", "<ESC>")

-- go to next/prev diagnostic
map("n", "]g", vim.diagnostic.goto_next)
map("n", "[g", vim.diagnostic.goto_prev)

-- Close other buffers except this one
map("n", "<leader>db", ":%bd|e#<CR>", vim.tbl_extend("force", opts, { desc = "Delete other buffers" }))

-- disable cursor movement in insert mode
nomap("i", "<C-b>")
nomap("i", "<C-e>")
nomap("i", "<C-h>")
nomap("i", "<C-l>")
nomap("i", "<C-j>")
nomap("i", "<C-k>")

-- map completion toggle to Ctrl+k
map("i", "<C-k>", cmp_toggle, opts)

map("n", "<leader>lw", "<cmd>set wrap!<CR>", { desc = "Toggle line wrap" })

-- copilot
-- vim.g.copilot_no_tab_map = true
-- map("i", "<C-f>", 'copilot#Accept("\\<CR>")', { replace_keycodes = false, silent = true, expr = true })

-- close references window after pressing enter
create_autocmd("FileType", {
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

-- unmap default conform mapping
nomap("n", "<leader>fm")
map("n", "<leader>fm", function()
  require("conform").format { async = true, lsp_fallback = true }
end, { desc = "General Format file" })

-- Add current buffer to Harpoon list
map("n", "<C-q>f", function()
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
end, { desc = "Add/remove current buffer to harpoon list" })

-- Toggle Harpoon menu
-- using telescope to show harpoon menu
-- map("n", "<C-q>", function()
--   toggle_telescope(harpoon:list())
-- end, { desc = "open harpoon menu" })
-- using native harpoon menu
map("n", "<C-e>", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Open harpoon menu" })

-- Select buffers stored within Harpoon list
map("n", "<C-f>", function()
  harpoon:list():select(1)
end, { desc = "Select harpoon file 1" })
map("n", "<C-x>", function()
  harpoon:list():select(2)
end, { desc = "Select harpoon file 2" })
map("n", "<C-b>", function()
  harpoon:list():select(3)
end, { desc = "Select harpoon file 3" })
map("n", "<C-p>", function()
  harpoon:list():select(4)
end, { desc = "Select harpoon file 4" })

-- Toggle previous & next buffers stored within Harpoon list
map("n", "<C-q>p", function()
  harpoon:list():prev()
end, { desc = "Cycle to previous harpoon file" })
map("n", "<C-q>n", function()
  harpoon:list():next()
end, { desc = "Cycle to next harpoon file" })

-- unmap default keybinding for theme and set it to `<leader>mt`
nomap("n", "<leader>th")
map("n", "<leader>mt", open_theme_menu, { desc = "Telescope nvchad themes" })

-- Map the comment functions to <leader>t
nomap("n", "<leader>/")
nomap("v", "<leader>/")
-- Mapping for normal mode
map("n", "<leader>t", toggle_line, vim.tbl_extend("force", opts, { desc = "Toggle comment line" }))
-- Mapping for visual mode
map(
  "v",
  "<leader>t",
  "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
  vim.tbl_extend("force", opts, { desc = "Toggle selection" })
)

-- Tmux navigation in normal mode
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", opts)
map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", opts)
map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", opts)
map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", opts)
-- map("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<CR>", opts)

-- change functionality for git
nomap("n", "<leader>fb")
nomap("n", "<leader>ff")
nomap("n", "<leader>fa")

map("n", "<leader>fb", "<cmd>Telescope buffers layout_strategy=vertical<CR>", { desc = "telescope find buffers" })
map("n", "<leader>ff", "<cmd>Telescope find_files layout_strategy=vertical<cr>", { desc = "telescope find files" })
map("n", "<leader>fs", "<cmd>Telescope search_history<cr>", { desc = "telescope search history" })
map("n", "<leader>fc", "<cmd>Telescope command_history<cr>", { desc = "telescope command history" })
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true layout_strategy=vertical<CR>",
  { desc = "telescope find all files" }
)

-- harpoon extension
harpoon:extend {
  UI_CREATE = function(cx)
    map("n", "<C-v>", function()
      harpoon.ui:select_menu_item { vsplit = true }
    end, { buffer = cx.bufnr })

    -- map("n", "<C-x>", function()
    --   harpoon.ui:select_menu_item { split = true }
    -- end, { buffer = cx.bufnr })

    -- map("n", "<C-t>", function()
    --   harpoon.ui:select_menu_item { tabedit = true }
    -- end, { buffer = cx.bufnr })
  end,
}
