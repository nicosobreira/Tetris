local tables = require("modules.tables")
require("const.cellsize")

local M = {}

---@param width number
---@param height number
function M.newM(width, height)
	local matrix = {}

	for i = 1, height do
		matrix[i] = {}
		for j = 1, width do
			matrix[i][j] = 0
		end
	end

	return matrix
end

function M.printM(matrix, sep)
	sep = sep or " "
	for _, line in ipairs(matrix) do
		for _, element in ipairs(line) do
			io.write(element .. sep)
		end
		print()
	end
	print()
end

function M.mergeM(matrix1, matrix2, x, y)
	x = x or 0
	y = y or 0
	for i, line in ipairs(matrix2) do
		for j, element2 in ipairs(line) do
			matrix1[i + y][j + x] = element2
		end
	end
end

function M.transposeM(matrix)
	local tmp
	for i = 1, #matrix do
		for j = 1 + i, #matrix[i] do
			tmp = matrix[i][j]
			matrix[i][j] = matrix[j][i]
			matrix[j][i] = tmp
		end
	end
end

function M.reverseLineM(matrix)
	for i, _ in pairs(matrix) do
		tables.printT(matrix[i])
		tables.reverseT(matrix[i])
	end
end

return M
