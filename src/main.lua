local love = require("love")
local keyboard = require("modules.keyboard")
require("classes.Block")
require("classes.Arena")

-- FIX Não limpa a linha

--[ TODO(s) Blocos
--1 Ao girar detectar se vai ficar preso
--]

--[ TODO(s) Game
--1 Fazer com que se ganhe pontos depois de uma linha ser limpada
--2 Detectar o estado de Game Over
--3 Depois que perder o jogo precisa acabar
--4 A dificultade (velocidade da queda dos blocos) precisa aumentar
--EXTRA Preciso criar um menu
--5 Ao invés de usar sprites usar love2d draw rectangle com a cor
--6 Adicionar efeitos sonoros
--]

--[ TODO(s) Placar
--1 Preciso de um placar que fique no meio da largura da arena
--]

-- IDEA

function love.load()
	love.window.setTitle("Tetris")

	math.randomseed(os.time())

	Game = {}
	Game.score = 0
	Game.score_mult = 10
	Game.arena = Arena(0, 0, 12, 20)
	Game.block = Block(3, 3, SHAPES.i)
	Time_last_fall = 0
	Block_fall_speed = 1
end

function love.keypressed(key)
	keyboard.blockIsDown(key, Game.block, Game.arena.matrix)
	if key == "escape" then
		love.event.quit()
	end
end

function love.update()
	-- Block fall speed
	Game.block:fall(Block_fall_speed)
	if Game.block:isOverlapping(Game.arena.matrix) then
		Game.arena:merge(Game.block)
		Game.arena:clearLine()
		Game.block:reset(Game.arena.matrix)
	end
end

function love.draw()
	os.execute("clear")
	Game.arena:draw()
	Game.block:draw()
end
