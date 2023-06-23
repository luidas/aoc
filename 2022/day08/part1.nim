import os
import std/strutils
import std/sequtils

let input = readFile(paramStr(1)).split("\n")[0..^2].mapIt(toSeq(it).mapIt(
      parseInt($it)))

func reveal(tree: int, direction: seq[int]): bool =
   result = direction.len == 0 or direction.allIt(it < tree)

func visible(tree: int, directions: seq[seq[int]]): bool =
   result = anyIt(directions, reveal(tree, it))

func visible(x: int, y: int, input: seq[seq[int]]): bool =
   let
      top = input[0..y-1].mapIt(it[x])
      bottom = input[y+1..input.len-1].mapIt(it[x])
      left = input[y][0..x-1]
      right = input[y][x+1..input.len-1]
   result = visible(input[y][x], @[top, bottom, left, right])

func countVisible(grid: seq[seq[int]]): int =
   for y in 0..grid.len-1:
      for x in 0..grid[y].len-1:
         if visible(x, y, grid):
            result += 1

echo countVisible(input)
