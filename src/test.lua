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
	local tmp
	for index = 1, len // 2 do
		tmp = tbl[index]
	end
	return reversedTable
end
local tbl = { "4", "10", "3" }
printT(tbl)
table.sort(tbl, function(a, b)
	return a > b
end)
-- local reversed = reverseTable(tbl)
printT(tbl)
