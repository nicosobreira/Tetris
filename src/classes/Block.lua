local love = require("love")
local matrix = require("modules.matrix")
local draw = require("modules.draw")
require("const.shapes")
require("const.cellsize")

Block = {
	pos = {
		x = 0,
		y = 0,
	},
	shape = {},
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

function Block.getSize(shape)
	return { x = #shape, y = #shape[1] }
end

function Block.new(x, y, shape)
	local self = setmetatable({}, Block)

	self.pos = { x = x, y = y }
	self.shape = shape
	self.size = Block.getSize(self.shape)
	self.time_last_fall = 0

	return self
end

function Block:onCollision(arena_matrix)
	matrix.mergeM(arena_matrix, self.shape, self.pos.x, self.pos.y)
	self.shape = Block.randomShape()
	Block.getSize(self.shape)
end

function Block:rotate(direction)
	if direction == 1 then
		-- Rotate clockwise
		matrix.transposeM(self.shape)
		-- matrix.reverseLineM(self.shape)
	else
		-- Rotate counterclockwise
		matrix.reverseLineM(self.shape)
		matrix.transposeM(self.shape)
	end
end

function Block:checkFall(fall_speed)
	local time_current = love.timer.getTime() - self.time_last_fall
	if time_current >= fall_speed then
		self.time_last_fall = love.timer.getTime()
		self.pos.y = self.pos.y + CELLSIZE
	end
end

function Block:draw()
	draw.matrixD(self.shape, self.pos.x, self.pos.y)
end
