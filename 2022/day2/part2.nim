import os
import std/strutils
import std/tables
import std/sequtils

let 
   input = readFile(paramStr(1)).split("\n")[0..^2]
   points = {"X": 0, "Y": 3, "Z": 6}.toTable
   outcomes = {
      "A": {"X": 3, "Y": 1, "Z": 2}.toTable,
      "B": {"X": 1, "Y": 2, "Z": 3}.toTable,
      "C": {"X": 2, "Y": 3, "Z": 1}.toTable
   }.toTable
   score = input.mapIt(it.split(' ')).mapIt(points[it[1]] + outcomes[it[0]][it[1]]).foldl(a+b)

echo score
