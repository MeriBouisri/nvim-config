-- Menu
vim.api.nvim_set_hl(0, "PMenuSel", { bg = "#293136", fg = "#d3c6aa" })

-- CmpItemAbbr
vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { bg = "NONE", strikethrough = true, fg = "#808080" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { bg = "NONE", fg = "#569CD6" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "CmpIntemAbbrMatch" })

-- CmpItemKind
vim.api.nvim_set_hl(0, "CmpItemKindClass", { bg = "NONE", fg = "#E69875" })
vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { link = "CmpItemKindClass" })
vim.api.nvim_set_hl(0, "CmpItemKindMethod", { link = "CmpItemKindClass" })
vim.api.nvim_set_hl(0, "CmpItemKindProperty", { link = "CmpItemKindClass" })
vim.api.nvim_set_hl(0, "CmpItemKindFunction", { bg = "NONE", fg = "#7FBBB3" })
vim.api.nvim_set_hl(0, "CmpItemKindVariable", { link = "CmpItemKindFunction" })

-- DEBUGGER

vim.fn.sign_define('DapBreakpoint', {text='•', texthl='red', linehl='', numhl=''})

