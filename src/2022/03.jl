module Day3

import ..parseday
import ..solveday

"""
    parseday(::Val{3}) -> (IO -> Vector{String})

Return a function function that parses the `IO` input into a `Vector{String}` where each
line represent's an elf's rucksack.

# Examples
```jldoctest
julia> println(read(samplepath(3), String))
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw

julia> input = open(parseday(Val(3)), samplepath(3))
6-element Vector{String}:
 "vJrwpWtwJgWrhcsFMMfFFhFp"
 "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL"
 "PmmdzqPrVvPwwTWBwg"
 "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn"
 "ttgJtRGJQctTZtZT"
 "CrZsJsPPZsGzwwsLwLmpwMDw"
```
"""
function parseday(::Val{3})
  function f(io)
    readlines(io)
  end
end

priority(item) = ((d, r) = divrem(item - 'A', 32); 27 + r - 26d)
score(sacks) = intersect(sacks...) |> only |> priority

"""
    solveday(::Val{3}) -> (Vector{String} -> Tuple{Int64, Int64}})

Solve Day 3's puzzle.
- ans₁: the total priority of items common to each half of one elf's pack
- ans₂: the total priority of items common to all three elves in a group

# Examples
```jldoctest
julia> input = open(parseday(Val(3)), samplepath(3))
6-element Vector{String}:
 "vJrwpWtwJgWrhcsFMMfFFhFp"
 "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL"
 "PmmdzqPrVvPwwTWBwg"
 "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn"
 "ttgJtRGJQctTZtZT"
 "CrZsJsPPZsGzwwsLwLmpwMDw"

julia> solveday(Val(3))(input)
(157, 70)
```
"""
function solveday(::Val{3})
  function f(input)
    ans₁ = sum(score ∘ (r -> Iterators.partition(r, length(r) ÷ 2)), input)
    ans₂ = sum(score, Iterators.partition(input, 3))
    return ans₁, ans₂
  end
end

end # module Day3

using .Day3
