module Day4

import ...parseday
import ...solveday

using Dates

@enum State init awake asleep
function day4ab(io)
  datefmt = DateFormat("[yyyy-mm-dd HH:MM")
  # fancy regex stuff, don't really need here..
  # guardrx = r"\[(.*?)\] (Guard #(\d*))? (.*)"
  # eventrx = r"\[(.*?)\] (.*)"
  state = init
  G = Dict{Int,Array{Int,1}}()
  g = 0
  tsleep = 1
  tshiftstart = 0
  lnum = 1
  for L ∈ sort(readlines(io))
    @debug "state = $(state)"
    @debug "Line #$(lnum): $(L)"
    (tstr, msg) = split(L, "] ")
    tstamp = DateTime(tstr, datefmt)
    @debug tstamp
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
      @debug g
      if g ∉ keys(G)
        G[g] = repeat([0], 60)
      end
      #G[1:max(0,tshiftstart-1)] =  # could fall asleep immediately
      @debug G[g]
      state = awake
    elseif state != init && occursin("falls asleep", L)
      @debug "sleep"
      tsleep = tsminute + 1
      state = asleep
    elseif state != init && occursin("wakes up", L)
      @debug "wake", tsleep, tsminute
      G[g][tsleep:tsminute] .+= 1
      state = awake
      @debug G[g]
    end
    lnum += 1
  end
  sg = collect(keys(G))[argmax(maximum.(sum.(values(G))))] # Sleepiest Guard 
  st = argmax(G[sg]) - 1
  @debug "Sleepiest guard is #$(sg), sleepiest at minute $(st)"
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
  return (sg * st, gmfa * fam)
end

function solveday(::Val{4}, ::Val{2018})
  function f(io)
    (part1, part2) = day4ab(io)
    return (part1, part2)
  end
end

end # module
