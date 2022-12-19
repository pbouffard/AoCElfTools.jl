module Day7

import ...parseday
import ...solveday

"""
Day 6: The Sum of Its Parts
"""

function day7a(io)
  result = ""
  for L ∈ readlines(io)
    @info "------------------"
    pred, succ = string.([L[6], L[37]])
    @info pred, succ
    ipredrng = findfirst(pred, result)
    isuccrng = findfirst(succ, result)
    @info ipredrng == nothing ? "nothing" : ipredrng
    @info isuccrng == nothing ? "nothing" : isuccrng

    if ipredrng == nothing
      if isuccrng == nothing
        @info "case 1"
        # neither occur in result, put them at the head
        result = pred * succ * result
      else
        @info "case 2"
        # succ is already there but not pred, put pred before succ
        isucc = isuccrng[1]
        result = result[1:isucc-1] * pred * result[isucc:end]
      end
    else
      if isuccrng == nothing
        @info "case 3"
        # pred there, succ is not, insert succ after pred
        ipred = ipredrng[1]
        # .. in the first spot where it is alphabetically greater
        @info "Looking for a place for $(succ) in $(result[ipred+1:end])"
        @info "ipred = $(ipred)"
        isuccins = findfirst(x -> x > succ[1], result[ipred+1:end])
        @show isuccins
        if isuccins == nothing
          result = result * succ
        else
          inspoint = ipred + isuccins[1] - 1
          result = result[1:inspoint] * succ * result[inspoint+1:end]
        end
      else
        @info "case 4"
        # both pred and succ are there, move succ after pred if it isn't already
        ipred = ipredrng[1]
        isucc = isuccrng[1]
        @info ipred, isucc
        if isucc < ipred
          @info "Looking for a place for $(succ) in $(result[ipred+1:end])"
          isuccins = findfirst(x -> x > succ[1], result[ipred+1:end])
          if isuccins == nothing
            @info "Case 4a"
            result = result[1:isucc-1] * result[isucc+1:end] * succ
          else
            @info "Case 4b"
            result = result[1:isucc-1] * result[isucc+1:end]
            ipred -= 1
            inspoint = ipred + isuccins[1] - 1
            result = result[1:inspoint] * succ * result[inspoint+1:end]
          end
        elseif isucc == ipred
          @info "Case 4c"
          # make sure they are in alpha order
          loc1, loc2 = minmax(succ, pred)
          result = result[i:isucc-1] * loc1 * loc2 * result[isucc+2:end]
        else # isucc > ipred
          @info "Case 4d"
          # do nothing - already in order
        end
      end
    end
    @info result
  end
  return result
end

# function parseday(::Val{7}, ::Val{2018})
#   function p(io)
#     # Read the inputs
#     P = Dict{Int,Tuple{Int,Int}}()
#     for (i, L) ∈ enumerate(readlines(io))
#       (c, r) = Tuple(parse.(Int, split(L, ",")))
#       P[i] = (r + 1, c + 1)
#       @debug P[i]
#     end
#     return P
#   end
# end


function solveday(::Val{7}, ::Val{2018})
  function f(io)
    part1 = day7a(io)
    part2 = nothing
    return (part1, part2)
  end
end

end # module
