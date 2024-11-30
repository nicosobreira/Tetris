local love = require("love")
local shapes = require("modules.shapes")
require("classes.Block")
require("classes.Arena")
require("cellsize")

BlockKeypress = {
	a = function(block)
		block.pos.x = block.pos.x - CELLSIZE
	end,
	d = function(block)
		block.pos.x = block.pos.x + CELLSIZE
	end,
	j = function(block)
		block.pos.y = block.pos.y + CELLSIZE
	end,
	k = function(block)
		block.pos.y = block.pos.y - CELLSIZE
	end,
	e = function(block)
		block:rotate(1)
	end,
	q = function(block)
		block:rotate(-1)
	end,
}

local function blockKeypress(current_block)
	for key, func in pairs(BlockKeypress) do
		if love.keyboard.isDown(key) then
			func(current_block)
		end
	end
end

function love.load()
	love.window.setTitle("Tetris")

	math.randomseed(os.time())

	Current_block = Block.new(0, 0, shapes.l)
	myArena = Arena.new(0, 0, 12, 20)
end

function love.keypressed(key)
	blockKeypress(Current_block)
	if key == "escape" then
		love.event.quit()
	end
end

function love.update() end

function love.draw()
	os.execute("clear")
	myArena:draw()
	Current_block:draw()
end
