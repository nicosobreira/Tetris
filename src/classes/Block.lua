local love = require("love")
local color = require("modules.color")
local matrix = require("modules.matrix")
local shapes = require("modules.shapes")

local function randomKey(tbl)
	-- Get all the keys
	local keys = {}
	for k, _ in pairs(tbl) do
		table.insert(keys, k)
	end
	local key = keys[math.random(#keys)]
	return key
end

-- local function reverseT(tbl)
-- 	local reversedTable = {}
-- 	local len = #tbl
-- 	for index, value in ipairs(tbl) do
-- 		reversedTable[len + 1 - index] = value
-- 	end
-- 	return reversedTable
-- end

Block = {
	size = 0,
	pos = {
		x = 0,
		y = 0,
	},
	shape = {},
}

function Block.__index(_, key)
	return Block[key]
end

function Block.new(x, y, shape, size)
	local self = setmetatable({}, Block)

	self.pos = { x = x, y = y }
	self.size = size
	self.shape = shape

	return self
end

function Block.newRandom(x, y, size)
	local random_key = randomKey(shapes)
	local self = setmetatable({}, Block)

	self.pos = { x = x, y = y }
	self.size = size
	self.shape = shapes[random_key]

	return self
end

function Block:rotate(direction)
	if direction == 1 then
		-- Rotate clockwise
		matrix.transposeM(self.shape)
		matrix.reverseM(self.shape)
	else
		-- Rotate counterclockwise
		matrix.reverseM(self.shape)
		matrix.transposeM(self.shape)
	end
end

function Block:merge(matrix_to_merge)
	matrix.mergeM(matrix_to_merge, self.shape, self.pos.x, self.pos.y)
end

-- function Block:draw()
-- 	love.graphics.setColor(color.BLUE)
-- 	for j, column in ipairs(self.shape) do
-- 		for i, line in ipairs(column) do
-- 			if line ~= 0 then
-- 				love.graphics.rectangle(
-- 					"fill",
-- 					self.pos.x + (i * self.pos.x),
-- 					self.pos.y + (j * self.pos.y),
-- 					self.size,
-- 					self.size
-- 				)
-- 			end
-- 		end
-- 	end
-- 	love.graphics.setColor(color.WHITE)
-- end
