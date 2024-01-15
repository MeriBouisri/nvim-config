local opt = vim.opt

opt.termguicolors = true
opt.number = true
opt.relativenumber = false
opt.shiftwidth = 2
opt.tabstop = 2
--opt.smartindent = true

-- Height for cmp window
opt.pumheight = 10


-- Delay for key sequences
opt.timeoutlen = 500

-- No delay on <Esc> key
opt.ttimeoutlen = 0

vim.cmd.colorscheme("everforest")
