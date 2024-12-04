require("const.directions")

local K = {}

local BLOCK = {
	a = function(block)
		block.pos.x = block.pos.x + LEFT
	end,
	d = function(block)
		block.pos.x = block.pos.x + RIGHT
	end,
	s = function(block)
		block.pos.y = block.pos.y + DOWN
	end,
	j = function(block)
		block.pos.y = block.pos.y + DOWN
	end,
	k = function(block)
		block.pos.y = block.pos.y + UP
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
