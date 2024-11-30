local love = require("love")
local matrix = require("modules.matrix")
local sprites = require("modules.sprites")
require("cellsize")

Arena = {
	pos = {
		x = 0,
		y = 0,
	},
	matrix = {},
}

function Arena.__index(_, key)
	return Arena[key]
end

function Arena.new(x, y, width, height)
	local self = setmetatable({}, Arena)

	self.pos = { x = x * CELLSIZE, y = y * CELLSIZE }
	self.matrix = matrix.newM(width, height)

	return self
end

function Arena:draw()
	matrix.drawM(self.matrix, self.pos.x, self.pos.y)
end
