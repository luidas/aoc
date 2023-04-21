import os
import std/strutils
import std/sequtils
import std/algorithm

func group_by_4(box_groups: seq[string], box: char): seq[string] =
   if box_groups[^1].len < 4:
      result = box_groups[0..^2] & @[box_groups[^1]&box]
   else:
      result = box_groups & @[""&box]

func transpose_row(columns: seq[seq[char]], row: seq[char]): seq[seq[char]] =
   result = zip(columns, row).mapIt(it[0] & @[it[1]])

let
   input = readFile(paramStr(1)).split("\n")[0..^2]
   separator = input.find("")
   boxes = input[0..separator-2].mapIt(it.foldl(group_by_4(a, b), @[""]).mapIt(
         it[1]))
   moves = input[separator+1..^1]
      .mapIt(it.split(' '))
      .mapIt(@[it[1], it[3], it[5]].map(parseInt))
      .mapIt((it[0], it[1]-1, it[2]-1))

var stacks = boxes.foldl(transpose_row(a, b), repeat(newSeq[char](), boxes[
      1].len)).mapIt(it.filterIt(it != ' '))

for move in moves:
   var to_move = stacks[move[1]][0..move[0]-1]
   to_move.reverse
   stacks[move[2]] = to_move & stacks[move[2]]
   stacks[move[1]] = stacks[move[1]][move[0]..^1]

echo stacks.mapIt(""&it[0]).foldl(a & b)
