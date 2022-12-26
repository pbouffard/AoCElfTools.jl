module Day4

import ..parseday
import ..solveday

"""
    parseday(::Val{4}, ::Val{2022}) -> (IO -> Vector{Int64})

```
"""
function parseday(::Val{4}, ::Val{2022})
  function f(io)
    map(readlines(io)) do pair
      map(split(pair, ',')) do assignment
        L, R = split(assignment, '-') .|> Base.Fix1(parse, Int)
        return L:R
      end
    end
  end
end

either_contains(p) = ((a, b) = p;
(a ⊆ b) | (a ⊇ b))
overlaps(p) = ((a, b) = p; !isempty(a ∩ b))

"""
    solveday(::Val{1}) -> (Vector{Int64} -> Tuple{Int64, Int64}})

Solve Day 4's puzzle:
- ans₁:
- ans₂:
```
"""
function solveday(::Val{4}, ::Val{2022})
  function f(input)
    ans₁ = sum(either_contains, input)
    ans₂ = sum(overlaps, input)
    return ans₁, ans₂
  end
end

end # module

using .Day4
