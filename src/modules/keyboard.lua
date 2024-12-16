require("constants.directions")

local BLOCK = {
	a = function(block, arena_matrix)
		block:goHorizontal(LEFT, arena_matrix)
	end,
	d = function(block, arena_matrix)
		block:goHorizontal(RIGHT, arena_matrix)
	end,
	s = function(block, arena_matrix)
		block:goVertical(DOWN, arena_matrix)
	end,
	w = function(block, arena_matrix)
		block:goForceVertical(DOWN, arena_matrix)
	end,
	e = function(block, arena_matrix)
		block:rotateClock(arena_matrix)
	end,
	q = function(block, arena_matrix)
		block:rotateCounterClock(arena_matrix)
	end,
}

local K = {}

function K.blockIsDown(key, block, arena_matrix)
	if BLOCK[key] ~= nil then
		BLOCK[key](block, arena_matrix)
	end
end

return K
