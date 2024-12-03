local tables = require("modules.tables")
require("const.cellsize")

local M = {}

---@param width number
---@param height number
---@param elements table
---@param default number
function M.newM(width, height, elements, default)
	elements = elements or {}
	default = default or 0
	local matrix = {}
	local elem_index = 1

	for i = 1, height do
		matrix[i] = {}
		for j = 1, width do
			if elements[elem_index] == nil then
				matrix[i][j] = default
			else
				matrix[i][j] = elements[elem_index]
			end
			elem_index = elem_index + 1
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
			matrix1[j + x][i + y] = element2
		end
	end
end

function M.transposeM(matrix)
	for i, _ in ipairs(matrix) do
		for j, element in ipairs(matrix[i]) do
			matrix[i][j] = matrix[j][i]
			matrix[j][i] = element
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
