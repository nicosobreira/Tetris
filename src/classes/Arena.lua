local love = require("love")
local matrix = require("modules.matrix")
local tables = require("modules.tables")
require("constants.cellsize")

Arena = {}

function Arena.__index(_, key)
	return Arena[key]
end

setmetatable(Arena, {
	__call = function(cls, width, height, multiply, fall_speed)
		return cls.new(width, height, multiply, fall_speed)
	end,
})

function Arena.new(width, height, multiply, fall_speed)
	local self = setmetatable({}, Arena)

	self.matrix = matrix.new(width, height)
	self.multiply = multiply
	self.fall_speed = fall_speed
	self.score = 0

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
function Arena:reset()
	matrix.set(self.matrix, 0)
	self.score = 0
end

function Arena:draw(tx, ty)
	tx = tx or 0
	ty = ty or 0
	local to_draw_x = tx * CELLSIZE
	local to_draw_y = ty * CELLSIZE
	print(self.score)
	matrix.print(self.matrix)
	love.graphics.printf(tostring(self.score), to_draw_x, to_draw_y, #self.matrix[1] * CELLSIZE + to_draw_x, "center")
	for i = 1, #self.matrix do
		for j = 1, #self.matrix[i] do
			local color = self.matrix[i][j] + 1
			love.graphics.draw(COLORS[color], to_draw_x + (CELLSIZE * j), to_draw_y + (CELLSIZE * i))
		end
	end
end
