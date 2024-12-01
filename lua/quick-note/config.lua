local M = {}

M.defaults = {
	open_cmd = "vsplit",
	file_name = "general",
	file_type = ".md",
}

--- @param opts QuickNoteOpts
--- @class QuickNoteOpts {open_cmd: string, file_name: string, file_type: string}
--- @field open_cmd string vsplit
--- @field file_name string general
--- @field file_type string .md
function M.setup(opts)
	M.opts = vim.tbl_deep_extend("force", M.defaults, opts or {})
end

return M
