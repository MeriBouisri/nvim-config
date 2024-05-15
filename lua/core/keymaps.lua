local utils = require("utils")

local err_prefix = "[core/keymaps.lua] "
local opts = { noremap = true, silent = true }


-- Toggle between relative and absolute line numbers

vim.keymap.set("n", "<leader>nn", utils.functions.toggle_relnum, opts) 

-- TODO : keymap leaders here

local telescope_keymaps = function()
	local _telescope, telescope = pcall(require, "telescope")
	
	if not _telescope then
		print(err_prefix .. "Failed to load telescope")
		return
	end

	vim.api.nvim_set_keymap("n", "<leader>te", "<Cmd>Telescope file_browser<CR>", opts) 
	vim.api.nvim_set_keymap("n", "<leader>tE", "<Cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>", opts) 
	

		

end

local copilot_keymaps = function()
	local _copilot, copilot = pcall(require, "copilot")

	if not _copilot then
		print(err_prefix .. "Failed to load copilot")
		return
	end

	local _copilot_suggestions, copilot_suggestions = pcall(require, "copilot.suggestion")

	if not _copilot_suggestions then
		print(err_prefix .. "Failed to load copilot.suggestions")
		return
	end

	vim.keymap.set("i", '<C-l>', copilot_suggestions.accept, opts)
	vim.keymap.set("i", '<C-k>', copilot_suggestions.next, opts)
	vim.keymap.set("i", '<C-j>', copilot_suggestions.prev, opts)
	vim.keymap.set("i", '<C-h>', copilot_suggestions.dismiss, opts)
	vim.keymap.set("i", '<C-c>', copilot_suggestions.toggle_auto_trigger, opts)
	--vim.api.nvim_set_keymap("n", prefix .. "x", '<Plug>(copilot-suggest)', opts)

end

telescope_keymaps()

copilot_keymaps()

