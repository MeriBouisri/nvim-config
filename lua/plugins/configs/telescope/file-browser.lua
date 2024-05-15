local ok_telescope, telescope = pcall(require, "telescope")

if not ok_telescope then
	print("[telescope-file-browser] Failed to load telescope")
	return
end




telescope.setup({
	extensions = {
		file_browser = {
			mappings = {
				["i"] = {

				},

				["n"] = {

				},
			},
		},
	}
})

telescope.load_extension("file_browser")
