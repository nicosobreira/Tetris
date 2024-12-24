---@module "keyboard"

require("constants.directions")

---@alias key string a key [example "a"]
---@alias action string a action name to be done when key is pressed
---@alias bla {[action]: key}

local K = { modes = {}, maps = {} }

K.modes = {
	global = "global",
	menu = "menu",
	game = "game",
}

K.maps.wasd = {
	global = {
		switch_mode = "escape",
	},
	menu = {
		restart = "r",
		quit = "q",
		debug = "d",
	},
	game = {
		left = "a",
		right = "d",
		down = "s",
		force_down = "w",
		rotate_clock = "e",
		rotate_counter_clock = "q",
	},
}

K.maps.ijkl = {
	global = {
		switch_mode = "escape",
	},
	menu = {
		restart = "r",
		quit = "q",
	},
	game = {
		left = "j",
		right = "l",
		down = "k",
		force_down = "i",
		rotate_clock = "o",
		rotate_counter_clock = "u",
	},
}

return K
