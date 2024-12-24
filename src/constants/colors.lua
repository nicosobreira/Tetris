local love = require("love")

local function setColors(rgbs)
	local colors = {}
	for i = 1, #rgbs do
		colors[i] = { love.math.colorFromBytes(rgbs[i]) }
	end
	return colors
end

local RGBS = {
	{ 95, 87, 79 }, -- gray
	{ 255, 236, 39 }, -- yellow
	{ 255, 163, 0 }, -- orange
	{ 255, 119, 168 }, -- pink
	{ 41, 173, 255 }, -- blue
	{ 131, 118, 156 }, -- purple
	{ 0, 228, 54 }, -- green
	{ 255, 0, 77 }, -- red
	{ 255, 241, 232 }, -- white
}

COLORS = setColors(RGBS)
