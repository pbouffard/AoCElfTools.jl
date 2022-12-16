module Day6

import ..parseday
import ..solveday

"""
    parseday(::Val{6}, ::Val{2022}) -> (IO -> Tuple{Vector{Vector{Char}}, Vector{Vector{Int64}}})

Parse Day 6's puzzle input.

# Examples
```jldoctest
```
"""
function parseday(::Val{6}, ::Val{2022})
    io -> read(io, String)
end

function countunique!(out, seen, itr)
  empty!(out)
  empty!(seen)
  for x in itr
    if !in(x, seen)
      push!(seen, x)
      push!(out, x)
    end
  end
  return length(out)
end

function solvestr(data, packet_length)
  out = Set{Char}()
  seen = Set{Char}()
  countunique(itr) = countunique!(out, seen, itr)

  for i in Iterators.drop(eachindex(data), packet_length - 1)
    signal = @view data[1+i-packet_length:i]
    countunique(signal) == packet_length && return i
  end
end

"""
    solveday(::Val{6}, ::Val{2022}) -> ()

Solve Day 6's puzzle:
- ans₁: message from top crates after operating CrateMover9000
- ans₂: message from top crates after operating CrateMover9001
```
"""
function solveday(::Val{6}, ::Val{2022})
    function f(input)
        ans₁ = solvestr(input, 4)
        ans₂ = solvestr(input, 14)
        return ans₁, ans₂
    end
end

end # module

using .Day6
