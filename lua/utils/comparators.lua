local M = {}

-- Place items with leading underscore at the bottom
-- https://github.com/lukas-reineke/cmp-under-comparator
---@param entry1 cmp.Entry
---@param entry2 cmp.Entry
M.underscore = function(entry1, entry2)
	local _, entry1_under = entry1.completion_item.label:find("^_+")
	local _, entry2_under = entry2.completion_item.label:find("^_+")
	entry1_under = entry1_under or 0
	entry2_under = entry2_under or 0
	if entry1_under > entry2_under then
		return false
	elseif entry1_under < entry2_under then
		return true
	end
end

-- Place specified type at the bottom
---@oaram kind lsp.CompletionItemKind
M.deprioritize_kind = function(kind)
	return function(entry1, entry2)
		if entry1.get_kind == kind then
			return true
		end
		if entry2.get_kind == kind then
			return false
		end
	end
end

return M
