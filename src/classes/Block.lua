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

function Block:merge(arena)
	matrix.mergeM(arena, self.shape, self.pos.x, self.pos.y)
end

function Block:rotate(direction)
	if direction == 1 then
		-- Rotate clockwise
		matrix.transposeM(self.shape)
		matrix.reverseLineM(self.shape)
	else
		-- Rotate counterclockwise
		matrix.reverseLineM(self.shape)
		matrix.transposeM(self.shape)
	end
end
