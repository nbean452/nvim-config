require "nvchad.options"

-- add yours here!

local o = vim.o
o.cursorlineopt = "both" -- to enable cursorline!
o.cursorcolumn = true -- to enable cursorcolumn!

o.scrolloff = 999 -- equivalent to 'set scrolloff=999'

o.number = true -- equivalent to 'set nu'
o.relativenumber = true -- equivalent to 'set rnu'

o.linebreak = true -- equivalent to 'set linebreak'

o.lazyredraw = true -- equivalent to 'set lazyredraw'
o.ttyfast = true -- equivalent to 'set ttyfast'
