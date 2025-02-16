require "nvchad.options"

-- add yours here!

local o = vim.o
local ft = vim.filetype


o.scrolloff = 999 -- equivalent to 'set scrolloff=999'

o.number = true -- equivalent to 'set nu'
o.relativenumber = true -- equivalent to 'set rnu'

o.linebreak = true -- equivalent to 'set linebreak'

o.cursorlineopt = "both" -- to enable cursorline!
o.cursorcolumn = true -- to enable cursorcolumn!
o.lazyredraw = true -- equivalent to 'set lazyredraw'
o.ttyfast = true -- equivalent to 'set ttyfast'

o.wrap = false
o.breakindent = true
o.breakindentopt = "shift:4"

o.foldcolumn = "1"
o.foldlevel = 99
o.foldlevelstart = 99
o.foldenable = true
o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

o.conceallevel = 3

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
