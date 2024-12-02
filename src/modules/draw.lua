local love = require("love")
local matrix = require("modules.matrix")
require("const.sprites")

local D = {}

function D.matrixD(mat, x, y)
	matrix.printM(mat)
	for i, line in ipairs(mat) do
		for j, color in ipairs(line) do
			color = color + 1
			if color <= #SPRITES then
				love.graphics.draw(SPRITES[color], x + (CELLSIZE * i), y + (CELLSIZE * j))
			end
		end
	end
end

return D
