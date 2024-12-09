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

function Arena.newMatrix(width, height)
	width = width + 2
	height = height + 1
	local value = #COLORS + 1
	local mat = matrix.new(width, height)
	matrix.setLine(mat, #mat, value)
	matrix.setColumn(mat, 1, value)
	matrix.setColumn(mat, #mat[1], value)
	return mat
end

function Arena.new(x, y, width, height)
	local self = setmetatable({}, Arena)

	self.pos = { x = x, y = y }
	self.matrix = matrix.new(width, height)

	return self
end

function Arena:draw()
	local color
	matrix.print(self.matrix)
	for i = 1, #self.matrix do
		for j = 1, #self.matrix[i] do
			color = self.matrix[i][j] + 1
			if color <= #COLORS then
				love.graphics.draw(COLORS[color], self.pos.x + (CELLSIZE * j), self.pos.y + (CELLSIZE * i))
			end
		end
	end
end

function Arena:merge(block)
	matrix.merge(self.matrix, block.matrix, block.pos.x, block.pos.y + UP, nil)
end

function Arena:hasCompleteLines()
	for i = 1, #self.matrix do
		if not tables.contains(self.matrix[i], 0) then
			tables.set(self.matrix[i], 0)
		end
	end
end

function Arena:reset()
	self.matrix = Arena.newMatrix(#self.matrix, #self.matrix[1])
end
