import os
import std/strutils
import std/sequtils
import std/json

type 
  Packet = object
    integer: int
    list: seq[Packet]

func makePairs(input: seq[JsonNode]): seq[(JsonNode, JsonNode)] =
  var 
    left = newSeq[JsonNode]()
    right = newSeq[JsonNode]()
    index = 0
  while(index < input.len):
    if index mod 2 == 0:
      left.add(input[index])
    else:
      right.add(input[index])
    index += 1
  result = left.zip(right)

func inOrder(pair: (JsonNode, JsonNode)): bool =
  let
    left = pair[0]
    right = pair[1]
  debugEcho typeOf(left[0])
  result = true

let
  input = readFile(paramStr(1)).split("\n")[0..^2].filterIt(it != "").mapIt(parseJson(it))
  pairs = makePairs(input)

echo inOrder(pairs[0])

when isMainModule:
  doAssert true == true
