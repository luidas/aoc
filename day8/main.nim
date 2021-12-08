import std/sequtils
import std/sugar
import std/strutils
const 
  use_simple = true 
  num_unique = @[2,3,4,7]

var 
  sum = 0
  num_segments: array[0..9, string]

echo num_segments

let filename = if use_simple: "inputsimple" else: "input"

func get_pattern(patterns: seq[string], length: int): string =
  return patterns.filter(p => p.len == length)[0]

for line in lines(filename):
  let 
    patterns = line.split('|')[0].split(' ')[0 .. ^2]
    one = patterns.get_pattern(2) 
    four = patterns.get_pattern(
    seven = patterns.get_pattern(3)

  echo one
  #echo patterns.filter(p => p.len == 3)[0] - patterns.filter(p => p.len == 2)[0]
  unique_appearances += line.split('|')[1][1 .. ^1].split(' ').filter(v => v.len in num_unique).len



