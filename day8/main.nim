import std/sets
import std/sequtils
import std/sugar
import std/strutils

const
  use_simple = false

var sum = 0

let filename = if use_simple: "inputsimple" else: "input"

func get_pattern(patterns: seq[string], length: int): seq[string] =
  return patterns.filter(p => p.len == length)

for line in lines(filename):
  let
    split = line.split(" | ")
    patterns = split[0].split(' ')
    value = split[1].split(' ')
    five_segments = patterns.get_pattern(5)
    six_segments = patterns.get_pattern(6)
  var num_segments: array[0..9, string] = ["", "", "", "", "", "", "", "", "", ""]
  num_segments[1] = patterns.get_pattern(2)[0]
  num_segments[4] = patterns.get_pattern(4)[0]
  num_segments[7] = patterns.get_pattern(3)[0]
  num_segments[8] = patterns.get_pattern(7)[0]
  num_segments[3] = five_segments.filter(p => (toHashSet(@(p)) -
      toHashSet(@(num_segments[1]))).len == 3).join
  num_segments[6] = six_segments.filter(p => (p.contains(
      num_segments[1][0]) and p.contains(num_segments[1][1])) == false)[0]
  num_segments[5] = five_segments.filter(p => num_segments[6].filter(
      s => not p.contains(s)).len == 1)[0]
  num_segments[2] = five_segments.filter(p => p != num_segments[5] and
      p != num_segments[3])[0]
  num_segments[9] = six_segments.filter(p => p.filter(l =>
      not num_segments[4].contains(l)).len == 2)[0]
  num_segments[0] = patterns.filter(p => not num_segments.contains(p))[0]
  sum += parseInt(value.map(v => num_segments.find(num_segments.filter(s =>
      s.len == v.len and s.filter(l => v.contains(l)).len == s.len)[0])).join)
echo sum
