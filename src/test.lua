local function eraseTerminal()
	os.execute("clear")
end
-- writes an `*' at column `x' , row `y'
local function mark(x, y)
	io.write(string.format("\27[%d;%dH*", math.floor(y), math.floor(x)))
end
-- Terminal size
TermSize = { w = 80, h = 24 }

-- plot a function
-- (assume that domain and image are in the range [-1,1])
local function plot(f)
	eraseTerminal()
	for i = 1, TermSize.w do
		local x = (i / TermSize.w) * 2 - 1
		local y = (f(x) + 1) / 2 * TermSize.h
		mark(i, y)
	end
	_ = io.read() -- wait before spoiling the screen
	eraseTerminal()
end

plot(function(x)
	return math.sin(x * 2 * math.pi)
end)
