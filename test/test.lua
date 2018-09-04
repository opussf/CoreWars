#!/usr/bin/env lua

addonData = { ["Version"] = "1.0",
}

require "wowTest"

test.outFileName = "testOut.xml"

package.path = "../src/?.lua;'" .. package.path
require "Corewars"

-- addon setup
function test.before()
	Corewars.Init()
end
function test.after()
end
function test.test_smallerField()
	Corewars.coreMemory = {}
	for i = 0,10000 do
		Corewars.coreMemory[i] = 15
	end
	Corewars.Init()
	assertIsNil( Corewars.coreMemory[5000] )
end
function test.test_encodeAddress_immediate()
	assertEquals( 14, Corewars.EncodeAddress( "#4", 10 ) )
end
function test.test_encodeAddress_immediate_neg()
	assertEquals(  6, Corewars.EncodeAddress( "#-4", 10 ) )
end
function test.test_encodeAddress_indirect()
	assertEquals( 14, Corewars.EncodeAddress( "@4", 10 ) )
end
function test.test_encodeAddress_indirect_neg()
	assertEquals(  6, Corewars.EncodeAddress( "@-4", 10 ) )
end
function test.test_encodeAddress_relative()
	assertEquals( 0, Corewars.EncodeAddress( 4, 10 ) )
end
function test.test_encodeAddress_relative_neg()
	assertEquals( 0, Corewars.EncodeAddress( -4, 10 ) )
end
function test.test_storeInstruction_dat()
	assertEquals( 0, Corewars.EncodeInstruction( "dat", nil, 0 ) )
end
function test.test_storeInstruction_mov()
	-- 4 bits, +2, +2, +12, +12
	assertEquals( 302010388, Corewars.EncodeInstruction( "mov", "#5", "@20" ) )
end
function test.test_storeInstruction_add()
	assertEquals( 570445844, Corewars.EncodeInstruction( "add", "#4", -1 ) )
end
function test.test_storeInstruction_sub()
	assertEquals( 805306368, Corewars.EncodeInstruction( "sub", "#4", -1 ) )
end
function test.test_storeInstruction_jmp()
	assertEquals( 1073741824, Corewars.EncodeInstruction( "jmp", nil, -1 ) )
end
function test.test_storeInstruction_jmz()
	assertEquals( 1073741824, Corewars.EncodeInstruction( "jmz", "#4", -1 ) )
end
function test.test_storeInstruction_djz()
	assertEquals( 1073741824, Corewars.EncodeInstruction( "djz", "#4", -1 ) )
end
function test.test_storeInstruction_cmp()
	assertEquals( 1073741824, Corewars.EncodeInstruction( "cmp", "#4", -1 ) )
end

function test.test_emptyField()
	-- 5 = 0101
	print( bit.band( 5, 15 ) )
	print( bit.band( 16, 15 ) )
	print( 2 ^ 29 - 1 )

	x = 0

	x =     4 * 2 ^ 28   -- 1 2 28 ^ *
	x = x + 0 * 2 ^ 26  -- 0 2 26 ^ *
	x = x + 0 * 2 ^ 24  -- 2 2 24 ^ *
	x = x + 0 * 2 ^ 12  -- 5 2 12 ^ *
	x = x + 0 * 2 ^ 0  -- 20 2 0 ^ *

	print( x )

end

test.run()

--[[
 number of bits:     4         2              2         12   12
          fields:           type   mode for A     mode for B      A    B

          The example below suggests one way of encoding an instruction in
          a 32-bit  binary integer. (A somewhat different scheme, based on
          decimal integers, was given in the Scientific American artice.)

          Instruction    Fields                            Encoded Integer
          ----------------------------------------------------------------
          MOV  #5   @20  type =         1             1 * 2^28 = 268435456
                         mode for A =   0             0 * 2^26 =         0
                         mode for B =   2             2 * 2^24 =  33554432
                         A =            5             5 * 2^12 =     20480
                         B =            20            20 * 2^0 =        20
                                                                 ---------
                                                                 302010388
]]