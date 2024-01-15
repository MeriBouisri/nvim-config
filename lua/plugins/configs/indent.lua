local _ibl, ibl = pcall(require, "ibl")

if not _ibl then
	print("[plugins/configs/indent] Failed to load indent_blankline")
	return
end


vim.g.indent_blankline_char = "│"

ibl.setup({
	scope = {
		enabled = false,
	}
--show_end_of_line = true,
--	show_current_context = true,
--	show_current_context_start = true,
})
