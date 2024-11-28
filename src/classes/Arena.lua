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

	self.pos = { x = (x - math.floor(width / 2)), y = (y + math.floor(height / 2)) }
	self.matrix = matrix.newM(width, height)

	return self
end

function Arena:draw()
	matrix.printM(self.matrix)
	for j, column in ipairs(self.matrix) do
		for i, color in ipairs(column) do
			if color ~= 0 and color <= #sprites then
				love.graphics.draw(sprites[color], self.pos.x + (CELLSIZE * i), self.pos.y + (CELLSIZE * j))
			end
		end
	end
end
