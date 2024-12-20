local tables = require("modules.tables")
require("constants.cellsize")
require("constants.directions")

---@alias matrix table<number, table<number>>
local M = {}

---@param width number
---@param height number
---@return matrix
function M.new(width, height)
	local matrix = {}
	for i = 1, height do
		matrix[i] = {}
		for j = 1, width do
			matrix[i][j] = 0
		end
	end
	return matrix
end

---@param matrix matrix
---@param sep string
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

---@param matrix matrix
function M.reverseLine(matrix)
	for i, _ in pairs(matrix) do
		tables.reverseT(matrix[i])
	end
end

---@param matrix matrix
---@param value number
function M.set(matrix, value)
	for i = 1, #matrix do
		for j = 1, #matrix[i] do
			matrix[i][j] = value
		end
	end
end

---@param matrix1 matrix
---@param matrix2 matrix
---@param x2 number
---@param y2 number
---@param value number value to detect overlap (default is 0)
---@return boolean if matrix 1 in in matrix 2
function M.isOverlapping(matrix1, matrix2, x2, y2, value)
	value = value or 0
	for i = 1, #matrix1 do
		for j = 1, #matrix1[i] do
			if matrix1[i][j] ~= value and (matrix2[i + y2] and matrix2[i + y2][j + x2]) ~= value then
				return true
			end
		end
	end
	return false
end

---@param direction number
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

---@param matrix1 matrix to be merge
---@param matrix2 matrix will be merged
---@param x number x to merge in matrix 1
---@param y number y to merge in matrix 1
function M.merge(matrix1, matrix2, x, y)
	x = x or 0
	y = y or 0
	for i, line in ipairs(matrix2) do
		for j, element2 in ipairs(line) do
			if element2 ~= 0 and (i + y <= #matrix1 and j + x <= #matrix1[1]) then
				matrix1[i + y][j + x] = element2
			end
		end
	end
end

return M
