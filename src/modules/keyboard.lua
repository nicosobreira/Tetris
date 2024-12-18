require("constants.directions")

local BLOCK = {
	a = function(block, arena_matrix)
		block:move("x", LEFT, arena_matrix)
	end,
	d = function(block, arena_matrix)
		block:move("x", RIGHT, arena_matrix)
	end,
	s = function(block, arena_matrix)
		block:move("y", DOWN, arena_matrix)
	end,
	w = function(block, arena)
		block:goForceVertical(DOWN, arena)
	end,
	e = function(block, arena_matrix)
		block:rotate(CLOCKWISE, arena_matrix)
	end,
	q = function(block, arena_matrix)
		block:rotate(COUNTERCLOCKWISE, arena_matrix)
	end,
}

local K = {}

function K.blockIsDown(key, block, arena)
	if BLOCK[key] ~= nil then
		if key == "w" then
			BLOCK[key](block, arena)
		else
			BLOCK[key](block, arena.matrix)
		end
	end
end

return K
