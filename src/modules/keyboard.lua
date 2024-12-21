require("constants.directions")

---@module "keyboard"

---@alias Key string
---@alias Keyboard {menu: table<string, Key>, game: table<string, Key>}

local K = {}

---@type Keyboard
K.maps = {
	menu = {
		quit = "q",
		restart = "r",
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

return K
