local love = require("love")
local sprites = require("modules.sprites")

local function reverseT(tbl)
	if tbl and #tbl > 1 then
		local temp = nil
		for n = 1, math.floor(#tbl / 2) do
			temp = tbl[n]
			tbl[n] = tbl[#tbl - (n - 1)]
			tbl[#tbl - (n - 1)] = temp
		end
	end
end

local M = {}

function M.printM(matrix)
	for _, column in ipairs(matrix) do
		for _, element in ipairs(column) do
			io.write(element)
			io.write(" ")
		end
		print()
	end
	print()
end

function M.newM(width, height)
	width = width or 1
	height = height or 1
	local matrix = {}
	for j = 1, height do
		table.insert(matrix, {})
		for _ = 1, width do
			table.insert(matrix[j], 0)
		end
	end

	return matrix
end

function M.drawM(matrix, x, y, cellsize)
	for j, column in ipairs(matrix) do
		for i, element in ipairs(column) do
			if element ~= 0 and element <= #sprites then
				love.graphics.draw(sprites[element], x + (cellsize * i), y + (cellsize * j))
			end
		end
	end
end

function M.mergeM(matrix1, matrix2, x, y)
	x = x or 0
	y = y or 0
	for j, column in ipairs(matrix2) do
		for i, _ in ipairs(column) do
			matrix1[j + x][i + y] = matrix2[j][i]
		end
	end
end

function M.transposeM(matrix)
	local height = #matrix
	local width = #matrix[1]
	local tmp1, tmp2
	for i = 1, height do
		for j = i + 1, width do
			tmp1 = matrix[i][j]
			tmp2 = matrix[j][i]
			matrix[i][j] = tmp2
			matrix[j][i] = tmp1
		end
	end
end

function M.reverseM(matrix)
	for j, _ in ipairs(matrix) do
		reverseT(matrix[j])
	end
end

return M
