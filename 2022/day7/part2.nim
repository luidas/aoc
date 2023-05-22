import os
import std/sequtils
import std/strutils

const
   ls_command = "$ ls"
   cd_command = "$ cd"
   containing_dir = "dir "
   parent_dir = ".."
   total_space = 70000000
   required_space = 30000000

type
   Directory = ref object
      files: int
      children: seq[Directory]
      parent: Directory

let 
   input = readFile(paramStr(1)).split("\n")[0..^2]
   prepared_input = input.filterIt(
      not it.contains(ls_command) and 
      not it.contains(containing_dir)
   )[1..^1]

var 
   root = new Directory
   currentDir = root

for line in prepared_input:
   if line.contains(cd_command):
      if line.split(' ')[2] == parent_dir:
         currentDir = currentDir.parent
      else:
         var new_dir = Directory(parent: currentDir)
         currentDir.children.add(new_dir)
         currentDir = new_dir
   else:
      currentDir.files += parseInt(line.split(' ')[0])

func getSize(dir: Directory): int =
   result += dir.files
   for child in dir.children:
      result += getSize(child)

func getSum(dir: Directory, missing_space: int): seq[int] =
   let dir_size = getSize(dir)
   if dir_size >= missing_space:
      result.add(dir_size)
   for child in dir.children:
      result.add(getSum(child, missing_space))

let 
   free_space = total_space - getSize(root)
   missing_space = required_space - free_space

echo min(getSum(root, missing_space))
