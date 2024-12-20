---@alias Game {block: Block, arena: Arena, pos: {x: number, y: number}, fall_speed: number, score_raise_speed: number, score_multiply: number}
Game = {}

function Game.__index(_, key)
	return Game[key]
end

---Create a new game.
---@param block Block
---@param arena Arena
---@param x integer
---@param y integer
---@param fall_speed integer
function Game.new(block, arena, x, y, fall_speed, score_raise_speed, score_multiply)
	local self = setmetatable({}, Arena)

	self.block = block
	self.arena = arena
	self.pos = { x = x or 0, y = y or 0 }
	self.fall_speed = fall_speed
	self.score_raise_speed = score_raise_speed
	self.score_multiply = score_multiply
end
