local status, copilot = pcall(require, "copilot")

if not status then
	return
end

local prefix = "<leader>c"

copilot.setup({
	suggestion = {
		enable = true,
		auto_trigger = false,
		debounce = 75,
	--	keymap = {
	--		accept = prefix .. "l", 
	--		next = prefix .. "j",
	--		prev = prefix .. "k",
	--		dismiss = prefix .. "h",
	--	},
	},
})


