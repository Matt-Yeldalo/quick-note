local M = {}

-- opts = {'action', 'name'}
M.quickNote = function(opts)
	print("Your opts are: " .. vim.inspect(opts))
	local len = #opts

	print(opts[0])

	if opts == nil or opts[0] == nil or len < 1 then
		print("Creating new QuickNote project.")
		CreateNew()
		return
	end

	if len < 2 then
		print("Opts are 1")
		ParseAction(opts[0])
		return
	end

	print(opts)
end

function CreateNew()
	print("CreateNew")
end

function ParseAction(action)
	if action == "open" then
		print("open")
	elseif action == "new" then
		print("new")
	end
end

vim.api.nvim_create_user_command("QuickNote", function(opts)
	M.quickNote(vim.split(opts.args, " "))
end, { nargs = "*" })

return M
