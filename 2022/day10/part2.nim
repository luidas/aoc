import os
import std/strutils
import std/sequtils

type
   CpuState = object
      register: int
      cycle: int
      screen: seq[char]

const
   start_screen = toSeq(repeat('.', 240))
   starting_state = CpuState(register: 1, screen: start_screen)
   noop = "noop"

func is_cycle_interesting(cycle: int, register: int): bool =
   let diff = abs(register - cycle mod 40)
   result = diff == 1 or diff == 0

func draw(screen: seq[char]) =
   for row in screen.distribute(6):
      debugEcho row.foldl(a & b, "")

func process_instruction(current_state: CpuState,
      instruction: string): CpuState =
   let
      inst_split = instruction.split(' ')
      inst = inst_split[0]
      current_register = current_state.register
      current_cycle = current_state.cycle
   var screen = current_state.screen
   if inst == noop:
      let noop_cycle = current_cycle + 1
      if is_cycle_interesting(current_cycle, current_register):
         screen[current_cycle] = '#'
      result = CpuState(register: current_register, cycle: noop_cycle,
            screen: screen)
   else:
      let
         intermediary_cycle = current_cycle + 1
         addx_cycle = intermediary_cycle + 1
         addx_register = current_register + parseInt(inst_split[1])
      if is_cycle_interesting(current_cycle, current_register):
         screen[current_cycle] = '#'
      if is_cycle_interesting(intermediary_cycle, current_register):
         screen[intermediary_cycle] = '#'
      result = CpuState(register: addx_register, cycle: addx_cycle,
            screen: screen)

let input = readFile(paramStr(1)).split("\n")[0..^2]

draw(input.foldl(process_instruction(a, b), starting_state).screen)
