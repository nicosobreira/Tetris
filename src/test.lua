local matrix = require("modules.matrix")

local function main()
	local mat = matrix.new(10, 20)
	matrix.print(mat)
	matrix.setColumn(mat, 1, 4)
	matrix.print(mat)
end

main()
