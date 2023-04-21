import std/sequtils
import std/sugar
import std/strutils

const file = "input"

let
  f = open(file)
  order = f.readLine().split(',').map(s => parseInt(s))

type
  Number = object
    num: int
    marked: bool

proc mark(number: var Number) =
  number.marked = true

var
  boards: seq[seq[seq[Number]]] = @[]
  wonboards: seq[int] = @[]

while not f.endOfFile():
  discard f.readLine()
  var board: seq[seq[Number]] = @[]
  for i in 0..4:
    var split = f.readLine().split(' ').filter(s => s != "").map(s => Number(
        num: parseInt(s), marked: false))
    board.add(split)
  boards.add(board)

for x in order:
  for i1, board in boards:
    for i2, line in board:
      for i3, number in line:
        if number.num == x:
          boards[i1][i2][i3].mark

  for i1, board in boards:
    var bingo = false
    for i2, line in board:
      if line.filter(num => num.marked == false).len == 0:
        bingo = true
        break
    for column_id in 0..board[0].len-1:
      if board.map(l => l[column_id]).filter(num => num.marked ==
        false).len == 0:
        bingo = true
        break
    if bingo and not wonboards.contains(i1):
      wonboards.add(i1)
      var sum = 0
      for line in board:
        let unmarked_numbers = line.filter(n => n.marked == false).map(n => n.num)
        if unmarked_numbers.len >= 1:
          sum += unmarked_numbers.foldl(a+b)
      echo "board ", i1+1, " ", sum * x
