local T = {}

function T.print(tbl, sep)
	sep = sep or " "
	for _, item in ipairs(tbl) do
		io.write(item .. sep)
	end
	print()
end

function T.getKeys(tbl)
	local keys = {}
	for k, _ in pairs(tbl) do
		table.insert(keys, k)
	end
	return keys
end

function T.reverseT(tbl)
	local temp
	local len = #tbl
	for n = 1, math.floor(len / 2) do
		temp = tbl[n]
		tbl[n] = tbl[len - (n - 1)]
		tbl[len - (n - 1)] = temp
	end
end

function T.include(tbl, element)
	local count = 1
	for i = 1, #tbl do
		if tbl[i] == element then
			return true
		end
	end
	return false
end

function T.set(tbl, value)
	for i = 1, #tbl do
		tbl[i] = value
	end
end

return T
