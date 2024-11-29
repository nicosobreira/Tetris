local tables = require("modules.tables")

local M = {}

---@param width integer
---@param height integer
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

function M.printM(matrix)
	for _, line in ipairs(matrix) do
		for _, element in ipairs(line) do
			io.write(element .. " ")
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
			matrix1[i + x][j + y] = element2
		end
	end
end

function M.transposeM(matrix)
	for i, line in ipairs(matrix) do
		for j, element in ipairs(line) do
			matrix[i][j] = matrix[j][i]
			matrix[j][i] = element
		end
	end
end

function M.reverseLineM(matrix)
	for j, _ in ipairs(matrix) do
		tables.reverseT(matrix[j])
	end
end

return M
