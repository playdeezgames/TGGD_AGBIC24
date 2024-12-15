
local characters = {{
	["@"]=65,
	["A"]=66,
	["B"]=67,
	["C"]=68,
	["D"]=69,
	["E"]=70,
	["F"]=71,
	["G"]=72,
	["H"]=73,
	["I"]=74,
	["J"]=75,
	["K"]=76,
	["L"]=77,
	["M"]=78,
	["N"]=79,
	["O"]=80,
	["P"]=81,
	["Q"]=82,
	["R"]=83,
	["S"]=84,
	["T"]=85,
	["U"]=86,
	["V"]=87,
	["W"]=88,
	["X"]=89,
	["Y"]=90,
	["Z"]=91,
	["["]=92,
	["\\"]=93,
	["]"]=94,
	["^"]=95,
	["_"]=96,
	[" "]=97,
	["!"]=98,
	["\""]=99,
	["#"]=100,
	["$"]=101,
	["%"]=102,
	["&"]=103,
	["'"]=104,
	["("]=105,
	[")"]=106,
	["*"]=107,
	["+"]=108,
	[","]=109,
	["-"]=110,
	["."]=111,
	["/"]=112,
	["0"]=113,
	["1"]=114,
	["2"]=115,
	["3"]=116,
	["4"]=117,
	["5"]=118,
	["6"]=119,
	["7"]=120,
	["8"]=121,
	["9"]=122,
	[":"]=123,
	[";"]=124,
	["<"]=125,
	["="]=126,
	[">"]=127,
	["?"]=128
},{
	["@"]=1,
	["A"]=2,
	["B"]=3,
	["C"]=4,
	["D"]=5,
	["E"]=6,
	["F"]=7,
	["G"]=8,
	["H"]=9,
	["I"]=10,
	["J"]=11,
	["K"]=12,
	["L"]=13,
	["M"]=14,
	["N"]=15,
	["O"]=16,
	["P"]=17,
	["Q"]=18,
	["R"]=19,
	["S"]=20,
	["T"]=21,
	["U"]=22,
	["V"]=23,
	["W"]=24,
	["X"]=25,
	["Y"]=26,
	["Z"]=27,
	["["]=28,
	["\\"]=29,
	["]"]=30,
	["^"]=31,
	["_"]=32,
	[" "]=33,
	["!"]=34,
	["\""]=35,
	["#"]=36,
	["$"]=37,
	["%"]=38,
	["&"]=39,
	["'"]=40,
	["("]=41,
	[")"]=42,
	["*"]=43,
	["+"]=44,
	[","]=45,
	["-"]=46,
	["."]=47,
	["/"]=48,
	["0"]=49,
	["1"]=50,
	["2"]=51,
	["3"]=52,
	["4"]=53,
	["5"]=54,
	["6"]=55,
	["7"]=56,
	["8"]=57,
	["9"]=58,
	[":"]=59,
	[";"]=60,
	["<"]=61,
	["="]=62,
	[">"]=63,
	["?"]=64
}}

local M = {}
M.COLUMNS = 32
M.ROWS = 16

local buffer = {}
while #buffer < M.ROWS do
	local line = {}
	while #line < M.COLUMNS do
		table.insert(line,1)
	end
	table.insert(buffer,line)
end
local cursor_column=1
local cursor_row = 16

function M.get_cell(column, row)
	if column>=1 and column<=M.COLUMNS and row>=1 and row<=M.ROWS then
		return buffer[row][column]
	end
end

function M.set_cell(column, row, cell)
	if column>=1 and column<=M.COLUMNS and row>=1 and row<=M.ROWS then
		buffer[row][column] = cell
	end
end

function M.clear(cell)
	for column=1, M.COLUMNS do
		for row=1,M.ROWS do
			M.set_cell(column, row, cell)
		end
	end
	cursor_column = 1
	cursor_row = 16
end
function M.write_cell(cell)
	M.set_cell(cursor_column, cursor_row, cell)
	cursor_column = cursor_column + 1
	if cursor_column>M.COLUMNS then
		cursor_column = cursor_column - M.COLUMNS
		cursor_row = cursor_row - 1
		if cursor_row < 1 then
			--TODO: scroll screen
			cursor_row = 1
		end
	end
end
function M.write(text, character_set)
	character_set = character_set or 1
	for index = 1, #text do
		local character = text:sub(index,index)
		local cell = characters[character_set][character]
		M.write_cell(cell)
	end
end
function M.new_line(character_set)
	while cursor_column~=1 do
		M.write(" ", character_set)
	end
end
function M.write_line(text, character_set)
	M.write(text, character_set)
	M.new_line(character_set)
end

return M