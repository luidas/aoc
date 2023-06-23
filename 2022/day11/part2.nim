import os
import std/strutils
import std/sequtils
import std/options
import std/algorithm

type
   Sign = enum
      plus, star
   Operation = object
      left: Option[int]
      sign: Sign
      right: Option[int]
   Monkey = object
      items: seq[int]
      operation: Operation
      test: int
      if_true: int
      if_false: int
      inspected: int

func parseOpInt(input: string): Option[int] =
   if input == "old":
      result = none(int)
   else:
      result = some(parseInt(input))

func parseSign(input: string): Sign =
   if input == "*":
      result = Sign.star
   else:
      result = Sign.plus

func parseThrowTo(input: string): int =
   result = parseInt(input.split("monkey ")[1])

func parseMonkey(input: seq[string]): Monkey =
   let
      items = input[1].split(": ")[1].split(", ").mapIt(parseInt(it))
      operation = input[2].split("= ")[1].split(" ")
      test = parseInt(input[3].split("by ")[1])
   result = Monkey(items: items, operation: Operation(left: parseOpInt(
         operation[0]), sign: parseSign(operation[1]), right: parseOpInt(
         operation[2])), test: test, if_true: parseThrowTo(input[4]),
               if_false: parseThrowTo(input[5]))

let
   input = readFile(paramStr(1)).split("\n")[0..^2]
   monkey_count = toInt((input.len + 1) / 7)
   monkeys = input.distribute(monkey_count).mapIt(parseMonkey(it))
   lcm = monkeys.mapIt(it.test).foldl(a*b)

func adjustItem(item: int, operation: Operation, lcm: int): int =
   let
      left = operation.left.get(item)
      right = operation.right.get(item)
   case operation.sign
   of plus:
      result = left + right
   of star:
      result = left * right
   result = result mod lcm

func throwItem(fr: int, to: int, item: int, monkeys: seq[Monkey]): seq[Monkey] =
   var adjusted = monkeys
   adjusted[fr].items = monkeys[fr].items[1..^1]
   adjusted[fr].inspected = monkeys[fr].inspected + 1
   adjusted[to].items = monkeys[to].items & item
   result = adjusted

func turn(monkey_id: int, monkeys: seq[Monkey], lcm: int): seq[Monkey] =
   let
      monkey = monkeys[monkey_id]
      items = monkey.items
   if items.len == 0:
      result = monkeys
   else:
      let
         item = items[0]
         worry_level = adjustItem(item, monkey.operation, lcm)
      var target = 0
      if worry_level mod monkey.test == 0:
         target = monkey.if_true
      else:
         target = monkey.if_false
      result = turn(monkey_id, throwItem(monkey_id, target, worry_level,
            monkeys), lcm)

func round(monkeys: seq[Monkey], lcm: int): seq[Monkey] =
   var monkeys = monkeys
   for monkey_id in 0..monkeys.len-1:
      monkeys = turn(monkey_id, monkeys, lcm)
   result = monkeys

func rounds(monkeys: seq[Monkey], num: int, lcm: int): seq[Monkey] =
   var monkeys = monkeys
   for round in 1..num:
      monkeys = round(monkeys, lcm)
   result = monkeys

echo rounds(monkeys, 10000, lcm).mapIt(it.inspected).sorted(Descending)[
      0..1].foldl(a*b)
