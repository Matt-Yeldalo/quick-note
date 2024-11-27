local M = {}

M.QuickNote = function(args)
	print("Your args " .. args)
end

vim.api.nvim_create_user_command("QuickNote", function(opts)
	M.QuickNote(opts.args)
end, { nargs = "?" })

return M
