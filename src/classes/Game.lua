local love = require("love")
local draw = require("modules.draw")
local matrix = require("modules.matrix")
local tables = require("modules.tables")
require("constants.directions")
require("constants.colors")

local function printRecursive(value, ignore)
	-- Default ignore table if not provided
	ignore = ignore or {}

	-- Check if the value is in the ignore list
	for _, ignoredValue in ipairs(ignore) do
		if value == ignoredValue then
			return
		end
	end

	-- Check if the value is a table
	if type(value) == "table" then
		-- Print the table recursively
		print("{")
		for key, val in pairs(value) do
			io.write("  " .. tostring(key) .. " = ")
			printRecursive(val, ignore)
		end
		print("}")
	-- Check if the value is a boolean
	elseif type(value) == "boolean" then
		print(value and "true" or "false")
	-- Check if the value is a function
	elseif type(value) == "function" then
		print("function")
	else
		-- For all other types, just print the value
		print(tostring(value))
	end
end

---@class Game
---@field block Block
---@field arena Arena
---@field score { multiply: number, for_decrease_speed: number, total: number, count: number }
---@field fall { speed: number, last: number, decrease_count: number, decrease_value: number, limit: number }
---@field clear_lines integer
---@field keys table
---@field modes { alive: boolean, menu: boolean, debug: boolean }
Game = {}

---@param key number
function Game.__index(_, key)
	return Game[key]
end

---Create a new game.
---@param block Block
---@param arena Block
---@param score_raise_speed number
---@param score_multiply number
---@param fall_speed integer
---@param keys table
function Game.new(block, arena, score_raise_speed, score_multiply, fall_speed, keys)
	local self = setmetatable({}, Game)

	self.block = block
	self.arena = arena
	self.score = {
		multiply = score_multiply,
		for_decrease_speed = score_raise_speed,
		total = 0,
		count = 0,
	}
	self.fall = {
		speed = fall_speed,
		last = 0,
		decrease_count = 0,
		decrease_value = 0.1,
		limit = 0.2,
	}
	self.keys = keys
	self.clear_lines = 0
	self.modes = {
		alive = true,
		menu = false,
		debug = false,
	}

	return self
end

-- FIX getMiddle...: Need to limit the amount

---@param y number
---@return number the top-left height in the middle
function Game.getMiddleHeight(y)
	local height = love.graphics.getHeight() / 2 - (y / 2)
	return height
end

---@param x number
---@return number the top-left width in the middle
function Game.getMiddleWidth(x)
	local width = love.graphics.getWidth() / 2 - (x / 2)
	return width
end

-- FIX the game don't enter menu mode
---Updates the game
function Game:update()
	if not self.modes.menu then
		self:drop()
	end
end

---Draws the game.
function Game:draw(cellsize, clear)
	-- Top left x and y values
	cellsize = math.floor(cellsize)
	local width = #self.arena.matrix[1] * cellsize
	local height = #self.arena.matrix * cellsize

	-- Width and height
	local x = Game.getMiddleWidth(width)
	local y = Game.getMiddleHeight(height)

	-- Print scale
	local scale = math.floor(cellsize / 16)

	if self.modes.menu then
		draw.print("Menu mode", x, y, scale)
		local count = 1
		for description, key in pairs(self.keys.menu) do
			local message = string.format("Press %s to %s", key:upper(), description:upper())
			draw.print(message, x, y + cellsize * count, scale)
			count = count + 1
		end
	else
		self.arena:draw(cellsize, x, y)
		self.block:draw(cellsize, x, y)
		draw.printCenter("Score: " .. tostring(self.score.total), x, y, width, scale)
	end
	if self.modes.debug then
		os.execute(clear)
		self:debug({ cellsize = cellsize, x = x, y = y, width = width, height = height })
	end
end

function Game:debug(info)
	info = info or nil
	matrix.print(self.arena.matrix)
	matrix.print(self.block.matrix)
	printRecursive(self, { self.block, self.arena, self.keys })
	printRecursive(info)
end

function Game:drop()
	local current_time = love.timer.getTime() - self.fall.last
	if current_time >= self.fall.speed - self.fall.decrease_count * self.fall.decrease_value then
		self.fall.last = love.timer.getTime()
		self.block:drop()
		if self.block:isOverlapping(self.arena.matrix) then
			self:onOverlap()
		end
	end
end

-- FIX When the clear_lines is 4 it never decrease
function Game:sweep()
	for i = 1, #self.arena.matrix do
		if not tables.include(self.arena.matrix[i], 0) then
			tables.set(self.arena.matrix[i], 0)
			self.arena:moveDown(i)
			self.clear_lines = math.min(self.clear_lines + 1, 4)
		end
	end
	if self.clear_lines >= 4 then
		self.score.total = self.score.total + self.score.multiply * self.clear_lines
	else
		self.score.total = self.score.total + self.score.multiply
	end
end

function Game:updateScore() end

-- FIX variables names
function Game:decreaseVelocity()
	if self.fall.speed > self.fall.limit then
		self.fall.decrease_count = self.fall.decrease_count + 1
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
	self.block:reset()
	if self.block:isOverlapping(self.arena.matrix) then
		self.modes.alive = false
	end
end

---Resets the game.
function Game:reset()
	self.block:reset()
	self.arena:reset()
	self.score.total = 0
	self.score.count = 0
	self.clear_lines = 0
	self.fall.decrease_count = 0
	self.modes.alive = true
	self.modes.menu = false
end

---@param key key
function Game:onKeyPress(key)
	self:globalKeypress(key)
	if not self.modes.menu then
		self:gameKeypress(key)
	else
		self:menuKeypress(key)
	end
end

function Game:globalKeypress(key)
	if key == self.keys.global.switch_mode then
		self.modes.menu = not self.modes.menu
	end
end

---@param key key
function Game:gameKeypress(key)
	if key == self.keys.game.left then
		self.block:moveHorizontal(LEFT, self.arena.matrix)
	elseif key == self.keys.game.right then
		self.block:moveHorizontal(RIGHT, self.arena.matrix)
	elseif key == self.keys.game.soft_drop then
		self.block:drop()
		if self.block:isOverlapping(self.arena.matrix) then
			self:onOverlap()
		end
	elseif key == self.keys.game.hard_drop then
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
end

function Game:menuKeypress(key)
	if key == self.keys.menu.restart then
		self:reset()
	elseif key == self.keys.menu.quit then
		love.event.quit(0)
	elseif key == self.keys.menu.debug then
		self.modes.debug = not self.modes.debug
	end
end
