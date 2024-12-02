local matrix = require("modules.matrix")

local function getArgs()
	local arguments = {}
	for a = 1, #arg do
		if string.find(arg[a], "-", 1, 2) ~= nil then
			table.insert(arguments, arg[a])
		end
	end
end

local function main()
	local my_matrix = matrix.newM(10, 20)
	print(#my_matrix)
	print(#my_matrix[1])
end

main()
