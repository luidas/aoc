import os
import std/strutils
import std/sequtils
import std/deques

const
  start_char = 'S'
  end_char = 'E'

func find(input: seq[seq[char]], pos: char): (int, int) =
  for index, row in input:
    if row.contains(pos):
      result = (row.find(pos), index)

func neighbours(pos: (int, int), x_bound: int, y_bound: int): seq[(int, int)] =
  let
    up = (pos[0], pos[1] + 1)
    down = (pos[0], pos[1] - 1)
    left = (pos[0] - 1, pos[1])
    right = (pos[0] + 1, pos[1])
  result = @[up, down, left, right].filterIt(it[0] < x_bound and it[1] <
      y_bound and it[0] >= 0 and it[1] >= 0)

func can_visit(fr: (int, int), to: (int, int), heights: seq[seq[int]]): bool =
  let
    fr_height = heights[fr[1]][fr[0]]
    to_height = heights[to[1]][to[0]]
  return to_height - fr_height <= 1

func parseHeights(letters: seq[seq[char]], start_pos: (int, int), end_pos: (int,
    int)): seq[seq[int]] =
  var letters = letters
  letters[start_pos[1]][start_pos[0]] = 'a'
  letters[end_pos[1]][end_pos[0]] = 'z'
  result = letters.mapIt(it.mapIt(int(it) - int('a')))

func bfs(heights: seq[seq[int]], start: (int, int), end_pos: (int, int)): seq[seq[int]] =
  var
    queue = [start].toDeque
    numbers = repeat(repeat(-1, heights[0].len), heights.len)
  numbers[start[1]][start[0]] = 0
  while(queue.len > 0):
    var
      current = queue.popFirst()
      current_distance = numbers[current[1]][current[0]]
    for neighbour in neighbours(current, heights[0].len, heights.len):
      if can_visit(current, neighbour, heights) and numbers[neighbour[1]][
          neighbour[0]] == -1:
        numbers[neighbour[1]][neighbour[0]] = current_distance + 1
        queue.addLast(neighbour)
  result = numbers

let
  input = readFile(paramStr(1)).split("\n")[0..^2].mapIt(toSeq(it))
  start_pos = find(input, start_char)
  end_pos = find(input, end_char)
  heights = parseHeights(input, start_pos, end_pos)

echo bfs(heights, start_pos, end_pos)[end_pos[1]][end_pos[0]]
