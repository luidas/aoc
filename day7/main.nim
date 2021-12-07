import std/sequtils
import std/sugar
import std/strutils

const filename = "inputsimple"

let 
  f = open(filename)
  positions = f.readLine().split(',').map(s => parseInt(s))

f.close()

var minimum = high(int)

for pos in min(positions) .. max(positions):
  var fuel = 0
  for distance in positions.map(p => abs(pos-p)):
    for increment in 1 .. distance:
      fuel = fuel + increment
  if fuel < minimum:
    minimum = fuel

echo minimum
