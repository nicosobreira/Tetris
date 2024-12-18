local love = require("love")
local keyboard = require("modules.keyboard")
require("classes.Block")
require("classes.Arena")

--[ TODO(s) Game
--1 Depois que perder o jogo precisa reiniciar
--2 A dificultade (velocidade da queda dos blocos) precisa aumentar
--3 Ao invés de usar sprites usar love2d draw rectangle com a cor
--4 Adicionar efeitos sonoros
--EXTRA Preciso criar um menu
--]

--[ TODO(s) Placar
--1 Preciso de um placar que fique no meio da largura da arena
--]

local function getOs()
	local name
	-- Unix, Linux variants
	local fh, _ = assert(io.popen("uname -o 2>/dev/null", "r"))
	name = fh:read()

	return name or "Windows"
end

function love.conf(t)
	t.version = "11.5"
end

function love.load()
	love.window.setTitle("Tetris")

	math.randomseed(os.time())
	if getOs() == "GNU/Linux" then
		CLEAR = "clear"
	else
		CLEAR = "cls"
	end

	Game = {}
	Game.arena = Arena(12, 20)
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
	Game.arena:draw(5, 5)
	Game.block:draw(5, 5)
end
