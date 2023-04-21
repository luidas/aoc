import strutils
import std/sequtils

var x: seq[int] = @[]

for line in lines "day1input":
  let integer = parseInt(line)
  x.add(integer)


var triplets: seq[int] = @[]

for i in countup(0, x.len-3):
  triplets.add(0)
  triplets[i] = x[i] + x[i+1] + x[i+2]


var increases = newSeq[int](triplets.len)
increases[0] = 0

for i, v in triplets:
  if i != 0:
    if triplets[i] > triplets[i-1]:
      increases[i] = 1
    else:
      increases[i] = 0

echo increases.foldl(a+b)
