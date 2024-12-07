local love = require("love")
local matrix = require("modules.matrix")
local draw = require("modules.draw")
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

function Arena.newMatrix(width, height)
	width = width + 2
	height = height + 1
	local value = #SPRITES + 1
	local mat = matrix.new(width, height)
	matrix.setLine(mat, #mat, value)
	matrix.setColumn(mat, 1, value)
	matrix.setColumn(mat, #mat[1], value)
	return mat
end

function Arena.new(x, y, width, height)
	local self = setmetatable({}, Arena)

	self.pos = { x = x, y = y }
	self.matrix = Arena.newMatrix(width, height)

	return self
end

function Arena:draw()
	local color
	matrix.print(self.matrix)
	for i = 1, #self.matrix do
		for j = 1, #self.matrix[i] do
			color = self.matrix[i][j] + 1
			if color <= #SPRITES then
				love.graphics.draw(SPRITES[color], self.pos.x + (CELLSIZE * j), self.pos.y + (CELLSIZE * i))
			end
		end
	end
end

function Arena:merge(block)
	matrix.merge(self.matrix, block.matrix, block.pos.x, block.pos.y - 1, _)
end

function Arena:reset()
	matrix.set(self.matrix, 0)
end
