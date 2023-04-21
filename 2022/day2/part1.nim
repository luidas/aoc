import os
import std/strutils
import std/tables
import std/sequtils

let 
   input = readFile(paramStr(1)).split("\n")[0..^2]
   points = {"X": 1, "Y": 2, "Z": 3}.toTable
   outcomes = {
      "A": {"X": 3, "Y": 6, "Z": 0}.toTable,
      "B": {"X": 0, "Y": 3, "Z": 6}.toTable,
      "C": {"X": 6, "Y": 0, "Z": 3}.toTable
   }.toTable
   score = input.mapIt(it.split(' ')).mapIt(points[it[1]] + outcomes[it[0]][it[1]]).foldl(a+b)

echo score
