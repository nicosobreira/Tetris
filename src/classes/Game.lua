Game = {}

function Game.__index(_, key)
	return Game[key]
end

---@alias Game {block: Block, arena: Arena, x: number, y: number, fall_speed: number, score_raise_speed: number}
function Game.new(block, arena, x, y, fall_speed, score_raise_speed, score_multiply)
	local self = setmetatable({}, Arena)

	self.block = block
	self.arena = arena
	self.pos = { x = x or 0, y = y or 0 }
	self.fall_speed = fall_speed
	self.score_raise_speed = score_raise_speed
	self.score_multiply = score_multiply
end
