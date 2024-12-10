local love = require("love")
local keyboard = require("modules.keyboard")
require("classes.Block")
require("classes.Arena")

-- FIX quando rotacionar verificar se não vai ficar preso na parede

--[ 1 TODO(s) Game
--1 Fazer com que se ganhe pontos depois de uma linha ser limpada
--2 Detectar o estado de Game Over
--3 Depois que perder o jogo precisa acabar
--4 A dificultade (velocidade da queda dos blocos) precisa aumentar
--EXTRA Preciso criar um menu
--]

--[ 2 TODO(s) Placar
--1 Preciso de um placar que fique no meio da largura da arena
--2 Esse placar precisa ser encrementado por: fileira_completa * 10
--]

function love.load()
	love.window.setTitle("Tetris")

	math.randomseed(os.time())

	Game = {}
	Game.arena = Arena(0, 0, 12, 20)
	Game.block = Block(Game.arena.pos.x, Game.arena.pos.y, 3, 3, SHAPES.i)
	Time_last_fall = 0
	Block_fall_speed = 1
end

function love.keypressed(key)
	keyboard.onBlockKeypress(key, Game.block, Game.arena)
	if key == "escape" then
		love.event.quit()
	end
end

function love.update()
	Game.arena:hasCompleteLines()
	-- Block fall speed
	Game.block:fall(Block_fall_speed)
	if Game.block:isColliding(Game.arena.matrix) then
		Game.arena:merge(Game.block)
		Game.block:reset()
	end
end

function love.draw()
	os.execute("clear")
	Game.arena:draw()
	Game.block:draw()
end
