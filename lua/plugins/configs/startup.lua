local utils = require("utils")
local err_prefix = "[plugins/configs/startup.lua] "

local _startup, startup = pcall(require, "startup")

if not _startup then
	print(err_prefix .. "Failed to load startup")
	return
end

utils.todo.setup()

local todo_content = utils.todo.tasks



startup.setup({
	section_1 = {
		type = "text",
		align = "center",
		title = "Todo",
		fold_section = false,
		margin = 5,
		content = todo_content, 
		highlight = "String",
		default_color = "#FF0000",
		oldfiles_amount = 5
	},
	parts = {
		"section_1"
	},
})
