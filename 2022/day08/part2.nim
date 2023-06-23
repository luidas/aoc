import os
import std/strutils
import std/sequtils
import std/algorithm

func seen_trees(tree: int, direction: seq[int]): int =
   let blocker_position = direction.mapIt(it < tree).find(false)
   if blocker_position == -1:
      result = direction.len
   else:
      result = direction[0..blocker_position].len

func scenic_score(tree: int, directions: seq[seq[int]]): int =
   result = directions.foldL(a * seen_trees(tree, b), 1)

func scenic_score(x: int, y: int, input: seq[seq[int]]): int =
   let
      top = input[0..y-1].mapIt(it[x]).reversed
      bottom = input[y+1..input.len-1].mapIt(it[x])
      left = input[y][0..x-1].reversed
      right = input[y][x+1..input.len-1]
   result = scenic_score(input[y][x], @[top, bottom, left, right])

func scenic_scores(grid: seq[seq[int]]): seq[int] =
   for y in 0..grid.len-1:
      for x in 0..grid[y].len-1:
         result.add(scenic_score(x, y, grid))

let input = readFile(paramStr(1)).split("\n")[0..^2].mapIt(toSeq(it).mapIt(
      parseInt($it)))
echo max(scenic_scores(input))
