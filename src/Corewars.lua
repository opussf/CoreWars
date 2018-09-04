COREWARS_MSG_VERSION = GetAddOnMetadata( "COREWARS","Version" )
COREWARS_MSG_ADDONNAME = GetAddOnMetadata( "COREWARS","Title" )
COREWARS_MSG_AUTHOR = GetAddOnMetadata( "COREWARS", "Author" )

-- Colours
COLOR_RED = "|cffff0000";
COLOR_GREEN = "|cff00ff00";
COLOR_BLUE = "|cff0000ff";
COLOR_PURPLE = "|cff700090";
COLOR_YELLOW = "|cffffff00";
COLOR_ORANGE = "|cffff6d00";
COLOR_GREY = "|cff808080";
COLOR_GOLD = "|cffcfb52b";
COLOR_NEON_BLUE = "|cff4d4dff";
COLOR_END = "|r";


Corewars = {}
Corewars.size = 4096                  -- 2 ^12  -- needs 12 bits to hold an address
Corewars.encodeInstruction = 2 ^ 28   --  4 bits
Corewars.encodeAMode       = 2 ^ 26   --  2 bits
Corewars.encodeBMode       = 2 ^ 24   --  2 bits
Corewars.encodeALoc        = 2 ^ 12   -- 12 bits
Corewars.encodeBLoc        = 2 ^ 0    -- 12 bits
Corewars.coreMemory = {}
--Corewars.aProgram = {}
--Corewars.bProgram = {}
Corewars.instructions = {
	["dat"] = { 0, nil, value },  -- 0       DAT            B   Initialize location to value B.
	["mov"] = { 1, data, loc },   -- 1       MOV      A     B   Move A into location B.
	["add"] = { 2, },             -- 2       ADD      A     B   Add operand A to contents of location B, and store result in location B
	["sub"] = { 3, },             -- 3       SUB      A     B   Sub operand A from ^^^
	["jmp"] = { 4, },             -- 4       JMP            B   Jump to location B
	["jmz"] = { 5, },             -- 5       JMZ      A     B   If operand A is 0, jump to location B; otherwise continue with next instruction.
	["djz"] = { 6, },             -- 6       DJZ      A     B   Decrement contents of location A by 1. If location A now holds 0, jump to location B; otherwise continue with next instruction.
	["cmp"] = { 7, },             -- 7       CMP      A     B   Compare operand  A with operand B. If they are not equal, skip next instruction; otherwise continue with next instruction.
}

function Corewars.Init()
	Corewars.coreMemory = {}
	for i = 0, Corewars.size do
		Corewars.coreMemory[i] = 0
	end
end
function Corewars.EncodeAddress( addressToEncode, currentAddress )
	local immediate = string.find( addressToEncode, "#" )  -- #<num>  = <num> is the value
	local indirect = string.find( addressToEncode, "@" )   -- @<num}  = go to the address referenced by this num, to get the value
	                                                       -- no symbol = Relative, go to the offset to get the value.
	print( "imm: "..( immediate or "nil" ) )
	print( "ind: "..( indirect or "nil" ) )
	print( "offset: "..( immediate or indirect ) and 2 or 1 )
	print( string.sub( addressToEncode, 2 ) )
	local val = ( currentAddress + tonumber( string.sub( addressToEncode, (immediate or indirect) and 2 or 1 ) ) ) % Corewars.size
	print( "val: "..( val or "nil" ) )

	return val
end
function Corewars.EncodeInstruction( instr, A, B )
	local value = Corewars.instructions[instr][1] * 2 ^ 28
	local address = Corewars.EncodeAddress( A )

	return value
end
