local M = {}

M.qn = function(args)
	print("Your args " .. args)
end

vim.api.nvim_create_user_command("qn", function(opts)
	M.qn(opts.args)
end, { nargs = "?" })

return M
