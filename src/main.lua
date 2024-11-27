local love = require("love")
local shapes = require("modules.shapes")
local matrix = require("modules.matrix")
require("classes.Block")
require("classes.Arena")
require("cellsize")

local function blockKeypress(key)
	if key == "a" then
		Current_block.pos.y = Current_block.pos.y - 1
	elseif key == "d" then
		Current_block.pos.y = Current_block.pos.y + 1
	elseif key == "e" then
		Current_block:rotate(1)
	elseif key == "q" then
		Current_block:rotate(-1)
	end
	myArena:merge(Current_block)
end

function love.load()
	love.window.setTitle("Tetris")

	math.randomseed(os.time())

	-- current_block = Block.newRandom(5, 5, CELLSIZE)
	Current_block = Block.new(5, 5, shapes.l)
	myArena = Arena.new(0, 0, 10, 20)
	myArena:merge(Current_block)
end

function love.keypressed(key)
	blockKeypress(key)
	if key == "escape" then
		love.event.quit()
	end
end

function love.update() end

function love.draw()
	os.execute("clear")
	matrix.printM(Arena.matrix)
	myArena:draw()
end
