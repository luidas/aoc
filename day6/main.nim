import std/strutils
import std/sugar
import std/sequtils

const
  filename = "input"
  days = 256
  max_age = 8

let
  f = open(filename)
  ages = f.readLine().split(',').map(s => parseInt(s))

f.close()

var age_bins = newSeq[int](max_age+1)

for age in 0 .. max_age:
  age_bins[age] = ages.filter(a => a == age).len

for day in 0 .. days:
  if days - day == 0:
    echo age_bins.foldl(a+b)
  else:
    let num_newborns = age_bins[0]
    age_bins[0] = 0
    for age in 0 .. max_age-1:
      age_bins[age] = age_bins[age+1]
    age_bins[max_age] = num_newborns
    age_bins[max_age-2] += num_newborns


