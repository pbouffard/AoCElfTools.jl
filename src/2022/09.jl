module Day9

import ...parseday
import ...solveday

function parseday(::Val{9}, ::Val{2022})
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
