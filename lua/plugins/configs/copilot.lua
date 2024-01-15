local status, copilot = pcall(require, "copilot")

if not status then
	return
end

--copilot.setup({
--	suggestion = {
--		enable = true,
--		auto_trigger = false,
--		debounce = 75,
--		keymap = {
--			accept = "<M-l>", 
--			next = "<M-]>",
--			prev = "<M-[>",
--			dismiss = "<C-[>",
--		},
--	},
--})


