local love = require("love")
require("Block")

function love.load()
	local cell_size = 32
	o_block = Block.new(0, 0, cell_size, { { 1, 1 }, { 1, 1 } })
	l_block = Block.new(100, 100, cell_size, {
		{ 0, 2, 0 },
		{ 0, 2, 0 },
		{ 0, 2, 2 },
	})
end

function love.keypressed(key)
	if key == "d" then
		l_block:rotate()
	elseif key == "escape" then
		love.event.quit()
	end
end

function love.update() end

function love.draw()
	o_block:draw()
	l_block:draw()
end
