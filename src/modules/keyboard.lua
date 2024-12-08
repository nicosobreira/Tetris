require("classes.Block")
require("const.directions")

local K = {}

local BLOCK = {
	a = function(block, arena)
		block:goHorizontal(LEFT, arena)
	end,
	d = function(block, arena)
		block:goHorizontal(RIGHT, arena)
	end,
	s = function(block)
		block:goVertical(DOWN)
	end,
	k = function(block)
		block:goVertical(UP)
	end,
	e = function(block)
		block:rotate(CLOCKWISE)
	end,
	q = function(block)
		block:rotate(COUNTERCLOCKWISE)
	end,
}

function K.onBlockKeypress(input, block, arena)
	if BLOCK[input] ~= nil then
		if input == "d" or input == "a" then
			BLOCK[input](block, arena)
		else
			BLOCK[input](block)
		end
	end
end

return K
