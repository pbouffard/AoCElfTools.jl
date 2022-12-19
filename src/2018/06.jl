module Day6

import ...parseday
import ...solveday

using ImageView

"""
Day 6: Chronal Coordinates
"""

""" Return the Manhattan distance aka L1 norm between 2 points specified by tuples """
function manhattandist(a, b)
  return abs(b[1] - a[1]) + abs(b[2] - a[2])
end


""" Return pair of tuples representing top-left and bottom-right points out of given iterator of points"""
function L1convhull(ps)
  extr = extrema(first.(ps))
  extc = extrema(last.(ps))
  return ((extr[1], extc[1]), (extr[2], extc[2]))
end

""" Given coordinate tuple q, return label for closest point in dictionary P of coordinate tuples """
function closest(q, P)
  mindist = typemax(Int)
  minkey = typemin(Int)
  for (pkey, p) ∈ P
    dist = manhattandist(p, q)
    if dist < mindist
      minkey = pkey
      mindist = dist
    end
  end
  return minkey
end

function printmap(M)
  @show size(M, 1), size(M, 2)
  for r ∈ 1:size(M, 1)
    for c ∈ 1:size(M, 2)
      print(Char(96 + M[r, c]))
      #print(" ")
    end
    print("\n")
  end

end

function closestpoints(P)
    # Find convex hull of points to properly size array
    hull = L1convhull(values(P))
    # ^ first is top-left, last is bottom-right
    nrows = hull[2][1] + 1
    ncols = hull[2][2] + 1
    rs = 1:nrows
    cs = 1:ncols
    M = zeros(Int, maximum(rs), maximum(cs))

  # Populate array
  for (pkey, (r, c)) ∈ P
    @debug pkey, (r, c)
    M[r, c] = pkey
  end
  #printmap(M) # prints points as lowercase, oh well.

  # Figure out closest point for each location in map
  for r ∈ rs
    for c ∈ cs
      pclosest = 0
      mindist = typemax(Int)
      dists = []
      for (pkey, p) ∈ P
        dist = manhattandist(p, (r, c))
        push!(dists, (dist, pkey))
      end
      @debug dists
      sort!(dists)
      @debug dists
      mindist = first(dists)[1]
      if length(dists) > 1 && dists[2][1] == mindist
        pclosest = -50 # will print as '.'
      else
        if mindist == 0
          pclosest = first(dists)[2] - (97 - 65) # capitalize
        else
          pclosest = first(dists)[2]
        end
      end
      M[r, c] = pclosest
    end
  end

  return M
end

"""What is the size of the largest area that isn't infinite? """
function day6a(P)


  M = closestpoints(P)
  (nrows, ncols) = size(M)
  imshow(M)

  # Determine largest area
  areas = []
  for pkey ∈ keys(P)
    # points in area; point's own cell is always included so add 1
    footprint = findall(M .== pkey) # cartesian indices
    # any of the footprint on edge?
    isedge = x -> x[1] == 1 || x[1] == nrows || x[2] == 1 || x[2] == ncols
    @debug footprint
    @debug isedge.(footprint)
    @debug any(isedge.(footprint))
    @debug count(footprint)
    if !any(isedge.(footprint))
      push!(areas, (length(footprint) + 1, pkey))
      area = length(footprint) + 1
    end

  end
  @info "Areas:", sort!(areas)

  #printmap(M)
  # Remove infinite areas - if a given point's footprint does not include edge cells then it is finite

  return last(areas)[1]
end

function parseday(::Val{6}, ::Val{2018})
  function p(io)
    # Read the inputs
    P = Dict{Int,Tuple{Int,Int}}()
    for (i, L) ∈ enumerate(readlines(io))
      (c, r) = Tuple(parse.(Int, split(L, ",")))
      P[i] = (r + 1, c + 1)
      @debug P[i]
    end
    return P
  end
end


function solveday(::Val{6}, ::Val{2018})
  function f(io)
    P = parseday(Val(6), Val(2018))(io)
    part1 = day6a(P)
    part2 = nothing
    return (part1, part2)
  end
end

end # module
