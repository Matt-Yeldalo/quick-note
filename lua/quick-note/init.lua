local M = {}
local config = require("quick-note.config")
local path = require("quick-note.path")

M.quickNote = function(opts)
	local len = #opts

	if opts == nil or opts[0] == nil or len < 1 then
		path.open()
		return
	end

	if len < 2 then
		path.open_with_opts(opts)
	end
end

function M.setup(opts)
	config.setup(opts)

	vim.api.nvim_create_user_command("QuickNote", function()
		M.quickNote(vim.split(opts.args or "" , " "))
	end, { nargs = "*" })
end

return M
