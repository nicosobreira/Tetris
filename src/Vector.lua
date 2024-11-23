Vector = {
	x = 0,
	y = 0,
}

function Vector.__index(_, key)
	return Vector[key]
end

Vector.new = function(x, y)
	local self = setmetatable({}, Vector)

	self.x = x
	self.y = y

	return self
end
