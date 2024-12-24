local matrix = require("modules.matrix")
local draw = require("modules.draw")
require("constants.shapes")
require("constants.colors")

---Block.
---@class Block
---@field pos vector
---@field matrix matrix
Block = {}

function Block.__index(_, key)
	return Block[key]
end

---Create a new Block.
---@param x number
---@param y number
---@param mat matrix?
function Block.new(x, y, mat)
	local self = setmetatable({}, Block)

	self.pos = { x = x, y = y }
	self.matrix = mat or Block.randomShape()

	return self
end

function Block.randomShape()
	local key = SHAPES_KEYS[math.random(1, #SHAPES_KEYS)]
	return SHAPES[key]
end

function Block:isOverlapping(arena_matrix)
	return matrix.isOverlapping(self.matrix, arena_matrix, self.pos.x, self.pos.y)
end

function Block:drop()
	self.pos.y = self.pos.y + DOWN
end

---Move the piece by one cell to the right
---@param max_pos number the maximum value
function Block:moveRight(max_pos)
	self.pos.x = math.max(self.pos.x + RIGHT, max_pos)
end

function Block:moveHorizontal(direction, mat)
	self.pos.x = self.pos.x + direction
	if self:isOverlapping(mat) then
		self.pos.x = self.pos.x - direction
	end
end

---@param direction number
---@param arena_matrix matrix
function Block:rotate(direction, arena_matrix)
	matrix.rotate(direction, self.matrix)
	if self:isOverlapping(arena_matrix) then
		matrix.rotate(-direction, self.matrix)
	end
end

---@param cellsize number the size per cell
---@param tx? integer set x left corner to draw
---@param ty? integer set y up corner to draw
function Block:draw(cellsize, tx, ty)
	tx = tx or 0
	ty = ty or 0
	for i = 1, #self.matrix do
		for j = 1, #self.matrix[i] do
			local color = self.matrix[i][j] + 1
			if color ~= 1 then
				draw.cell(
					"fill",
					COLORS[color],
					tx + (self.pos.x + (j - 1)) * cellsize,
					ty + (self.pos.y + (i - 1)) * cellsize,
					cellsize
				)
			end
		end
	end
end

---Set matrix to a random number and pos to the middle.
function Block:reset()
	self.matrix = Block.randomShape()
	self.pos = { x = 5, y = 1 }
end
