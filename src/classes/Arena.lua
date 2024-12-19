local matrix = require("modules.matrix")
local tables = require("modules.tables")
require("constants.cellsize")

Arena = {}

function Arena.__index(_, key)
	return Arena[key]
end

setmetatable(Arena, {
	__call = function(cls, width, height, multiply, fall_speed, score_for_fall)
		return cls.new(width, height, multiply, fall_speed, score_for_fall)
	end,
})

function Arena.new(width, height, multiply, fall_speed, score_for_fall)
	local self = setmetatable({}, Arena)

	self.matrix = matrix.new(width, height)
	self.multiply = multiply
	self.fall_speed = fall_speed
	self.score_for_fall = score_for_fall
	self.score = 0
	self.score_update = 0

	return self
end

function Arena.moveDown(mat, finish)
	for i = finish - 1, 1, -1 do
		local tmp = mat[i]
		mat[i] = mat[i + 1]
		mat[i + 1] = tmp
	end
	tables.set(mat[1], 0)
end

function Arena:merge(block)
	matrix.merge(self.matrix, block.matrix, block.pos.x, block.pos.y + UP)
end

function Arena:clearLines()
	for i = 1, #self.matrix do
		if not tables.include(self.matrix[i], 0) then
			tables.set(self.matrix[i], 0)
			Arena.moveDown(self.matrix, i)
			self.score = self.score + self.multiply
		end
	end
end

function Arena:decreaseVelocity()
	if self.fall_speed > 0.2 then
		self.fall_speed = self.fall_speed - 0.2
	end
	self.score_for_fall = math.floor(self.score_for_fall * (1.5 + self.score_update))
	self.score_update = self.score_update + 0.5
end

function Arena:draw(tx, ty)
	tx = tx or 0
	ty = ty or 0
	local to_draw_x = tx * CELLSIZE
	local to_draw_y = ty * CELLSIZE
	print(self.score)
	print(self.fall_speed)
	matrix.print(self.matrix)
	for i = 1, #self.matrix do
		for j = 1, #self.matrix[i] do
			local color = self.matrix[i][j] + 1
			love.graphics.draw(COLORS[color], to_draw_x + (CELLSIZE * j), to_draw_y + (CELLSIZE * i))
		end
	end
end

function Arena:reset()
	matrix.set(self.matrix, 0)
	self.score = 0
end
