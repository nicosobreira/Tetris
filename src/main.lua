local love = require("love")
local keyboard = require("modules.keyboard")
require("classes.Block")
require("classes.Arena")
require("classes.Game")

---@class vector
---@field x number
---@field y number

local FPS = 60

---@return string Os name
local function getOs()
	local fh = assert(io.popen("uname -o 2>/dev/null", "r"))
	local name = fh:read()

	return name or "Windows"
end

---@return string clear command
local function getClear()
	if getOs() == "Windows" then
		return "cls"
	else
		return "clear"
	end
end

---@param height integer the number of cells that will be need
---@param border? number the value for the empty space
---@return number the new cell size
local function getCellsize(height, border)
	border = border or 1
	local matrix_height = height
	return (love.graphics.getHeight() / matrix_height) * border
end

function love.load()
	love.keyboard.setKeyRepeat(true)

	math.randomseed(os.time())
	CLEAR = getClear()
	Player = Game.new(Block.new(3, 3), Arena.new(10, 20), 50, 10, 1, keyboard.maps.wasd)
end

---@param key key
function love.keypressed(key)
	Player:onKeyPress(key)
end

local previous = love.timer.getTime()
local lag = 0
local MS_PER_FRAME = 1 / FPS

function love.update()
	local current = love.timer.getTime()
	local elapsed = current - previous
	previous = current
	lag = lag + elapsed

	while lag >= MS_PER_FRAME do
		Player:update()
		lag = lag - MS_PER_FRAME
	end
end

function love.draw()
	local cellsize = getCellsize(#Player.arena.matrix, 0.6)
	Player:draw(cellsize, CLEAR)
end
