import std/sugar
import std/sequtils
import std/strutils

const file = "input"

type
  Point = object
    x: int
    y: int
  Line = object
    start: Point
    ends: Point

var lines: seq[Line] = @[]

for line in lines(file):
  let
    split = line.split("->")
    part1 = split[0].split(",")
    part2 = split[1].split(",")
    begin = Point(x: parseInt(part1[0]), y: parseInt(part1[1][0 .. ^2]))
    ending = Point(x: parseInt(part2[0][1 .. ^1]), y: parseInt(part2[1]))
    line = Line(start: begin, ends: ending)
  lines.add(line)


var
  maxX = 0
  maxY = 0

for line in lines:
  let
    startx = line.start.x
    endx = line.ends.x
    starty = line.start.y
    endy = line.ends.y
  if startx > maxX or endx > maxX:
    maxX = max(startx, endx)
  if starty > maxY or endy > maxY:
    maxY = max(starty, endy)

maxX += 1
maxY += 1

var diagram = newSeq[newSeq[int](maxX)](maxY)
for i, line in diagram:
  diagram[i] = repeat(0, maxX)

for line in lines:
  let
    startx = line.start.x
    endx = line.ends.x
    starty = line.start.y
    endy = line.ends.y
  for x in min(startx, endx)..max(startx, endx):
    for y in min(starty, endy)..max(starty, endy):
      if startx == endx or starty == endy or abs(startx-x) == abs(starty-y):
        diagram[y][x] += 1

echo "result ", diagram.map(x => x.filter(c => c > 1).len).foldl(a+b)
