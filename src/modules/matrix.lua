local tables = require("modules.tables")
require("constants.directions")

---@module "Matrix"

---@alias matrix table[integer[]]

local M = {}

---Creates a matrix.
---@param width integer
---@param height integer
---@return matrix
function M.new(width, height)
	local matrix = {}
	assert(width >= 1)
	assert(height >= 1)
	for i = 1, height do
		matrix[i] = {}
		for j = 1, width do
			matrix[i][j] = 0
		end
	end
	return matrix
end

---Print the content of a matrix.
---@param matrix matrix
---@param sep string? (default is " ")
function M.print(matrix, sep)
	sep = sep or " "
	for i = 1, #matrix do
		for j = 1, #matrix[1] do
			io.write(matrix[i][j] .. sep)
		end
		print()
	end
	print()
end

---Transpose a matrix.
---@param matrix matrix
function M.transpose(matrix)
	local tmp
	for i = 1, #matrix do
		for j = 1 + i, #matrix[i] do
			tmp = matrix[i][j]
			matrix[i][j] = matrix[j][i]
			matrix[j][i] = tmp
		end
	end
end

---Reverse the order of each line in a matrix.
---@param matrix matrix
function M.reverseLine(matrix)
	for i, _ in pairs(matrix) do
		tables.reverseT(matrix[i])
	end
end

---Set all elements in a matrix to a value.
---@param matrix matrix
---@param value integer
function M.set(matrix, value)
	for i = 1, #matrix do
		for j = 1, #matrix[i] do
			matrix[i][j] = value
		end
	end
end

---Check if matrix 1 is overlapping with matrix 2.
---@param matrix1 matrix
---@param matrix2 matrix
---@param x1 integer
---@param y1 integer
---@param value integer? value to detect overlap (default is 0)
---@return boolean if matrix 1 in in matrix 2
function M.isOverlapping(matrix1, matrix2, x1, y1, value)
	value = value or 0
	for i = 1, #matrix1 do
		for j = 1, #matrix1[i] do
			if matrix1[i][j] ~= value and (matrix2[i + y1] and matrix2[i + y1][j + x1]) ~= value then
				return true
			end
		end
	end
	return false
end

---Rotate matrix 90º or -90º.
---@param direction integer
---@param matrix matrix
function M.rotate(direction, matrix)
	if direction == CLOCKWISE then
		M.transpose(matrix)
		M.reverseLine(matrix)
	elseif direction == COUNTERCLOCKWISE then
		M.reverseLine(matrix)
		M.transpose(matrix)
	end
end

---Merge matrix 2 into matrix 1.
---@param matrix1 matrix will be merged
---@param matrix2 matrix to be merge
---@param x2 integer? x to merge in matrix 1 (default is 0)
---@param y2 integer? y to merge in matrix 1 (default is 0)
function M.merge(matrix1, matrix2, x2, y2)
	x2 = x2 or 0
	y2 = y2 or 0
	for i, line in ipairs(matrix2) do
		for j, element2 in ipairs(line) do
			if element2 ~= 0 and (i + y2 <= #matrix1 and j + x2 <= #matrix1[1]) then
				matrix1[i + y2][j + x2] = element2
			end
		end
	end
end

return M
