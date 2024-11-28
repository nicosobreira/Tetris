local love = require("love")
local shapes = require("modules.shapes")
local matrix = require("modules.matrix")
require("classes.Block")
require("classes.Arena")
require("cellsize")

-- TODO Make the possible key press a table, so if I want to add more or less depending on the user parameter (like debug mode) it's more easy!

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
	Current_block:merge(myArena.matrix)
end

function love.load()
	love.window.setTitle("Tetris")

	math.randomseed(os.time())

	-- current_block = Block.newRandom(5, 5, CELLSIZE)
	Current_block = Block.new(5, 5, shapes.l)
	myArena = Arena.new(math.floor(love.graphics.getWidth() / 2), math.floor(love.graphics.getHeight() / 2), 12, 20)
	Current_block:merge(myArena.matrix)
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
	myArena:draw()
end
