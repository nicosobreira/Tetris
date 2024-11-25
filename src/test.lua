local shapes = require("shapes")

local function printM(matrix)
	for _, column in ipairs(matrix) do
		for _, line in ipairs(column) do
			io.write(line)
			io.write(" ")
		end
		print()
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

math.randomseed(os.time())

local random_key = randomKey(shapes)
print("random_key = " .. random_key)
printM(shapes[random_key])
