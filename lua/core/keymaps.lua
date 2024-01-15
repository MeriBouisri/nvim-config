local utils = require("utils")

local opts = { noremap = true, silent = true }


-- Toggle between relative and absolute line numbers

vim.keymap.set("n", "<leader>nn", utils.functions.toggle_relnum, opts) 



