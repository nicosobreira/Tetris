local love = require("love")
local shapes = require("modules.shapes")
local matrix = require("modules.matrix")
local tables = require("modules.tables")
require("classes.Block")
require("classes.Arena")
require("cellsize")

-- TODO Make the possible key press a table, so if I want to add more or less depending on the user parameter (like debug mode) it's more easy!

BlockKeypress = {
	a = function(block)
		block.pos.y = block.pos.y - 1
	end,
	d = function(block)
		block.pos.y = block.pos.y + 1
	end,
	e = function(block)
		block:rotate(1)
	end,
	q = function(block)
		block:rotate(-1)
	end,
}

local function blockKeypress(current_block, matrix)
	for key, func in pairs(BlockKeypress) do
		if love.keyboard.isDown(key) then
			func(current_block)
			current_block:merge(matrix)
		end
	end
end

function love.load()
	love.window.setTitle("Tetris")

	math.randomseed(os.time())

	Current_block = Block.new(5, 5, shapes.l)
	myArena = Arena.new(math.floor(love.graphics.getWidth() / 2), math.floor(love.graphics.getHeight() / 2), 12, 20)
	Current_block:merge(myArena.matrix)
end

function love.keypressed(key)
	blockKeypress(Current_block, myArena.matrix)
	if key == "escape" then
		love.event.quit()
	end
end

function love.update() end

function love.draw()
	os.execute("clear")
	myArena:draw()
end
