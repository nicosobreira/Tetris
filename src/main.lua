_G.love = require("love")
local keyboard = require("modules.keyboard")
require("classes.Block")
require("classes.Arena")
require("classes.Game")

---@alias vector { x: number, y: number }

FPS = 60
MS_PER_FRAME = 1 / FPS

local function getOs()
	local fh = assert(io.popen("uname -o 2>/dev/null", "r"))
	local name = fh:read()

	return name or "Windows"
end

if getOs() == "Windows" then
	CLEAR = "cls"
else
	CLEAR = "clear"
end
function love.load()
	love.window.setTitle("Tetris")
	love.keyboard.setKeyRepeat(true)

	math.randomseed(os.time())
	local block = Block.new(3, 3)
	local arena = Arena.new(12, 20)
	Player = Game.new(block, arena, 0, 0, 50, 10, 1, keyboard.maps)
end

--- key, scancode, isrepeat
function love.keypressed(key, _, _)
	Game:onKeyDown(key)
	if key == "escape" then
		love.event.quit()
	end
end

function love.update()
	Player:update()
end

function love.draw()
	Player:draw()
end

---Main game loop.
function love.run()
	if love.load then
		love.load()
	end

	local current = 0
	local elapsed = 0
	local lag = 0
	local previous = love.timer.getTime()

	-- Main loop time.
	return function()
		-- Process events.
		if love.event then
			love.event.pump()
			for name, a, b, c, d, e, f in love.event.poll() do
				if name == "quit" then
					if not love.quit or not love.quit() then
						return a or 0
					end
				end
				love.handlers[name](a, b, c, d, e, f)
			end
		end

		-- Call update and draw
		current = love.timer.getTime()
		elapsed = current - previous
		previous = current
		lag = lag + elapsed

		while lag >= MS_PER_FRAME do
			if love.update then
				love.update()
			end
			lag = lag - MS_PER_FRAME
		end

		if love.graphics and love.graphics.isActive() then
			love.graphics.origin()
			love.graphics.clear(love.graphics.getBackgroundColor())

			if love.draw then
				love.draw()
			end

			love.graphics.present()
		end

		if love.timer then
			love.timer.sleep(0.001)
		end
	end
end
