local love = require("love")
require("Block")
local shape = require("Shape.lua")

CELLSIZE = 32

function love.load() end

function love.keypressed(key)
	if key == "d" then
		l_block:rotate()
	elseif key == "escape" then
		love.event.quit()
	end
end

function love.update() end

function love.draw()
	-- o_block:draw()
	l_block:draw()
end
