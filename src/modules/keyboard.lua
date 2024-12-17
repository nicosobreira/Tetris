require("constants.directions")

local BLOCK = {
	a = function(block, arena)
		block:goHorizontal(LEFT, arena)
	end,
	d = function(block, arena)
		block:goHorizontal(RIGHT, arena)
	end,
	s = function(block, arena)
		block:goVertical(DOWN, arena)
	end,
	w = function(block, arena)
		block:goForceVertical(DOWN, arena)
	end,
	e = function(block, arena)
		block:rotate(CLOCKWISE, arena)
	end,
	q = function(block, arena)
		block:rotate(COUNTERCLOCKWISE, arena)
	end,
}

local K = {}

function K.blockIsDown(key, block, arena)
	if BLOCK[key] ~= nil then
		BLOCK[key](block, arena)
	end
end

return K
