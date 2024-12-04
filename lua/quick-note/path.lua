local Path = require("plenary.path")
local config = require("quick-note.config")
local M = {}

local function hash(data)
	return vim.fn.sha256(data)
end

local function open()
	local path_name = M.get_path().filename
	local file_name = config.fetch("file_name")
	local file_type = config.fetch("file_type")
	local open_cmd = config.fetch("open_cmd")
	local cmd_string = open_cmd .. " " .. path_name .. "/" .. file_name .. file_type
	vim.cmd(cmd_string)
end

local root_path = vim.fs.dirname(vim.fs.find({ ".git", "Makefile", "package.json" }, { upward = true })[1])
local path_hash = hash(root_path)
local data_path = string.format("%s/quick-note/", vim.fn.stdpath("data"))
local data_project_path = data_path .. path_hash

local function data_action(opts)
	local action = opts[1]
	-- TODO: actions will let you run commands within the data dir
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

function M.open()
	open()
end

function M.open_with_opts(opts)
	open_with_opts(opts)
end

function M.get_path()
	local path = Path.new(data_path)
	if not path:exists() then
		path:mkdir()
	end

	path = Path.new(data_project_path)
	if not path:exists() then
		path:mkdir()
	end

	return path
end

return M
