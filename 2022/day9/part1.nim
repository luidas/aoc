import os
import std/strutils
import std/sequtils
import std/sets

type
   Position = object
      x: int
      y: int
   Grid = object
      head: Position
      tail: Position
      tail_history: HashSet[Position]
   Direction = enum
      right, left, up, down
   Move = object
      direction: Direction
      distance: int

const
   starting_position = Position(x: 0, y: 0)
   starting_grid = Grid(head: starting_position, tail: starting_position,
         tail_history: initHashSet[Position]())

func map_input_to_move(input: string): Move =
   let
      split = input.split(' ')
      distance = parseInt(split[1])
   case split[0]:
      of "R":
         result = Move(direction: right, distance: distance)
      of "L":
         result = Move(direction: left, distance: distance)
      of "U":
         result = Move(direction: up, distance: distance)
      of "D":
         result = Move(direction: down, distance: distance)

func move_head(position: Position, direction: Direction): Position =
   var new_position = position
   case direction:
      of right:
         new_position = Position(x: position.x+1, y: position.y)
      of left:
         new_position = Position(x: position.x-1, y: position.y)
      of up:
         new_position = Position(x: position.x, y: position.y+1)
      of down:
         new_position = Position(x: position.x, y: position.y-1)
   result = new_position

func should_move_diagonally(tail: Position, head: Position, diff_x: int,
      diff_y: int): bool =
   let
      same_column = tail.x == head.x
      same_row = tail.y == head.y
      not_touching = abs(diff_x) > 1 or abs(diff_y) > 1
   result = not_touching and (not same_column and not same_row)

func check_diff_and_move(diff: int, pos: int): int =
   if diff > 0:
      result = pos + 1
   else: result = pos - 1

func move_diagonally(tail: Position, diff_x: int, diff_y: int): Position =
   let
      new_x = check_diff_and_move(diff_x, tail.x)
      new_y = check_diff_and_move(diff_y, tail.y)
   result = Position(x: new_x, y: new_y)

func move_tail(tail: Position, head: Position): Position =
   let
      diff_x = head.x - tail.x
      diff_y = head.y - tail.y
   if abs(diff_x) >= 2 and diff_y == 0:
      result = Position(x: tail.x + toInt(diff_x/2), y: tail.y)
   elif abs(diff_y) >= 2 and diff_x == 0:
      result = Position(x: tail.x, y: tail.y + toInt(diff_y/2))
   elif should_move_diagonally(tail, head, diff_x, diff_y):
      result = move_diagonally(tail, diff_x, diff_y)
   else:
      result = tail

func move(grid: Grid, move: Move): Grid =
   if move.distance == 0:
      result = grid
   else:
      let
         new_head = move_head(grid.head, move.direction)
         new_tail = move_tail(grid.tail, new_head)
         new_hist = toHashSet(toSeq(grid.tail_history) & @[new_tail])
         new_grid = Grid(head: new_head, tail: new_tail,
            tail_history: new_hist)
      result = move(new_grid, Move(direction: move.direction,
            distance: move.distance-1))

let
   input = readFile(paramStr(1)).split("\n")[0..^2]
   moves = input.mapIt(map_input_to_move(it))

echo moves.foldl(move(a, b), starting_grid).tail_history.len
