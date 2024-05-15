local status, neotree = pcall(require, "neo-tree")

if not status then
	return
end
local root_dir = os.getenv("HOME")
local mapping_opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader><Tab>", "<Cmd>Neotree toggle<CR>", mapping_opts)
vim.keymap.set("n", "<leader>e", "<Cmd>Neotree position=left<CR>", mapping_opts)

local to_trash_folder = function(state)
	local path = state.tree:get_node().path
	vim.fn.system({ "trash", vim.fn.fnameescape(path) })
	require("neo-tree.sources.manager").refresh(state.name)
end

neotree.setup({
	enable_git_status = false,
	default_component_configs = {
		symlink_target = {
			enabled = true,
		},
		icon = {
			default = "",
			folder_closed = "",
			folder_open = "",
		},
	},
	source_selector = {
		sources = {
			{
				source = "filesystem",                                -- string
				display_name = " 󰉓 Files "                            -- string | nil
			},
			{
				source = "buffers",                                   -- string
				display_name = " 󰈚 Buffers "                          -- string | nil
			},
			{
				source = "git_status",                                -- string
				display_name = " 󰊢 Git "                              -- string | nil
			},
		},
	},
	window = {
		position = "left",
		width = 30,
		mapping_options = mapping_opts, 
		mappings = {
			["l"] = "open",
		},
	},
	filesystem = {
		follow_current_file = { enabled = false },
		use_libuv_file_watcher = true,
		group_empty_dirs = true,

		filtered_items = {
			visible = true,
			hide_dotfiles = false,
			hide_gitignored = false,
		},
		window = {
			mapping_options = mapping_opts, 
			mappings = {
				["L"] = "set_root",
				["H"] = "navigate_up",
				["D"] = to_trash_folder,
				--["D"] = function(state)
				--	local path = state.tree:get_node().path
				--	vim.fn.system({ "trash", vim.fn.fnameescape(path) })
				--	require("neo-tree.sources.manager").refresh(state.name)
				--end,
			},
		},
	},

	buffers = {
		follow_current_file = {
			enabled = true,
		},
	},
})

