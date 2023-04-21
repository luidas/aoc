import strutils, parseutils
import std/sequtils
import std/sugar

proc filternumbers(numbers: seq[string], oxygen: bool): string =
  var numbers = numbers
  for i in countup(0, numbers[0].len-1):
    echo numbers.len
    if numbers.len > 1:
      let
        total = numbers.len
        frequent = if numbers.map(n => n[i].int - '0'.int).foldl(a+b) / total >=
            0.5: '1' else: '0'
      if oxygen:
        numbers = numbers.filter(n => n[i] == frequent)
      else:
        numbers = numbers.filter(n => n[i] != frequent)
  return numbers[0]

const file = "input"
var numbers: seq[string] = @[]

for line in lines file:
  numbers.add(line)

let
  oxygen = filternumbers(numbers, true)
  scruber = filternumbers(numbers, false)


var
  oxygenint: int
  scrubberint: int

discard parseBin(oxygen.join, oxygenint)
discard parseBin(scruber.join, scrubberint)

echo oxygenint * scrubberint
