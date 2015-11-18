#!/usr/bin/env lua

require "wowTest"

test.outFileName = "testOut.xml"

package.path = "../src/?.lua;'" .. package.path
require "Corewars"

test.run()