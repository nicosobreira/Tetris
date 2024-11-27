local love = require("love")
local matrix = require("modules.matrix")
local sprites = require("modules.sprites")

Arena = {
	pos = {
		x = 0,
		y = 0,
	},
	cellsize = 0,
	matrix = {},
}

function Arena.__index(_, key)
	return Arena[key]
end

function Arena.new(x, y, sx, sy, cellsize)
	local self = setmetatable({}, Arena)

	self.cellsize = cellsize
	self.pos = { x = x, y = y }
	self.matrix = matrix.newM(sx, sy)

	return self
end

function Arena:merge(shape)
	matrix.mergeM(self.matrix, shape, self.x, self.y)
end

function Arena:draw()
	for j, column in ipairs(self.matrix) do
		for i, element in ipairs(column) do
			if element ~= 0 and element <= #sprites then
				love.graphics.draw(sprites[element], self.pos.x + (self.cellsize * i), self.pos.y + (self.cellsize * j))
			end
		end
	end
end
