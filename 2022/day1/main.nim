import os
import std/strutils
import std/sequtils

proc sum(a: seq, b: string): seq =
   if b == "":
      result = concat(a, @[0])
   else:
      result = concat(a[0..^2], @[a[^1] + parseInt(b)])

let 
   input = readFile(paramStr(1)).split("\n")
   sums = foldl(input, sum(a, b), @[0])

echo sums[maxIndex(sums)]
