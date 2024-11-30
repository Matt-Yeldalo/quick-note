local M = {}
local Path = require("plenary.path")
local config = require("quick-note.config")

--- Form a reverse string until it matches a char
--- @param match string
--- @param path_str string
--- @param result_str string
local function form_rev_str_until(match, path_str, result_str)
	local len = string.len(path_str)
	if len < 1 then
		return result_str
	end

	local last_char = path_str:sub(len, len)
	if last_char == match then
		return result_str
	end

	return form_rev_str_until(match, path_str:sub(1, -2), last_char .. result_str)
end
--- Get the end of the path, chomp by '/'
--- @param path string
local function end_path(path)
	return form_rev_str_until("/", path, "")
end

local function fetch_opts(key)
	if config["opts"] ~= nil then
		return config["opts"][key]
	end

	return config["defaults"][key]
end

local root_path = vim.fs.dirname(vim.fs.find({ ".git", "Makefile", "package.json" }, { upward = true })[1])
local root_dir_name = end_path(root_path)
local data_path = string.format("%s/quicknote/", vim.fn.stdpath("data"))
local data_project_path = data_path .. root_dir_name

local function get_path()
	local path = Path.new(data_path)
	if not path:exists() then
		path = path:mkdir()
	end

	path = Path.new(data_project_path)
	if not path:exists() then
		path = path:mkdir()
	end

	return path
end

local function data_action(opts)
	local action = opts[1]
	-- TODO: actions will let you run commands within the data dir
end

-- local function write_path(data)
-- 	get_path():write(vim.json.decode(data), "w")
-- end

local function open()
	local path = get_path()
	local file_name = fetch_opts("file_name")
	local file_type = fetch_opts("file_type")
	local open_cmd = fetch_opts("open_cmd")
	local cmd_string = open_cmd .. " " .. path.filename .. "/" .. file_name .. file_type
	vim.cmd(cmd_string)
end

local function open_with_opts(opts)
	open()
	-- WIP
	-- local first_arg = opts[1]
	-- if first_arg == 'data' then
	-- 	table.remove(opts, 1)
	-- 	return data_action(opts)
	-- end
end

M.quickNote = function(opts)
	local len = #opts

	if opts == nil or opts[0] == nil or len < 1 then
		open()
	end

	if len < 2 then
		fetch_opts(opts)
	end
end

function M.setup(opts)
	config.setup(opts)

	vim.api.nvim_create_user_command("QuickNote", function(opts)
		M.quickNote(vim.split(opts.args, " "))
	end, { nargs = "*" })
end

return M
