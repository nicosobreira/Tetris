local love = require("love")
local matrix = require("modules.matrix")
local draw = require("modules.draw")
require("const.shapes")
require("const.cellsize")
require("const.directions")

Block = {
	pos = {
		x = 0,
		y = 0,
	},
	matrix = {},
	size = {
		x = 0,
		y = 0,
	},
	time_last_fall = 0,
	fall_speed = 0,
}

function Block.__index(_, key)
	return Block[key]
end

function Block.randomShape()
	return SHAPES[math.random(#SHAPES_KEYS)]
end

function Block.getSize(matrix)
	return { x = #matrix[1], y = #matrix }
end

function Block.new(x, y, matrix)
	local self = setmetatable({}, Block)

	self.pos = { x = x, y = y }
	self.matrix = matrix
	self.size = Block.getSize(self.matrix)
	self.time_last_fall = 0

	return self
end

function Block:onCollision(arena_matrix)
	self.matrix = Block.randomShape()
	Block.getSize(self.matrix)
end

function Block:rotate(direction)
	if direction == CLOCKWISE then
		-- Rotate clockwise
		matrix.transposeM(self.matrix)
		matrix.reverseLineM(self.matrix)
	elseif direction == COUNTERCLOCKWISE then
		-- Rotate counterclockwise
		matrix.reverseLineM(self.matrix)
		matrix.transposeM(self.matrix)
	end
end

function Block:fall(fall_speed)
	local time_current = love.timer.getTime() - self.time_last_fall
	if time_current >= fall_speed then
		self.time_last_fall = love.timer.getTime()
		self.pos.y = self.pos.y + DOWN
	end
end

function Block:draw()
	draw.matrixD(self.matrix, self.pos.x, self.pos.y)
end

function Block:keypress() end
