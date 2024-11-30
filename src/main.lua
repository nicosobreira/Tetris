local love = require("love")
local shapes = require("modules.shapes")
require("classes.Block")
require("classes.Arena")
require("cellsize")

-- FIX the `Block:rotate` is broken

--[ 1 TODO(s) Blocos
--2 Esses blocos que caírem precisam ficar na Arena
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

	Block_current = Block.new(0, 0, shapes.l)
	Arena_current = Arena.new(0, 0, 12, 20)
	Time_last_fall = 0
	Block_fall_speed = 1
end

function love.keypressed(key)
	blockKeypress(Block_current)
	if key == "escape" then
		love.event.quit()
	end
end

function love.update()
	-- Block fall speed
	local time_current = love.timer.getTime() - Time_last_fall
	if time_current > Block_fall_speed then
		Time_last_fall = love.timer.getTime()
		Block_current:fall()
	end
end

function love.draw()
	os.execute("clear")
	Arena_current:draw()
	Block_current:draw()
end
