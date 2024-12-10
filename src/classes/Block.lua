local love = require("love")
local matrix = require("modules.matrix")
local draw = require("modules.draw")
require("const.shapes")
require("const.cellsize")
require("const.directions")

Block = {}

setmetatable(Block, {
	__call = function(cls, ox, oy, x, y, shape)
		return cls.new(ox, oy, x, y, shape)
	end,
})

function Block.__index(_, key)
	return Block[key]
end

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

function Block:goVertical(direction)
	self.pos.y = self.pos.y + direction
end

function Block:goHorizontal(direction, arena)
	self.pos.x = self.pos.x + direction
	if self:isOverlaping(arena.matrix) then
		self.pos.x = self.pos.x - direction
	end
end

-- FIX need to check if will collide before action
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

function Block:isOverlaping(mat)
	return matrix.isOverlaping(self.matrix, mat, self.pos.x, self.pos.y)
end

function Block:reset(arena_matrix)
	local tmp_matrix = Block.randomShape()
	local tmp_pos = { x = self.origin.x + 5, y = self.origin.y + 1 }
	if matrix.isOverlaping(tmp_matrix, arena_matrix, tmp_pos.x, tmp_pos.y) then
		os.execute("clear")
		print("You lost")
		os.exit()
	end
	self.matrix = tmp_matrix
	self.pos = tmp_pos
end
