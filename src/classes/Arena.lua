local matrix = require("modules.matrix")
local draw = require("modules.draw")
require("const.cellsize")

Arena = {
	pos = {
		x = 0,
		y = 0,
	},
	matrix = {},
	size = {
		x = 0,
		y = 0,
	},
}

function Arena.__index(_, key)
	return Arena[key]
end

function Arena.getSize(mat)
	return { x = #mat, y = #mat[1] }
end

function Arena.new(x, y, width, height)
	local self = setmetatable({}, Arena)

	self.pos = { x = x, y = y }
	self.matrix = matrix.newM(width, height)
	self.size = Arena.getSize(self.matrix)

	return self
end

function Arena:draw()
	draw.matrixD(self.matrix, self.pos.x, self.pos.y)
end
