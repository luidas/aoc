import os
import std/strutils
import std/sequtils

type
   CpuState = object
      register: int
      cycle: int
      signal_sum: int

const
   starting_state = CpuState(register: 1, cycle: 1)
   noop = "noop"
   cycles = @[20, 60, 100, 140, 180, 220]

func is_cycle_interesting(cycle: int): bool =
   result = cycles.contains(cycle)

func process_instruction(current_state: CpuState,
      instruction: string): CpuState =
   let
      inst_split = instruction.split(' ')
      inst = inst_split[0]
      current_register = current_state.register
      current_cycle = current_state.cycle
   var signal_sum = current_state.signal_sum
   if inst == noop:
      let noop_cycle = current_cycle + 1
      if is_cycle_interesting(noop_cycle):
         signal_sum = signal_sum + current_register * noop_cycle
      result = CpuState(register: current_register, cycle: noop_cycle,
            signal_sum: signal_sum)
   else:
      let
         intermediary_cycle = current_cycle + 1
         addx_cycle = intermediary_cycle + 1
         addx_register = current_register + parseInt(inst_split[1])
      if is_cycle_interesting(addx_cycle):
         signal_sum = signal_sum + addx_register * addx_cycle
      elif is_cycle_interesting(intermediary_cycle):
         signal_sum = signal_sum + intermediary_cycle * current_register
      result = CpuState(register: addx_register, cycle: addx_cycle,
            signal_sum: signal_sum)

let input = readFile(paramStr(1)).split("\n")[0..^2]

echo foldl(input, process_instruction(a, b), starting_state)
