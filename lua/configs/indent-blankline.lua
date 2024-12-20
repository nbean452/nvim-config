local M = {}

function M.setup(conf)
  return vim.tbl_extend("force", conf, {
    scope = {
      enabled = true,
      show_start = true,
      show_end = false,
      injected_languages = false,
      highlight = { "Function", "Label" },
      priority = 500,
    },
  })
end

return M
