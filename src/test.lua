local function getArgs()
	local arguments = {}
	for a = 1, #arg do
		if string.find(arg[a], "-", 1, 2) ~= nil then
			table.insert(arguments, arg[a])
		end
	end
end
