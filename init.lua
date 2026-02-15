-- ~/.config/nvim/init.lua
require("lazy_setup")
require("cmp_setup")
require("lsp_setup")
require("telescope_setup")()  -- Call the function
require("tree_setup")
require("formatting_setup")  -- Add formatting and linting
require("keymaps")
require("theme")
require("options")

