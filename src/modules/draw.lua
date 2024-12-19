local D = {}

function D.rectangle(mode, color, x, y, width, height)
	mode = mode or "fill"
	love.graphics.setColor(color)
	love.graphics.rectangle(mode, x, y, width, height)
end

return D
