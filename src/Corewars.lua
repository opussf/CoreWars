COREWARS_SLUG, Corewars = ...
COREWARS_MSG_VERSION    = C_AddOns.GetAddOnMetadata( COREWARS_SLUG, "Version" )
COREWARS_MSG_ADDONNAME  = C_AddOns.GetAddOnMetadata( COREWARS_SLUG, "Title" )
COREWARS_MSG_AUTHOR     = C_AddOns.GetAddOnMetadata( COREWARS_SLUG, "Author" )

-- Colours
COLOR_RED = "|cffff0000"
COLOR_GREEN = "|cff00ff00"
COLOR_BLUE = "|cff0000ff"
COLOR_PURPLE = "|cff700090"
COLOR_YELLOW = "|cffffff00"
COLOR_ORANGE = "|cffff6d00"
COLOR_GREY = "|cff808080"
COLOR_GOLD = "|cffcfb52b"
COLOR_NEON_BLUE = "|cff4d4dff"
COLOR_END = "|r"

Corewars.size = 4096                  -- 2 ^12  -- needs 12 bits to hold an address
Corewars.encodeInstruction = 2 ^ 28   --  4 bits
Corewars.encodeAMode       = 2 ^ 26   --  2 bits
Corewars.encodeBMode       = 2 ^ 24   --  2 bits
Corewars.encodeALoc        = 2 ^ 12   -- 12 bits
Corewars.encodeBLoc        = 2 ^ 0    -- 12 bits
Corewars.coreMemory = {}
Corewars.programs = {                 -- Keep the program here as a table
	[1] = {},
	[2] = {},
}
Corewars.instructions = {
	["dat"] = { 0, nil, "value" },  -- 0       DAT            B   Initialize location to value B.
	["mov"] = { 1, data, loc },     -- 1       MOV      A     B   Move A into location B.
	["add"] = { 2, },               -- 2       ADD      A     B   Add operand A to contents of location B, and store result in location B
	["sub"] = { 3, },               -- 3       SUB      A     B   Sub operand A from ^^^
	["jmp"] = { 4, },               -- 4       JMP            B   Jump to location B
	["jmz"] = { 5, },               -- 5       JMZ      A     B   If operand A is 0, jump to location B; otherwise continue with next instruction.
	["djz"] = { 6, },               -- 6       DJZ      A     B   Decrement contents of location A by 1. If location A now holds 0, jump to location B; otherwise continue with next instruction.
	["cmp"] = { 7, },               -- 7       CMP      A     B   Compare operand  A with operand B. If they are not equal, skip next instruction; otherwise continue with next instruction.
}

function Corewars.Init()
	Corewars.coreMemory = {}
	for i = 0, Corewars.size do
		Corewars.coreMemory[i] = 0
	end
end
function Corewars.SetProgram( num, progIn )
	-- input:
	--   num:  1 | 2      -- number to store
	--   progIn: (string) -- full program to use
	Corewars.programs[num] = { strsplit( "\n", progIn ) }
end
function Corewars.LoadProgramAtPosition( progNum, pos )
	-- @param progNum: [1|2] the number of the program to load into memory
	-- @param pos    : [0-Corewars.size] the location of the first command
	-- * get the size of the program
	local progSize = #Corewars.programs[ progNum ]

	-- * assert progSize is less than the core size
	if progSize >= Corewars.size then
		print( "fail this here.  Write some tests to require this code." )
	else  -- program will fit
		local progLoadPointer = pos % Corewars.size
		for instructionIndex = 1, progSize do
			print( instructionIndex )
		end
	end
end

function Corewars.LoadPrograms()
	local size0 = #Corewars.programs[0]
	local size1 = #Corewars.programs[1]

	local start0 = random( Corewars.size )
	local start1 = random( Corewars.size )

	print( ("0: size: %d start: %d"):format( size0, start0 ) )
	print( ("1: size: %d start: %d"):format( size1, start1 ) )

end
--  [x] init the field
--      * Init sets the entire field to 0
--  [x] get 2 programs
--      * SetProgram takes a "\n" delimited string (file contents) and loads it as a table to Corewars.programs[1|2]

--  *) determine where to put them in memory
--     Random locations, cannot overlap
--  *) store them in memory
--  *) init execution
--  *) start execution
--  *) execute until a winner is determined
--  *) report the winner
--  *) clean up







function Corewars.ParseAddress( addressToParse )
	-- return: Mnemonic(str), value(int), mode(bitfield)

	return "#", 4, 0
end
function Corewars.EncodeAddress( addressToEncode, currentAddress )
	print( "EncodeAddress( "..addressToEncode..", "..currentAddress.." )" )
	local immediate = string.find( addressToEncode, "#" )  -- #<num>  = <num> is the value
	local indirect = string.find( addressToEncode, "@" )   -- @<num}  = go to the address referenced by this num, to get the value
	                                                       -- no symbol = Relative, go to the offset to get the value.
	print( "is immediate: "..( immediate or "nil" ).." " )
	print( "is indirect : "..( indirect or "nil" ).." " )
	print( "offset: "..( immediate or indirect ) and 2 or 1 )
	print( string.sub( addressToEncode, 2 ) )
	local val = ( currentAddress + tonumber( string.sub( addressToEncode, (immediate or indirect) and 2 or 1 ) ) ) % Corewars.size
	print( "val: "..( val or "nil" ) )

	return val
end
function Corewars.EncodeInstruction( currentAddress, instr, A, B )
	local value = Corewars.instructions[instr][1] * 2 ^ 28
	local address = Corewars.EncodeAddress( A )

	return value
end

