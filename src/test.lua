local matrix = require("modules.matrix")

local function moveDown(mat, finish, start)
	for i = finish - 1, start, -1 do
		local tmp = mat[i]
		mat[i] = mat[i + 1]
		mat[i + 1] = tmp
	end
	mat[1] = { 0, 0, 0 }
end

local function main()
	local mat = { { 1, 1, 1 }, { 2, 2, 2 }, { 3, 3, 3 } }
	matrix.print(mat)
	moveDown(mat, 3, 1)
	matrix.print(mat)
end

main()
