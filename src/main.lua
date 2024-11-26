local love = require("love")
local shapes = require("modules.shapes")
local matrix = require("modules.matrix")
require("classes.Block")

CELLSIZE = 16

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
	Current_block:merge(Arena)
end

function love.load()
	math.randomseed(os.time())

	love.window.setTitle("Tetris")
	-- current_block = Block.newRandom(5, 5, CELLSIZE)
	Current_block = Block.new(5, 5, shapes.l, CELLSIZE)
	Arena = matrix.newM(10, 20)
	Current_block:merge(Arena)
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
	matrix.printM(Arena)
	matrix.drawM(Arena, 10, 10, CELLSIZE)
end
