module Day3

import ...parseday
import ...solveday

function parseline(L)
  @debug L
  part1, part2 = split(L, "@")
  id = parse(Int, last(split(part1, "#")))
  corner, extents = split(part2, ":")
  x, y = parse.(Int, split(corner, ","))
  w, h = parse.(Int, split(extents, "x"))
  x1 = x + 1
  y1 = y + 1
  x2 = x1 + w - 1
  y2 = y1 + h - 1
  return id, (x1, y1), (x2, y2)
end

function covmap(io)
  M = zeros(Int, 2, 2) # M for 'map'

  for (lnum, L) ∈ enumerate(readlines(io))
    @debug lnum
    _, (x1, y1), (x2, y2) = parseline(L)
    r, c = size(M)
    while x2 > c || y2 > r
      Mnew = zeros(Int, 2 * r, 2 * c)
      Mnew[1:r, 1:c] = M
      M = Mnew
      r, c = size(M)
      @debug "size(M) = $(r), $(c)"
    end
    M[x1:x2, y1:y2] .+= 1
    #@info M
  end
  return M
end

function find_nonoverlapping(M, io)
  # Iterate again through the claims, looking for one where the map is all equal to 1
  for L in eachline(io)
    id, (x1, y1), (x2, y2) = parseline(L)
    if all(M[x1:x2, y1:y2] .== 1)
      @debug id, ((x1, y1), (x2, y2))
      return id
    end
  end
  @error "Didn't find a non-overlapping claim!"
end

function parseday(::Val{3}, ::Val{2018})
  f(io) = io
end

function solveday(::Val{3}, ::Val{2018})
  function f(io)
    M = covmap(io)
    part1 = count(M .> 1)
    seekstart(io)
    part2 = find_nonoverlapping(M, io)
    return (part1, part2)
  end
end

end # module

using .Day3