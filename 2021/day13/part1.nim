import std/sugar
import std/sequtils
import std/strutils
const filename = "inputsimple"

var
  dots = newSeq[(int, int)]()
  folds = newSeq[(char, int)]()

for line in lines(filename):
  if line != "":
    if line[0] != 'f':
      let split = line.split(',').mapIt(parseInt(it))
      dots.add((split[0], split[1]))
    else:
      let split = line.split(' ')[2].split('=')
      folds.add((split[0][0], parseInt(split[1])))

let
  maxX = max(dots.mapIt(it[0]))
  maxY = max(dots.mapIt(it[1]))

var paper = newSeq[seq[bool]](maxY+1)

for line in 0 .. maxY:
  paper[line] = newSeq[bool](maxX+1)

for dot in dots:
  paper[dot[1]][dot[0]] = true

let first_fold = folds[0]

if first_fold[0] == 'y':
  let
    top_length = first_fold[1]
    bottom_length = maxY - first_fold[1]
    max_len = max(top_length, bottom_length)
  var new_paper = newSeq[seq[bool]](max_len)

  echo new_paper

for line in paper:
  echo line
