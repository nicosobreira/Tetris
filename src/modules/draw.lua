local D = {}

function D.rectangle(mode, color, x, y, width, height, scale)
	mode = mode or "fill"
	scale = scale or 1
	love.graphics.setColor(color)
	love.graphics.rectangle(mode, x, y, width * scale, height * scale)
	-- love.graphics.setColor()
end

return D
