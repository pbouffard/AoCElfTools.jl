module Day6

import ...parseday
import ...solveday

using ImageView
using ProgressMeter

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

function day6b(P)
  # input data has coordinates all 0 ≤ P ≤ 1000 so if we don't need to check negative coordinates then at worst we need to check 11000² = 121,000,000 coordinates. So this could be done in a reasonable amount of RAM naively.... Actually, this is just O(1) RAM since we just need to check each cell individually. A search algorithm might finish sooner but then we would have to keep track of things.
  #rmax, cmax = maximum(first.(values(P))), maximum(l#ast.(values(P)))
  rs = 1:11_000 #rmax
  cs = 1:11_000 #cmax
  # @info rmax, cmax
  regionsize = 0
  dmax = 10_000
  @showprogress for r ∈ rs
    for c ∈ cs
      totdist = 0
      for (pkey, p) ∈ P
        totdist += manhattandist((r, c), p)
        if totdist > dmax
          break
        end
      end
      if totdist < dmax
        regionsize += 1
      end
    end
  end
  return regionsize
  # ^ the above works but is obviously pretty janky and suboptimal time-wise (it takes about 2 sec OMM after first run). Well, at least for this input file. The region is only 0.03% of the size of the space checked so most of the work is done in vast empty regions.
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
    part2 = day6b(P)
    return (part1, part2)
  end
end

end # module
