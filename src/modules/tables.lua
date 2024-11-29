local T = {}

function T.getKeys(tbl)
	local keys = {}
	local index = 0
	for k, _ in pairs(tbl) do
		keys[index] = k
	end
	return keys
end

function T.reverseT(tbl)
	local temp = 0
	for n = 1, math.floor(#tbl / 2) do
		temp = tbl[n]
		tbl[n] = tbl[#tbl - (n - 1)]
		tbl[#tbl - (n - 1)] = temp
	end
end

return T
