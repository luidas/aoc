import std/sequtils
import std/algorithm
import std/sugar

const filename = "input"

var
  heightmap: seq[seq[int]] = @[]

for line in lines(filename):
  heightmap.add((@line).map(c => c.int - '0'.int))

var
  visited: seq[(int, int)] = @[]
  basin_sizes: seq[int] = @[]

proc visit(i: int, j: int): int =
  if heightmap[i][j] == 9 or visited.contains((i, j)):
    return 0
  visited.add((i, j))
  let
    up = i-1
    down = i+1
    left = j-1
    right = j+1
  var adjacent: seq[(int, int)] = @[]
  if up >= 0:
    adjacent.add((up, j))
  if down < heightmap.len:
    adjacent.add((down, j))
  if left >= 0:
    adjacent.add((i, left))
  if right < heightmap[i].len:
    adjacent.add((i, right))
  return 1 + adjacent.map(a => visit(a[0], a[1])).foldl(a+b)


for i, row in heightmap:
  for j, num in row:
    basin_sizes.add(visit(i, j))

basin_sizes.sort()
echo basin_sizes[^3 .. ^1].foldl(a*b)
