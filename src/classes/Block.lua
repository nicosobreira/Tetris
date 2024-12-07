local love = require("love")
local matrix = require("modules.matrix")
local draw = require("modules.draw")
require("const.shapes")
require("const.cellsize")
require("const.directions")

Block = {}

function Block.__index(_, key)
	return Block[key]
end

setmetatable(Block, {
	__call = function(cls, ox, oy, x, y, shape)
		return cls.new(ox, oy, x, y, shape)
	end,
})

function Block.randomShape()
	local key = SHAPES_KEYS[math.random(1, #SHAPES_KEYS)]
	return SHAPES[key]
end

function Block.new(ox, oy, x, y, shape)
	local self = setmetatable({}, Block)

	self.origin = { x = ox, y = oy }
	self.pos = { x = x, y = y }
	self.matrix = shape or Block.randomShape()
	self.time_last_fall = 0

	return self
end

function Block:goDown()
	self.pos.y = self.pos.y + DOWN
end

function Block:goUp()
	self.pos.y = self.pos.y + UP
end

function Block:goLeft()
	self.pos.x = self.pos.x + LEFT
end

function Block:goRight()
	self.pos.x = self.pos.x + RIGHT
end

function Block:rotate(direction)
	if direction == CLOCKWISE then
		-- Rotate clockwise
		matrix.transpose(self.matrix)
		matrix.reverseLine(self.matrix)
	elseif direction == COUNTERCLOCKWISE then
		-- Rotate counterclockwise
		matrix.reverseLine(self.matrix)
		matrix.transpose(self.matrix)
	end
end

function Block:fall(fall_speed)
	local time_current = love.timer.getTime() - self.time_last_fall
	if time_current >= fall_speed then
		self.time_last_fall = love.timer.getTime()
		self:goDown()
	end
end

function Block:draw()
	local color
	matrix.print(self.matrix)
	for i = 1, #self.matrix do
		for j = 1, #self.matrix[i] do
			color = self.matrix[i][j] + 1
			if color ~= 1 then
				love.graphics.draw(
					SPRITES[color],
					self.origin.x + (self.pos.x * CELLSIZE) + (CELLSIZE * j),
					self.origin.y + (self.pos.y * CELLSIZE) + (CELLSIZE * i)
				)
			end
		end
	end
end

function Block:isColliding(arena_matrix)
	for i = 1, #self.matrix do
		for j = 1, #self.matrix[i] do
			if self.matrix[i][j] ~= 0 and arena_matrix[i + self.pos.y][j + self.pos.x] ~= 0 then
				return true
			end
		end
	end
	return false
end

function Block:reset()
	self.matrix = Block.randomShape()
	self.pos = { x = self.origin.x + 5, y = self.origin.y + 5 }
end
