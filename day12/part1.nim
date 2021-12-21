import std/strutils
import std/sets
import std/tables
import std/sequtils

const filename = "input"

var
  paths = initHashSet[seq[string]]()
  nodes = initTable[string, seq[string]]()

for line in lines(filename):
  let pair = line.split('-')
  for node in pair:
    if not nodes.hasKey(node):
      nodes[node] = @[]
  nodes[pair[0]].add(pair[1])
  nodes[pair[1]].add(pair[0])

proc isLower(name: string): bool =
  toSeq(name).filterIt(it.isUpperAscii()).len == 0

proc dfs(node: string, visited: seq[string], path: seq[string], twice: string,
    appeared: bool): int =
  var
    visited_copy = visited
    path_copy = path
    appeared_copy = appeared

  path_copy.add(node)

  if node == "end":
    paths.incl(path)
    return 1

  if (isLower(node) and node != twice) or (isLower(node) and appeared):
    visited_copy.add(node)

  if node == twice:
    appeared_copy = true

  var sum = 0
  for node in nodes[node].filterIt(it notin visited):
    sum += dfs(node, visited_copy, path_copy, twice, appeared_copy)
  return sum

for small_cave in nodes.keys:
  if isLower(small_cave) and small_cave !=
      "start" and small_cave != "end":
    discard dfs("start", @[], @[], small_cave, false)

echo paths.len
