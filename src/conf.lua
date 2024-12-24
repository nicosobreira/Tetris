local love = require("love")

function love.conf(t)
	t.version = "11.5"
	t.window.title = "Tetris"
	t.window.resizable = true
	t.modules.joystick = false
	t.modules.physics = false
end
