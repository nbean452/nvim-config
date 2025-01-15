local M = {}

M.setup = function()
  local dap, dapui = require "dap", require "dapui"
  local sign_define = vim.fn.sign_define

  dapui.setup()
  require("dap-python").setup "~/.pyenv/shims/python"

  require("nvim-dap-virtual-text").setup {
    -- Enable virtual text
    enabled = true,
    -- Highlight variables with new values
    highlight_changed_variables = true,
    -- Highlight new variables as changed
    highlight_new_as_changed = true,
  }

  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
  end

  -- Setup signs
  -- Define custom highlight groups
  vim.cmd [[highlight DapBreakpoint guifg=#E06C75 gui=bold]]
  vim.cmd [[highlight DapBreakpointCondition guifg=#E5C07B gui=bold]]
  vim.cmd [[highlight DapBreakpointRejected guifg=#56B6C2 gui=bold]]
  vim.cmd [[highlight DapStopped guifg=#98C379 gui=bold]]

  -- Define signs with the custom colors
  sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
  sign_define("DapBreakpointCondition", { text = "◆", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
  sign_define("DapBreakpointRejected", { text = "✖", texthl = "DapBreakpointRejected", linehl = "", numhl = "" })
  sign_define("DapStopped", { text = "▶", texthl = "DapStopped", linehl = "DebugLine", numhl = "" })
end

return M
