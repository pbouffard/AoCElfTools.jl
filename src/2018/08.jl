module Day8

import ...parseday
import ...solveday

using AoCElfTools

"""
--- Day 8: Memory Maneuver ---

"""

struct Node
  # children::Vector{Node}
  name::Char
  metadata::Vector{Int}
end

struct NodeHeader
  name::Char
  nchildren::Int
  nmetadata::Int
  # depth::Int
end


"Return parsing function for Day 7"
function parseday(::Val{8}, ::Val{2018})
  function p(io)
    return eachint(io)
  end
end

function solveday(::Val{8}, ::Val{2018})
  function f(it)
    nodes = Vector{Node}()
    stack = Vector{NodeHeader}()
    push!(stack, NodeHeader('A', Iterators.take(it, 2)...))
    @show stack
    nextname = 'B'
    while !isempty(stack)
      println()
      @show nextname
      @show stack
      @show nodes
      if last(stack).nchildren == 0
        header = pop!(stack)
        @info "popped $(header.name)"
        metadata = Iterators.take(it, header.nmetadata) |> collect
        @show metadata
        push!(nodes, Node(header.name, metadata))
      else
        @info "pushing $nextname"
        last(stack) = NodeHeader()
        push!(stack, NodeHeader(nextname, Iterators.take(it, 2)...))
        nextname += 1
      end
    end

    (part1, part2) = (nothing, nothing)
    return (part1, part2)
  end
end

end # module

using .Day8
