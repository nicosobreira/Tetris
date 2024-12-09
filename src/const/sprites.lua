local love = require("love")

local function setSprites(files, path)
	local sprites = {}
	for index, file in ipairs(files) do
		sprites[index] = love.graphics.newImage(path .. file)
	end
	return sprites
end

local PATH = "sprites/"

local FILES = {
	"gray.png",
	"yellow.png",
	"orange.png",
	"pink.png",
	"blue.png",
	"purple.png",
	"green.png",
	"red.png",
}

COLORS = setSprites(FILES, PATH)
