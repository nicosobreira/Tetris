local vector = require("Vector")

local function main()
	local a = vector.new(5, 6)
	local b = vector.new(1, 3)

	print(a.x, a.y)
	print(b.x, b.y)
end

main()
