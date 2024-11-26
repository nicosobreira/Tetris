local shapes = require("modules.shapes")
-- local matrix = require("modules.matrix")

local function printT(tbl)
	for _, element in ipairs(tbl) do
		io.write(element .. " ")
	end
	print()
end

local function randomKey(tbl)
	-- Get all the keys
	local keys = {}
	for k, _ in pairs(tbl) do
		table.insert(keys, k)
	end
	local key = keys[math.random(#keys)]
	return key
end

local function reverseTable(tbl)
	local reversedTable = {}
	local len = #tbl
	for index, value in ipairs(tbl) do
		reversedTable[len + 1 - index] = value
	end
	return reversedTable
end

local tbl = { "a", "b", "c" }
printT(tbl)
local reversed = reverseTable(tbl)
printT(reversed)
