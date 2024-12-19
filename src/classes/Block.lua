local matrix = require("modules.matrix")
require("constants.shapes")
require("constants.cellsize")
require("constants.directions")
require("constants.sprites")

Block = {}

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

function Block:onOverlap(arena)
	arena:merge(self)
	arena:clearLines()
	if arena.score >= arena.score_for_fall then
		arena:decreaseVelocity()
	end
	if self:isGameOver(arena.matrix) then
		arena:reset()
		self:reset()
	end
end

function Block:isOverlapping(arena_matrix)
	return matrix.isOverlapping(self.matrix, arena_matrix, self.pos.x, self.pos.y)
end

function Block:goTo(axis, direction)
	if axis == "x" then
		self.pos.x = self.pos.x + direction
	elseif axis == "y" then
		self.pos.y = self.pos.y + direction
	end
end

function Block:move(axis, direction, arena_matrix)
	self:goTo(axis, direction)
	if self:isOverlapping(arena_matrix) then
		self:goTo(axis, -direction)
	end
end

function Block:goForceVertical(direction, arena)
	for _ = self.pos.y, #arena.matrix, direction do
		self:goTo("y", direction)
		if self:isOverlapping(arena.matrix) then
			self:onOverlap(arena)
			break
		end
	end
end

function Block:rotate(direction, arena_matrix)
	matrix.rotate(direction, self.matrix)
	if self:isOverlapping(arena_matrix) then
		matrix.rotate(-direction, self.matrix)
	end
end

function Block:fall(arena)
	local time_current = love.timer.getTime() - self.time_last_fall
	if time_current >= arena.fall_speed then
		self.time_last_fall = love.timer.getTime()
		self:goTo("y", DOWN)
		if self:isOverlapping(arena.matrix) then
			self:onOverlap(arena)
		end
	end
end

function Block:reset()
	self.matrix = Block.randomShape()
	-- self.matrix = SHAPES.i
	self.pos = { x = 5, y = 1 }
end

function Block:isGameOver(arena_matrix)
	self:reset()
	if matrix.isOverlapping(self.matrix, arena_matrix, self.pos.x, self.pos.y) then
		return true
	end
	return false
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
