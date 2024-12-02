local tables = require("modules.tables")

SHAPES = {}
SHAPES.o = {
	{ 1, 1 },
	{ 1, 1 },
}
SHAPES.l = {
	{ 0, 2, 0 },
	{ 0, 2, 0 },
	{ 0, 2, 2 },
}
SHAPES.j = {
	{ 0, 3, 0 },
	{ 0, 3, 0 },
	{ 3, 3, 0 },
}
SHAPES.i = {
	{ 0, 4, 0, 0 },
	{ 0, 4, 0, 0 },
	{ 0, 4, 0, 0 },
	{ 0, 4, 0, 0 },
}
SHAPES.t = {
	{ 0, 5, 0 },
	{ 5, 5, 5 },
	{ 0, 0, 0 },
}
SHAPES.s = {
	{ 0, 6, 6 },
	{ 6, 6, 0 },
	{ 0, 0, 0 },
}
SHAPES.z = {
	{ 7, 7, 0 },
	{ 0, 7, 7 },
	{ 0, 0, 0 },
}

SHAPES_KEYS = tables.getKeys(SHAPES)
