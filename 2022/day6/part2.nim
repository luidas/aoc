import os
import std/setutils
import std/strutils

const marker_size = 14

func match_packet(signal: string): int =
   for index in 0..signal.len - marker_size:
      let marker = signal[index..index+marker_size-1]
      if marker.toSet().len == marker_size:
         return index+marker_size
   return 1

let
   input = readFile(paramStr(1)).split("\n")[0..^2]

echo match_packet(input[0])

when isMainModule:
   doAssert match_packet("mjqjpqmgbljsphdztnvjfqwrcgsmlb") == 19
   doAssert match_packet("bvwbjplbgvbhsrlpgdmjqwftvncz") == 23
   doAssert match_packet("nppdvjthqldpwncqszvftbrmjlhg") == 23
   doAssert match_packet("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg") == 29
   doAssert match_packet("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw") == 26
