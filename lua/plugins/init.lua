return {

	-- USER INTERFACE
	{
		"neanias/everforest-nvim",
		name = "everforest",
		priority = 1000,
		opts = {},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("plugins.configs.neo-tree")
		end,
	},

	{
		"startup-nvim/startup.nvim",
		requires = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("plugins.configs.startup")
		end,
	},
--	{
--		"akinsho/bufferline.nvim", version = "*",
--		dependencies = {
--			"nvim-tree/nvim-web-devicons"
--		},
--		config = function()
--			require("plugins.configs.bufferline")
--		end,
--	},
	-- AUTO-COMPLETION

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			require("plugins.configs.nvim-cmp")
		end,
	},

	-- LSP

	{
		"williamboman/mason.nvim",
		lazy = true,
		event = { "VeryLazy" },
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = true,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "VeryLazy", "BufNewFile", "BufReadPost" },
		config = function()
			require("plugins.configs.lsp")
		end,
	},
--	{
--
--		"ray-x/lsp_signature.nvim",
--		event = "VeryLazy",
--		opts = {},
--		config = function(_, opts)
--			require("lsp_signature").setup(opts)
--		end,
--	},

	{
		"folke/neodev.nvim",
		opts = {},
	},
	{
		"mfussenegger/nvim-jdtls",
		lazy = true,
	},

	-- DEBUGGER
	
	{
		"mfussenegger/nvim-dap",
		lazy = true,
	},

	{
		"rcarriga/nvim-dap-ui",
		lazy = true,
		dependencies = {
			"mfussenegger/nvim-dap",
		},
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		lazy = true,
		dependencies = {
			"mfussenegger/nvim-dap"
		},
	},

	-- TREESITTER
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "VeryLazy", "BufNewFile", "BufReadPost" },
		build = ":TSUpdate",
		config = function()
			require("plugins.configs.treesitter")
		end,
	},

	-- TELESCOPE
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.2",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("plugins.configs.telescope.telescope")
		end,
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons"
		},
		config = function()
			require("plugins.configs.telescope.file-browser")
		end,
	},

	-- TOOLS

	{
		"zbirenbaum/copilot.lua",
		lazy = true,
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("plugins.configs.copilot")
		end,
	},
	{
		"frabjous/knap",
		config = function()
			require("plugins.configs.latex.knap")
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function() 
			vim.fn["mkdp#util#install"]() 
		end,

	},
--	{
--		"iurimateus/luasnip-latex-snippets.nvim",
--		requires = { "L3MON4D3/LuaSnip" },
--
--		config = function()
--			require("luasnip-latex-snippets").setup({use_treesitter = true})
--		end,
--	},
	-- TEXT EDITING
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("plugins.configs.autopairs")
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			require("plugins.configs.indent")
		end,
	},
}
