local M = {}

M.quickNote = function(opts)
	local args = vim.split(opts.args, " ")
	print("Your args " .. vim.inspect(args))
end

vim.api.nvim_create_user_command(
	"QuickNote",
	function(opts)
		M.quickNote(opts.args)
	end,
	{ nargs = "*" })

return M
