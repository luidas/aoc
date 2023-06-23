import os
import std/strutils
import std/sequtils
import std/sets

proc priorityOfCommon(str: string): int =
   let 
      mid = int(str.len/2)
      left = str[0..mid-1]
      right = str[mid..^1]
      intersection = toHashSet(left) * toHashSet(right)
      common = toSeq(intersection)[0]
   if common.isLowerAscii:
      result = int(common) - int('a') + 1
   else:
      result = int(common) - int('A') + 27


let 
   input = readFile(paramStr(1)).split("\n")[0..^2]
   priorities = input.mapIt(priorityOfCommon(it))

echo priorities.foldL(a + b)
