local love = require("love")
local keyboard = require("modules.keyboard")
require("classes.Block")
require("classes.Arena")

--[ 1 TODO(s) Blocos
--2 Esses blocos que caírem precisam ficar na Arena
--  Para fazer isso crie um metodo na classe `Block` que verifique se em uma determinada matrix algum valor diferente de zero está presente
--3 Preciso de um sistema de colisão que detecte o bloco atual com os blocos da arena
--4 Eu preciso fazer com que a Arena caía depois da etapa 3
--]
--[ 2 TODO(s) Placar
--1 Preciso de um placar que fique no meio da largura da arena
--2 Esse placar precisa ser encrementado por: fileira_completa * 10
--]
--[ 3 TODO(s) Game
--1 Detectar o estado de Game Over
--2 Depois que perder o jogo precisa acabar
--3 A dificultade (velocidade da queda dos blocos) precisa aumentar
--EXTRA Preciso criar um menu
--]

function love.load()
	love.window.setTitle("Tetris")

	math.randomseed(os.time())

	Game = {}
	Game.arena = Arena(0, 0, 12, 20)
	Game.block = Block(Game.arena.pos.x, Game.arena.pos.y, 3, 3, SHAPES.l)
	Time_last_fall = 0
	Block_fall_speed = 0.8
end

function love.keypressed(key)
	keyboard.onBlockKeypress(key, Game.block)
	if key == "escape" then
		love.event.quit()
	end
end

function love.update()
	if Game.block:isColliding(Game.arena.matrix) then
		Game.arena:merge(Game.block)
		Game.block:reset()
	end
	-- Block fall speed
	Game.block:fall(Block_fall_speed)
end

function love.draw()
	os.execute("clear")
	Game.arena:draw()
	Game.block:draw()
end
