Arena = {
	cellsize = 0,
	pos = {
		x = 0,
		y = 0,
	},
	size = {
		x = 0,
		y = 0,
	},
	matrix = {},
}

function Arena.__index(_, key)
	return Arena[key]
end

function Arena.new(x, y, sx, sy, cellsize)
	local self = setmetatable({}, Arena)

	self.cellsize = cellsize
	self.pos = { x = x, y = y }
	self.size = { x = sx, y = sy }
	self.shape = shape

	return self
end
