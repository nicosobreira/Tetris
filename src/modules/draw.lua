local love = require("love")

local D = {}

function D.cell(mode, color, x, y, size)
	mode = mode or "fill"
	love.graphics.setColor(color)
	love.graphics.rectangle(mode, x, y, size, size)
end

---@param text string
---@param x number
---@param y number
---@param width number
---@param height number
---@param scale? number
---@param r? number
function D.printCenter(text, x, y, width, height, scale, r)
	scale = scale or 1
	r = r or 0
	-- local to_draw_x = math.abs((text:len() / 2) - (x + width / 2))
	-- local to_draw_y = y + height / 2 - sy
	local to_draw_x = x
	local to_draw_y = y
	love.graphics.print(text, to_draw_x, to_draw_y, r, scale, scale)
end

---@param text string
---@param x number
---@param y number
---@param scale? number
---@param r? number
function D.print(text, x, y, scale, r)
	scale = scale or 1
	r = r or 0
	love.graphics.print(text, x, y, r, scale, scale)
end

return D
