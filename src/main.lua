local love = require("love")
local shapes = require("modules.shapes")
local matrix = require("modules.matrix")
require("classes.Block")

CELLSIZE = 16

function love.load()
	math.randomseed(os.time())

	love.window.setTitle("Tetris")
	-- current_block = Block.newRandom(5, 5, CELLSIZE)
	current_block = Block.new(5, 5, shapes.l, CELLSIZE)
	Arena = matrix.newM(10, 20)
	current_block:merge(Arena)
end

function love.keypressed(key)
	if key == "d" then
		current_block:rotate()
		current_block:merge(Arena)
	elseif key == "escape" then
		love.event.quit()
	end
end

function love.update() end

function love.draw()
	os.execute("clear")
	matrix.printM(Arena)
	matrix.drawM(Arena, 10, 10, CELLSIZE)
end
