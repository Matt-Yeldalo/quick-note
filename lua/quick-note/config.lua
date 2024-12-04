local M = {}

local function fetch_opts(key)
	if M["opts"] ~= nil then
		return M["opts"][key]
	end

	return M["defaults"][key]
end

function M.fetch(key)
	return fetch_opts(key)
end

M.defaults = {
	open_cmd = "vsplit",
	file_name = "general",
	file_type = ".md",
}

--- @param opts QuickNoteOpts
--- @class QuickNoteOpts {open_cmd: string, file_name: string, file_type: string}
function M.setup(opts)
	M.opts = vim.tbl_deep_extend("force", M.defaults, opts or {})
end

return M
