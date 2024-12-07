require("classes.Block")
require("const.directions")

local K = {}

local BLOCK = {
	a = function(block)
		block:goLeft()
	end,
	d = function(block)
		block:goRight()
	end,
	s = function(block)
		block:goDown()
	end,
	k = function(block)
		block:goUp()
	end,
	e = function(block)
		block:rotate(CLOCKWISE)
	end,
	q = function(block)
		block:rotate(COUNTERCLOCKWISE)
	end,
}

function K.onBlockKeypress(input, block)
	if BLOCK[input] ~= nil then
		BLOCK[input](block)
	end
end

return K
