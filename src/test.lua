local function eraseTerminal()
	os.execute("clear")
end

local function getTerminalSize()
	local handle = io.popen("stty size", r)
	local result = handle:read("*a")
	handle:close()

	if result then
		local rows, cols = result:match("(%d+) (%d+)")
		return tonumber(rows), tonumber(cols)
	end
end

-- writes an `*' at column `x' , row `y'
local function mark(x, y)
	io.write(string.format("\27[%d;%dH*", math.floor(y), math.floor(x)))
end
-- Terminal size
local t_rows, t_cols = getTerminalSize()
TermSize = { w = t_cols, h = t_rows }

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
