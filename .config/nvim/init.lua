require("config.options")
require("config.lazy")

local projectfile = vim.fn.getcwd() .. '/project.godot'
if projectfile then
	vim.fn.serverstart './godothost'
end
