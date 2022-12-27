module Day5

import ...parseday
import ...solveday

"""
Day 5: Alchemical Reduction
"""

function fullyreact(S)
  # Algorithm:
  # - start at index i = 1
  i = 1
  while i <= length(S) - 1
    # - repeat until i is at end of string
    while i <= length(S) - 1 && (uppercase(S[i]) == uppercase(S[i+1])) && (S[i] != S[i+1]) # reacting bases
      @debug S
      @debug repeat(" ", i - 1) * "^^"
      @debug "Removing '$(S[i:i+1])' at i = $(i), length before removal = $(length(S))"
      head = S[1:max(1, i - 1)]
      if i < length(S) - 2
        tail = S[i+2:end]
      else
        tail = ""
      end
      # - remove reacting pair and decrement i
      S = head * tail
      i = max(1, i - 1)
    end
    i += 1
  end
  return S
end

function parseday(::Val{5}, ::Val{2018})
  f(io) = io
end

function solveday(::Val{5}, ::Val{2018})
  function f(io)
    S = read(io, String) |> strip

    # How many units remain after fully reacting the polymer you scanned?
    part1 = length(fullyreact(S))

    # What is the length of the shortest polymer you can produce by removing all units of exactly one type and fully reacting the result? 
    shortest = length(S)
    alphabet = Char.(65:65+25) # uppercase
    for letter ∈ alphabet
      Srem = replace(S, lowercase(letter) => "")
      Srem = replace(Srem, letter => "")
      reactedlength = length(fullyreact(Srem))
      shortest = min(reactedlength, shortest)
      @debug letter, reactedlength, shortest
    end
    part2 = shortest

    return (part1, part2)
  end
end

end # module

using .Day5