vim.api.nvim_get_buffer_lines()
local matrix = require("modules.matrix")
require("classes.Arena")

local function moveDown(mat, finish)
	for i = finish - 1, 1, -1 do
		local tmp = mat[i]
		mat[i] = mat[i + 1]
		mat[i + 1] = tmp
	end
	mat[1] = { 0, 0, 0 }
end

local function main()
	local mat = { { 1, 1, 0 }, { 2, 2, 0 }, { 3, 3, 3 } }
	local arena = Arena(0, 0, 0, 0, mat)
	matrix.print(arena.matrix)
	arena:clearLine()
	matrix.print(arena.matrix)
end

main()
