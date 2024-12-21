local tables = require("modules.tables")
local matrix = require("modules.matrix")
require("constants.directions")

---@alias mode string

local GAME = "game"
local MENU = "menu"

---@class Game
---@field block Block
---@field arena Arena
---@field pos vector
---@field score { multiply: number, for_decrease_speed: number, total: number, count: number }
---@field fall_speed number
---@field last_fall number
---@field clear_lines integer
---@field keys Keyboard
---@field is_alive boolean
Game = {}

function Game.__index(_, key)
	return Game[key]
end

---@param is_alive boolean
---@return mode
function Game.setKeyMode(is_alive)
	if is_alive then
		return GAME
	else
		return MENU
	end
end

---Create a new game.
---@param block Block
---@param arena Block
---@param x integer
---@param y integer
---@param score_raise_speed number
---@param score_multiply number
---@param fall_speed integer
---@param keys Keyboard
function Game.new(block, arena, x, y, score_raise_speed, score_multiply, fall_speed, keys)
	local self = setmetatable({}, Game)

	self.block = block
	self.arena = arena
	self.pos = { x = x, y = y }
	self.score_raise_speed = score_raise_speed
	self.score_multiply = score_multiply
	self.score = {
		multiply = score_multiply,
		for_decrease_speed = score_raise_speed,
		total = 0,
		count = 0,
	}
	self.fall_speed = fall_speed
	self.keys = keys
	self.last_fall = 0
	self.clear_lines = 0
	self.is_alive = true
	self.key_mode = Game.setKeyMode(self.is_alive)

	return self
end

---Updates the game
function Game:update()
	if self.is_alive then
		self:fall()
	else
		-- self:openMenu()
	end
end

---Draws the game.
function Game:draw()
	os.execute(CLEAR)
	self.arena:draw(self.pos.x, self.pos.y)
	self.block:draw(self.pos.x, self.pos.y)
	self:debug()
end

function Game:debug()
	for name, value in pairs(self) do
		if type(value) ~= "function" then
			io.write(name .. ": ")
			if type(value) == "table" then
				io.write("table")
			elseif type(value) == "boolean" then
				local bool = value and "true" or "false"
				io.write(bool)
			else
				io.write(value)
			end
			io.write("\n")
		end
	end
end

function Game:fall()
	local time_current = love.timer.getTime() - self.last_fall
	if time_current >= self.fall_speed then
		self.last_fall = love.timer.getTime()
		self.block:drop()
		if self.block:isOverlapping(self.arena.matrix) then
			self:onOverlap()
		end
	end
end

function Game:isGameOver()
	self.block:reset()
	if self.block:isOverlapping(self.arena.matrix) then
		return true
	end
	return false
end

-- FIX The self.clear_lines will add to infinity, limit it!
function Game:sweep()
	for i = 1, #self.arena.matrix do
		if not tables.include(self.arena.matrix[i], 0) then
			tables.set(self.arena.matrix[i], 0)
			self.arena:moveDown(i)
			self.clear_lines = self.clear_lines + 1
		end
	end
	if self.clear_lines >= 4 then
		self.score.total = self.score.total + self.score.multiply * self.clear_lines
	else
		self.score.total = self.score.total + self.score.multiply
	end
end

-- FIX variables names
function Game:decreaseVelocity()
	if self.fall_speed > 0.2 then
		self.fall_speed = self.fall_speed - 0.2
	end
	self.score.for_decrease_speed = math.floor(self.score.for_decrease_speed * (1.5 + self.score.count / 2))
	self.score.count = self.score.count + 1
end

function Game:onOverlap()
	self.arena:merge(self.block)
	self:sweep()
	if self.score.total >= self.score.for_decrease_speed then
		self:decreaseVelocity()
	end
	if self:isGameOver() then
		self.is_alive = false
		self.key_mode = Game.setKeyMode(self.is_alive)
	end
end

---Resets the game.
function Game:reset()
	self.block:reset()
	self.arena:reset()
	self.score.total = 0
	self.is_alive = true
	self.key_mode = Game.setKeyMode(self.is_alive)
end

function Game:keyPress()
	for _, key in pairs(self.keys.game) do
		if love.keyboard.isDown(key) then
			self:onKeyDown(key)
		end
	end
end

-- FIX movement isn't working :(
---@param key Key
function Game:onKeyDown(key)
	if self.key_mode == GAME then
		if key == self.keys.game.left then
			self.block:moveHorizontal(LEFT, self.arena.matrix)
		elseif key == self.keys.game.right then
			self.block:moveHorizontal(RIGHT, self.arena.matrix)
		elseif key == self.keys.game.down then
			self.block:drop()
			if self.block:isOverlapping(self.arena.matrix) then
				self:onOverlap()
			end
		elseif key == self.keys.game.force_down then
			for _ = self.block.pos.y, #self.arena.matrix, DOWN do
				self.block:drop()
				if self.block:isOverlapping(self.arena.matrix) then
					self:onOverlap()
					break
				end
			end
		elseif key == self.keys.game.rotate_clock then
			self.block:rotate(CLOCKWISE, self.arena.matrix)
		elseif key == self.keys.game.rotate_counter_clock then
			self.block:rotate(COUNTERCLOCKWISE, self.arena.matrix)
		end
	elseif self.key_mode == MENU then
		if key == self.keys.menu.quit then
			love.event.quit()
		elseif key == self.keys.menu.restart then
		end
	end
end
