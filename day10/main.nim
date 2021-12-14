import std/tables
import std/algorithm
import stacks

const
  filename = "input"
  opening = @['(', '[', '{', '<']
  closing = @[')', ']', '}', '>']
  scores_map = {')': 1, ']': 2, '}': 3, '>': 4}.toTable

var scores: seq[int] = @[]

for line in lines(filename):
  var
    score = 0
    expected = Stack[char]()
    corrupted = false
  for char in line:
    if opening.contains(char):
      expected.push(closing[opening.find(char)])
    else:
      let expected_char = expected.pop()
      if char != expected_char:
        corrupted = true
  if not corrupted:
    while not expected.isEmpty():
      score = score * 5 + scores_map[expected.pop()]
    scores.add(score)


scores.sort()
echo scores[int(scores.len/2)]
