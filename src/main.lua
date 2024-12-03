local love = require("love")
require("classes.Block")
require("classes.Arena")
require("const.shapes")
require("const.cellsize")

-- FIX `Block:rotate` is STILL broken

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

-- TODO refatorar `const.sprites` para que seja preciso só passar o nome no arquivo

BlockKeypress = {
	a = function(block)
		block.pos.x = block.pos.x - 1
	end,
	d = function(block)
		block.pos.x = block.pos.x + 1
	end,
	j = function(block)
		block.pos.y = block.pos.y + 1
	end,
	k = function(block)
		block.pos.y = block.pos.y - 1
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

	Block_current = Block.new(0, 0, SHAPES.l)
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
	Block_current:checkFall(Block_fall_speed)

	if Block_current.pos.y + Block_current.size.y >= Arena_current.pos.y + Arena_current.size.y then
		Block_current:onCollision(Arena_current.matrix)
	end
end

function love.draw()
	os.execute("clear")
	Arena_current:draw()
	Block_current:draw()
end
