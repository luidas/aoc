import std/strutils

proc depth(file: string): int =
  var
    forward: int = 0
    depth: int = 0
    aim: int = 0

  for line in lines file:
    let
      split = line.split(" ")
      direction = split[0]
      amount = parseInt(split[1])
    case direction:
      of "forward":
        forward += amount
        depth += aim * amount
      of "down":
        aim += amount
      else:
        aim -= amount
  return forward * depth

echo depth("day2input")
