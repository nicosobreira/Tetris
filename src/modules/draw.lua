local love = require("love")
local matrix = require("modules.matrix")
require("const.sprites")

local D = {}

function D.matrixD(mat, x, y)
	matrix.printM(mat)
	for j, line in ipairs(mat) do
		for i, color in ipairs(line) do
			color = color + 1
			if color >= #SPRITES then
				error("Color value can't be grater than " .. #SPRITES, 10)
			end
			love.graphics.draw(SPRITES[color], x + (CELLSIZE * i), y + (CELLSIZE * j))
		end
	end
end

return D
