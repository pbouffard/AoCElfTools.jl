module Day8

import ...parseday
import ...solveday

"""
    parseday(::Val{8}, ::Val{2022}) -> (IO -> Tuple{Vector{Vector{Char}}, Vector{Vector{Int64}}})

Parse Day 8's puzzle input.

# Examples
```jldoctest
```
"""
function parseday(::Val{8}, ::Val{2022})
  function f(io)
    lines = readlines(io)
    I, J = length(lines), length(first(lines))
    forest = zeros(Int8, I, J)
    for i in 1:I, j in 1:J
      forest[i, j] += lines[i][j] - '0'
    end
    return forest
  end
end

function getbearings(forest)
  I, J = size(forest)
  L(i) = i - I
  R(i) = i + I < I * J ? i + I : 0
  D(i) = i % J > 0 ? i + 1 : 0
  U(i) = (i - 1) % J > 0 ? i - 1 : 0
  return (L, R, D, U)
end

function checkvisibility_direction(forest)
  isvisible(i, D, h) = D(i) < 1 ? true : (forest[D(i)] < h) && isvisible(D(i), D, h)
  isvisible(i, D) = isvisible(i, D, forest[i])
  return isvisible
end

function checkvisibility(forest)
  (L, R, D, U) = getbearings(forest)
  isvisible(i, D, h) = D(i) < 1 ? true : (forest[D(i)] < h) && isvisible(D(i), D, h)
  isvisible(i, D) = isvisible(i, D, forest[i])
  isvisible(i) = isvisible(i, L) || isvisible(i, R) || isvisible(i, D) || isvisible(i, U)
  # isvisible(i) = (f=Base.Fix1(isvisible, i); f(L) || f(R) || f(D) || f(U))
  return isvisible
end

function treesviewed(i, D, forest)
  n, h = 0, forest[i]
  while true
    i = D(i) # move in the given direction
    i < 1 && break # stop counting if we have moved outside the grid
    n += 1 # add to the count of visible trees
    forest[i] >= h && break # stop counting if the view is blocked
  end
  return n
end

function checkscenery(forest)
  # (L, R, D, U) = getbearings(forest)
  # treesviewed(i, D) = treesviewed(i, D, forest)
  # scenicscore(i) = (f=Base.Fix1(treesviewed, i); f(L)*f(R)*f(D)*f(U))
  function scenicscore(i)
    score = 1
    for direction in getbearings(forest)
      score *= treesviewed(i, direction, forest)
    end
    return score
  end
  return scenicscore
end

"""
    solveday(::Val{8}, ::Val{2022}) -> ()

Solve Day 8's puzzle:
- ans₁: number of trees visible from outside the grid
- ans₂: maximum scenic score within the forest
```
"""
function solveday(::Val{8}, ::Val{2022})
  function f(forest)
    trees = eachindex(forest)
    ans₁ = count(checkvisibility(forest), trees)
    ans₂ = maximum(checkscenery(forest), trees)
    return ans₁, ans₂
  end
end

end # module

using .Day8
