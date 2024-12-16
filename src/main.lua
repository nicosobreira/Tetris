local love = require("love")
local keyboard = require("modules.keyboard")
require("classes.Block")
require("classes.Arena")

--[ TODO(s) Game
--1 Fazer com que se ganhe pontos depois de uma linha ser limpada
--2 Detectar o estado de Game Over
--3 Depois que perder o jogo precisa reiniciar
--4 A dificultade (velocidade da queda dos blocos) precisa aumentar
--5 Ao invés de usar sprites usar love2d draw rectangle com a cor
--6 Adicionar efeitos sonoros
--EXTRA Preciso criar um menu
--]

--[ TODO(s) Placar
--1 Preciso de um placar que fique no meio da largura da arena
--]

Game = {}

function love.load()
	love.window.setTitle("Tetris")

	math.randomseed(os.time())

	Game.game_over = false
	Game.score = 0
	Game.score_mult = 10
	Game.arena = Arena(12, 20)
	Game.block = Block(3, 3, SHAPES.i)
	Game.clear_lines = {}
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
	if Game.block:isOverlapping(Game.arena.matrix) then
		Game.arena:merge(Game.block)
		Game.clear_lines = Game.arena:getClearLines()
		if #Game.clear_lines ~= 0 then
			Game.arena.clearLines(Game.clear_lines, Game.score, Game.score_mult)
		end
		Game.game_over = Game.block:isGameOver(Game.arena.matrix)
		if Game.game_over then
			Game.arena:reset()
			Game.score = 0
		end
	end
	Game.block:fall(Block_fall_speed)
end

function love.draw()
	os.execute("clear")
	print(Game.score)
	Game.arena:draw(5, 5)
	Game.block:draw(5, 5)
end
