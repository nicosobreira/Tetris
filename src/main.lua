local love = require("love")
local keyboard = require("modules.keyboard")
require("classes.Block")
require("classes.Arena")

FPS = 60
MS_PER_FRAME = FPS / 3600

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

function love.conf(t)
	t.version = "11.5"
end

function love.load()
	love.window.setTitle("Tetris")

	math.randomseed(os.time())

	Game = {}
	Game.arena = Arena(12, 20, 10, 1, 50)
	Game.block = Block(3, 3)
end

function love.keypressed(key)
	keyboard.blockIsDown(key, Game.block, Game.arena)
	if key == "escape" then
		love.event.quit()
	end
end

function love.update()
	Game.block:fall(Game.arena)
end

function love.draw()
	os.execute(CLEAR)
	Game.arena:draw()
	Game.block:draw()
end

function love.run()
	if love.load then
		love.load()
	end

	local current = 0
	local previuos = love.timer.getTime()
	local elapsed = 0
	local lag = 0.0

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
		elapsed = current - previuos
		previuos = current
		lag = lag + elapsed

		love.keypressed()
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
