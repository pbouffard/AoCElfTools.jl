module Day1

import ...parseday
import ...solveday

"""
Day 1: Chronal Calibration https://adventofcode.com/2018/day/1
"""

"""
Part 1 - return final frequency
Part 2 - return first frequency visited twice
"""
function chronalcalibration(inputio; part=2)
  visited = Set{Int}(0)
  found = false
  current_freq = 0
  part1 = 0
  looped_once = false
  first_revisited = 0
  maxloops = 500000
  count = 0

  while !found
    if count > maxloops
      # COV_EXCL_START
      @error "Exceeded maxloops"
      break
      # COV_EXCL_STOP
    end

    if eof(inputio)
      if part == 1
        break
      end
      seekstart(inputio)
      looped_once = true
    end

    line = readline(inputio)
    current_freq += parse(Int, line)

    if !looped_once
      part1 = current_freq
    end

    if current_freq in visited
      first_revisited = current_freq
      @debug "Revisited $(first_revisited) in $(count) loops"
      found = true
    else
      push!(visited, current_freq)
    end

    count += 1
  end

  part2 = first_revisited

  return (part1, part2)
end

function solveday(::Val{1}, ::Val{2018})
  return chronalcalibration
end

end # module

using .Day1
