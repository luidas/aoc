import os
import std/strutils
import std/sequtils
import std/sets

proc collect_groups(acc: seq[seq[string]], curr: string): seq[seq[string]] =
   if acc[^1].len < 3:
      result = acc[0..^2] & (acc[^1] & @[curr])
   else:
      result = acc & @[curr]

proc priority_of_common(group: seq[string]): int =
   let common = group.mapIt(toHashSet(it)).foldL(a*b).toSeq[0]
   if common.isLowerAscii:
      result = int(common) - int('a') + 1
   else:
      result = int(common) - int('A') + 27

let
   input = readFile(paramStr(1)).split("\n")[0..^2]
   groups_of_three = foldl(input, collect_groups(a, b), @[newSeq[string]()])

echo groups_of_three.mapIt(it.priority_of_common).foldl(a + b)
