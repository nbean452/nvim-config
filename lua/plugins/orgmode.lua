return {
  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    dependencies = {
      "nvim-orgmode/telescope-orgmode.nvim",
      "lukas-reineke/headlines.nvim",
      "danilshvalov/org-modern.nvim",
      "nvim-orgmode/org-bullets.nvim",
    },
    config = function()
      local Menu = require "org-modern.menu"

      -- require("org-bullets").setup()
      -- require("headlines").setup()

      require("telescope").setup()
      require("telescope").load_extension "orgmode"

      local map = vim.keymap.set

      map(
        "n",
        "<leader>or",
        require("telescope").extensions.orgmode.refile_heading,
        { desc = "[orgmode] Refile heading" }
      )
      map(
        "n",
        "<leader>ofh",
        require("telescope").extensions.orgmode.search_headings,
        { desc = "[orgmode] Search headings" }
      )
      map("n", "<leader>oli", require("telescope").extensions.orgmode.insert_link, { desc = "[orgmode] Insert link" })

      -- Setup orgmode
      require("orgmode").setup {
        org_agenda_files = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/default/**/*",
        org_default_notes_file = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/default/refile.org",
        org_todo_keywords = {
          "TODO(t)",
          "PENDING(p)",
          "|",
          "DONE(d)",
          "CANCELLED(c)",
        },

        -- win_split_mode = "float",
        win_split_mode = function(name)
          -- Make sure it's not a scratch buffer by passing false as 2nd argument
          local bufnr = vim.api.nvim_create_buf(false, false)
          --- Setting buffer name is required
          vim.api.nvim_buf_set_name(bufnr, name)

          local fill = 0.8
          local width = math.floor((vim.o.columns * fill))
          local height = math.floor((vim.o.lines * fill))
          local row = math.floor((((vim.o.lines - height) / 2) - 1))
          local col = math.floor(((vim.o.columns - width) / 2))

          vim.api.nvim_open_win(bufnr, true, {
            relative = "editor",
            width = width,
            height = height,
            row = row,
            col = col,
            style = "minimal",
            border = "rounded",
          })
        end,
        win_border = "rounded",

        org_agenda_skip_scheduled_if_done = true,
        org_agenda_skip_deadline_if_done = true,

        ui = {
          menu = {
            handler = function(data)
              Menu:new({
                window = {
                  margin = { 1, 0, 1, 0 },
                  padding = { 0, 1, 0, 1 },
                  title_pos = "center",
                  border = "single",
                  zindex = 1000,
                },
                icons = {
                  separator = "➜",
                },
              }):open(data)
            end,
          },
        },
      }
    end,
  },
}
