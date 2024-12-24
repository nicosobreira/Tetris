local matrix = require("modules.matrix")
local tables = require("modules.tables")
local draw = require("modules.draw")
require("constants.colors")

---@class Arena
---@field matrix matrix
Arena = {}

function Arena.__index(_, key)
	return Arena[key]
end

---Creates a new Arena.
---@param width integer
---@param height integer
function Arena.new(width, height)
	local self = setmetatable({}, Arena)

	self.matrix = matrix.new(width, height)

	return self
end

---Move each line down, starting in 1 and going to finish.
---@param finish integer from finish to top move down
function Arena:moveDown(finish)
	for i = finish - 1, 1, -1 do
		local tmp = self.matrix[i]
		self.matrix[i] = self.matrix[i + 1]
		self.matrix[i + 1] = tmp
	end
	tables.set(self.matrix[1], 0)
end

---Merge the block in the arena
---@param block Block
function Arena:merge(block)
	matrix.merge(self.matrix, block.matrix, block.pos.x, block.pos.y + UP)
end

---Draw the arena.
---@param cellsize number the size per cell
---@param tx? integer set x left corner to draw
---@param ty? integer set y up corner to draw
function Arena:draw(cellsize, tx, ty)
	tx = tx or 0
	ty = ty or 0
	for i = 1, #self.matrix do
		for j = 1, #self.matrix[i] do
			local color = self.matrix[i][j] + 1
			draw.cell("fill", COLORS[color], tx + (j - 1) * cellsize, ty + (i - 1) * cellsize, cellsize)
		end
	end
end

---Set the Arena.matrix values to 0.
function Arena:reset()
	matrix.set(self.matrix, 0)
end
