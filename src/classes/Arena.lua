local love = require("love")
local matrix = require("modules.matrix")
local tables = require("modules.tables")
require("const.cellsize")

Arena = {}

function Arena.__index(_, key)
	return Arena[key]
end

setmetatable(Arena, {
	__call = function(cls, x, y, width, height)
		return cls.new(x, y, width, height)
	end,
})

function Arena.new(x, y, width, height)
	local self = setmetatable({}, Arena)

	self.pos = { x = x, y = y }
	self.matrix = matrix.new(width, height)

	return self
end

function Arena.moveDown(mat, finish, start)
	local tmp_first_line = mat[1]
	for i = finish - 1, start, -1 do
		local tmp = mat[i]
		mat[i] = mat[i + 1]
		mat[i + 1] = tmp
	end
	mat[1] = tmp_first_line
end

function Arena:draw(tx, ty)
	tx = tx or 0
	ty = ty or 0
	local to_draw_pos_x = (tx + self.pos.x) * CELLSIZE
	local to_draw_pos_y = (ty + self.pos.y) * CELLSIZE
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

function Arena:hasCompleteLines()
	for i = 1, #self.matrix do
		if tables.dontContain(self.matrix[i], 0) then
			tables.set(self.matrix[i], 0)
			Arena.moveDown(self.matrix, i, 1)
		end
	end
end

function Arena:reset()
	self.matrix = matrix.new(#self.matrix, #self.matrix[1])
end
