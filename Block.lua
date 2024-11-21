require("Vector")
local color = require("color")
local love = require("love")

Block = {
	size = 0,
	pos = Vector.new(0, 0),
	shape = {},
}

function Block.__index(_, key)
	return Block[key]
end

function Block.new(x, y, size, shape)
	local self = setmetatable({}, Block)

	self.pos = Vector.new(x, y)
	self.size = size
	self.shape = shape

	return self
end

function Block:rotate()
	local len = #self.shape
	for i = 1, len do
		for j = i + 1, len do
			self.shape[i][j] = self.shape[j][i]
			self.shape[j][i] = self.shape[i][j]
		end
	end
end

function Block:draw()
	love.graphics.setColor(color.BLUE)
	for j, column in ipairs(self.shape) do
		for i, line in ipairs(column) do
			if line ~= 0 then
				love.graphics.rectangle(
					"fill",
					self.pos.x + (i * self.pos.x),
					self.pos.y + (j * self.pos.y),
					self.size,
					self.size
				)
			end
		end
	end
	love.graphics.setColor(color.WHITE)
end
