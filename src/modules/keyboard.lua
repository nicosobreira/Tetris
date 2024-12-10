local love = require("love")
require("classes.Block")
require("const.directions")

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

local K = {}

function K.blockIsDown(block, arena)
	for key, func in pairs(BLOCK) do
		if love.keyboard.isDown(key) then
			if key == "a" or key == "d" then
				func(block, arena)
			else
				func(block)
			end
		end
	end
end

return K
