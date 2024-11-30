local love = require("love")
local color = require("modules.color")
local matrix = require("modules.matrix")
local shapes = require("modules.shapes")
require("cellsize")

Block = {
	size = 0,
	pos = {
		x = 0,
		y = 0,
	},
	shape = {},
	time_last_fall = 0,
}

function Block.__index(_, key)
	return Block[key]
end

function Block.new(x, y, shape, size)
	local self = setmetatable({}, Block)

	self.pos = { x = x * CELLSIZE, y = y * CELLSIZE }
	self.size = size
	self.shape = shape
	self.time_last_fall = 0

	return self
end

function Block:merge(arena)
	matrix.mergeM(arena, self.shape, self.pos.x, self.pos.y - CELLSIZE)
end

function Block:draw()
	matrix.drawM(self.shape, self.pos.x, self.pos.y)
end

function Block:rotate(direction)
	if direction == 1 then
		-- Rotate clockwise
		matrix.transposeM(self.shape)
		matrix.reverseLineM(self.shape)
	else
		-- Rotate counterclockwise
		matrix.reverseLineM(self.shape)
		matrix.transposeM(self.shape)
	end
end

function Block:fall()
	self.pos.y = self.pos.y + CELLSIZE
end
