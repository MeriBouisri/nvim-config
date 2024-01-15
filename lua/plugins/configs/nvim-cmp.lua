local utils = require("utils")

local has_cmp, cmp = pcall(require, "cmp")
if not has_cmp then
	return
end

local has_luasnip, luasnip = pcall(require, "luasnip")
if not has_luasnip then
	print("[ERROR] Failed to load luasnip")
	return
end

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},

	completion = {
		completeopt = "menu, menuone, noselect",
		winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
		col_offset = -3,
		side_padding = 0,
	},

	mapping = {
		["<CR>"] = cmp.config.disable,
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-l>"] = cmp.mapping.confirm(),
		["<C-h>"] = cmp.mapping.abort(),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-f>"] = cmp.mapping.scroll_docs(-4),
	},

	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
	}, {
		{ name = "path" },
		{ name = "buffer", keyword_length = 5 },
	}),

	sorting = {
		priority_weight = 1.0,

		comparators = {
			utils.comparators.underscore,
			cmp.config.compare.offset,
			cmp.config.compare.kind,

			-- cmp.config.compare.exact,
			--cmp.config.compare.sort_text,
		},
	},

	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			vim_item.kind = utils.icons.completion[vim_item.kind]
			return vim_item
		end,
	},

	experimental = {
		native_menu = false,
		ghost_text = true,
	},
})
