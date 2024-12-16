local love = require("love")
local matrix = require("modules.matrix")
local tables = require("modules.tables")
require("constants.cellsize")

Arena = {}

function Arena.__index(_, key)
	return Arena[key]
end

setmetatable(Arena, {
	__call = function(cls, x, y, width, height, mat)
		return cls.new(x, y, width, height, mat)
	end,
})

function Arena.new(x, y, width, height, mat)
	local self = setmetatable({}, Arena)

	self.pos = { x = x, y = y }
	self.matrix = mat or matrix.new(width, height)

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

function Arena:draw(tx, ty)
	tx = tx or 0
	ty = ty or 0
	local to_draw_pos_x = tx * CELLSIZE
	local to_draw_pos_y = ty * CELLSIZE
	matrix.print(self.matrix)
	for i = 1, #self.matrix do
		for j = 1, #self.matrix[i] do
			local color = self.matrix[i][j] + 1
			love.graphics.draw(COLORS[color], to_draw_pos_x + (CELLSIZE * j), to_draw_pos_y + (CELLSIZE * i))
		end
	end
end

function Arena:merge(block)
	matrix.merge(self.matrix, block.matrix, block.pos.x, block.pos.y + UP)
end

function Arena:clearLine()
	for i = 1, #self.matrix do
		if not tables.include(self.matrix[i], 0) then
			tables.set(self.matrix[i], 0)
			Arena.moveDown(self.matrix, i)
		end
	end
end

function Arena:reset()
	self.matrix = matrix.set(self.matrix, 0)
end
