local matrix = require("modules.matrix")

local function main()
	local my_matrix = matrix.newM(3, 3, { 1, 0, 3 })
	matrix.printM(my_matrix)
	matrix.transposeM(my_matrix)
	matrix.printM(my_matrix)
end

main()
