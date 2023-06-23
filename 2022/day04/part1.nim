import os
import std/strutils
import std/sequtils

proc has_no_overlap(sections: string): bool =
   let ints = sections.split(',').mapIt(it.split('-').map(parseInt))
   result = (ints[0][0] - ints[1][0]) * (ints[0][1] - ints[1][1]) > 0

let
   input = readFile(paramStr(1)).split("\n")[0..^2]

echo input.map(has_no_overlap).count(false)
