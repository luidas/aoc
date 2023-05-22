import os
import std/setutils
import std/strutils

func match_packet(signal: string): int =
   for index in 0..signal.len - 4:
      let marker = signal[index..index+3]
      if marker.toSet().len == 4:
         return index+4
   return 1

let
   input = readFile(paramStr(1)).split("\n")[0..^2]

echo match_packet(input[0])

when isMainModule:
   doAssert match_packet("mjqjpqmgbljsphdztnvjfqwrcgsmlb") == 7
   doAssert match_packet("bvwbjplbgvbhsrlpgdmjqwftvncz") == 5
   doAssert match_packet("nppdvjthqldpwncqszvftbrmjlhg") == 6
   doAssert match_packet("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg") == 10
   doAssert match_packet("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw") == 11
