module Day4

import ...parseday
import ...solveday

using Dates

"""
Day 4: Repose Record
"""

@enum State init awake asleep
function readrecord(io)

  datefmt = DateFormat("[yyyy-mm-dd HH:MM")

  state = init
  # guard ID to vector of Ints indicating sleepiness for given minute
  G = Dict{Int,Array{Int,1}}()
  g = 0 # id of guard currently being processed
  tsleep = 1
  tshiftstart = 0

  for L ∈ sort(readlines(io))
    (tstr, msg) = split(L, "] ")
    tstamp = DateTime(tstr, datefmt)
    tsminute = minute(tstamp)

    if occursin("Guard", L)
      @debug "Guard"
      if state == asleep
        # handle guard-still-asleep shift change
        G[g][tsleep:end] = 1
      end #
      # Shift start
      tshiftstart = tsminute + 1
      g = parse(Int, match(r"Guard #(\d*)", msg)[1])
      if g ∉ keys(G)
        G[g] = repeat([0], 60)
      end
      state = awake
    elseif state != init && occursin("falls asleep", L)
      tsleep = tsminute + 1
      state = asleep
    elseif state != init && occursin("wakes up", L)
      G[g][tsleep:tsminute] .+= 1
      state = awake
      @debug G[g]
    end
  end

  return G
end

function solveday(::Val{4}, ::Val{2018})
  function f(io)
    G = readrecord(io)
    sg = collect(keys(G))[argmax(maximum.(sum.(values(G))))] # Sleepiest Guard 
    st = argmax(G[sg]) - 1
    @debug "Sleepiest guard is #$(sg), sleepiest at minute $(st)"
    part1 = sg * st

    gmfa = 0 # Guard most frequently asleep (on any given minute)
    fam = 0 # What minute gmfa is most frequently asleep on
    ma = 0 # minutes asleep
    for entry ∈ G
      maxma = maximum(entry.second)
      if maxma > ma
        gmfa = entry.first
        fam = argmax(entry.second) - 1
        ma = maxma
      end
    end
    part2 = gmfa * fam

    return (part1, part2)
  end
end

end # module
