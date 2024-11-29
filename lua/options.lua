require "nvchad.options"

-- add yours here!

local o = vim.o
local ft = vim.filetype

o.cursorlineopt = "both" -- to enable cursorline!
o.cursorcolumn = true -- to enable cursorcolumn!

o.scrolloff = 999 -- equivalent to 'set scrolloff=999'

o.number = true -- equivalent to 'set nu'
o.relativenumber = true -- equivalent to 'set rnu'

o.linebreak = true -- equivalent to 'set linebreak'

o.lazyredraw = true -- equivalent to 'set lazyredraw'
o.ttyfast = true -- equivalent to 'set ttyfast'

o.wrap = false
o.breakindent = true
o.breakindentopt = "shift:4"

ft.add {
  extension = {
    gotmpl = "gotmpl",
  },
  pattern = {
    [".*/templates/.*%.tpl"] = "helm",
    [".*/templates/.*%.ya?ml"] = "helm",
    ["helmfile.*%.ya?ml"] = "helm",
  },
}
