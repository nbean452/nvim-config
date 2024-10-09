local harpoon = require "harpoon"
local extensions = require "harpoon.extensions"

harpoon:setup {}
harpoon:extend(extensions.builtins.navigate_with_number())
