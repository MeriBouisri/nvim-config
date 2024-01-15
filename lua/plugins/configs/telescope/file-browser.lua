local ok_telescope, telescope = pcall(require, "telescope")

if not ok_telescope then
	print("[telescope-file-browser] Failed to load telescope")
	return
end

local mapping_opts = { noremap = true }
vim.api.nvim_set_keymap("n", "<leader>te", "<Cmd>Telescope file_browser<CR>", mapping_opts) 
vim.api.nvim_set_keymap("n", "<leader>tE", "<Cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>", mapping_opts) 



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
