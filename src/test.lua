local matrix = require("modules.matrix")

local function main()
	local my_matrix = { { 1, 2 }, { 0, 0 } }
	matrix.printM(my_matrix)
	print(my_matrix[1][2])
	matrix.transposeM(my_matrix)
	matrix.printM(my_matrix)
end

main()
