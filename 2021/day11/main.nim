import std/sequtils
import std/algorithm
import std/sugar

const filename = "input"

var
  levelss: seq[seq[(int, bool)]] = @[]
  step: int = 0

for line in lines(filename):
  var line_levels: seq[(int, bool)] = @[]
  for level in line:
    line_levels.add((level.int - '0'.int, false))
  levelss.add(line_levels)

while true:
  step += 1
  for i, levels in levelss:
    for j, level in levels:
      levelss[i][j] = (levelss[i][j][0] + 1, levelss[i][j][1])
  while levelss.foldl(a & b).filter(l => not l[1] and l[0] > 9).len > 0:
    for i, levels in levelss:
      for j, level in levels:
        if not level[1] and level[0] > 9:
          levelss[i][j][1] = true
          let adjacents = product(@[@[-1, 0, 1], @[-1, 0, 1]]).filterIt(it != @[
              0, 0]).mapIt((it[0]+i, it[1]+j)).filterIt(0 <= it[0] and
                  levelss.len > it[0] and 0 <= it[1] and levels.len > it[1])
          for adjacent in adjacents:
            levelss[adjacent[0]][adjacent[1]][0] += 1
  if levelss.foldl(a & b).filterIt(not it[1]).len == 0:
    echo step
    break
  for i, levels in levelss:
    for j, level in levels:
      if level[1]:
        levelss[i][j] = (0, false)
