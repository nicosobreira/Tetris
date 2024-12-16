local love = require("love")
local matrix = require("modules.matrix")
require("constants.shapes")
require("constants.cellsize")
require("constants.directions")
require("constants.sprites")

Block = {}

setmetatable(Block, {
	__call = function(cls, x, y, shape)
		return cls.new(x, y, shape)
	end,
})

function Block.__index(_, key)
	return Block[key]
end

function Block.new(x, y, shape)
	local self = setmetatable({}, Block)

	self.pos = { x = x, y = y }
	self.matrix = shape or Block.randomShape()
	self.time_last_fall = 0

	return self
end

function Block.randomShape()
	local key = SHAPES_KEYS[math.random(1, #SHAPES_KEYS)]
	return SHAPES[key]
end

function Block:goVertical(direction)
	self.pos.y = self.pos.y + direction
end

function Block:goForceVertical(direction, arena_matrix)
	for _ = self.pos.y, #arena_matrix, direction do
		self:goVertical(direction)
		if self:isOverlapping(arena_matrix) then
			self:goVertical(-direction)
			break
		end
	end
end

function Block:goHorizontal(direction, arena_matrix)
	self.pos.x = self.pos.x + direction
	if self:isOverlapping(arena_matrix) then
		self.pos.x = self.pos.x - direction
	end
end

function Block:rotate(direction, arena_matrix)
	matrix.rotate(direction, self.matrix)
	if self:isOverlapping(arena_matrix) then
		matrix.rotate(-direction, self.matrix)
	end
end

function Block:fall(fall_speed)
	local time_current = love.timer.getTime() - self.time_last_fall
	if time_current >= fall_speed then
		self.time_last_fall = love.timer.getTime()
		self:goVertical(DOWN)
	end
end

function Block:draw(tx, ty)
	tx = tx or 0
	ty = ty or 0
	local to_draw_pos_x = (tx + self.pos.x) * CELLSIZE
	local to_draw_pos_y = (ty + self.pos.y) * CELLSIZE
	matrix.print(self.matrix)
	for i = 1, #self.matrix do
		for j = 1, #self.matrix[i] do
			local color = self.matrix[i][j] + 1
			if color ~= 1 then
				love.graphics.draw(COLORS[color], to_draw_pos_x + (CELLSIZE * j), to_draw_pos_y + (CELLSIZE * i))
			end
		end
	end
end

function Block:isOverlapping(mat)
	return matrix.isOverlapping(self.matrix, mat, self.pos.x, self.pos.y)
end

function Block:isGameOver(arena_matrix)
	-- local tmp_matrix = Block.randomShape()
	self.matrix = SHAPES.i
	self.pos = { x = 5, y = 1 }
	if matrix.isOverlapping(self.matrix, arena_matrix, self.pos.x, self.pos.y) then
		return true
	end
	return false
end
