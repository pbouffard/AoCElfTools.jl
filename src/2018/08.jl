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
  # nsibling::Int
  nmetadata::Int
  # depth::Int
end


"Return parsing function for Day 7"
function parseday(::Val{8}, ::Val{2018})
  function p(io)
    return eachint(io)
  end
end

function readheader!(it, name::Char)::Union{NodeHeader, Nothing}
  els = Iterators.take(it, 2) |> collect
  length(els) < 2 && return nothing
  return NodeHeader(name, els[1], els[2])
end

function readmetadata!(it, N)::Vector{Int}
  return collect(Iterators.take(it, N))
end

endofints(it) = ismissing(Base.isdone(it)) || Base.isdone(it)

function readnodes(it)
  nodes = Vector{Node}()
  stack = Vector{NodeHeader}()
  # (nchildren, nme tadata) = Iterators.take(it, 2)...
  nextname = 'A'
  while true
    @debug nextname
    @debug stack
    @debug nodes
    
    # if no children then collect the metadata and push to the nodes list
    while length(stack) > 0 && last(stack).nchildren == 0
      header = pop!(stack)
      @debug "popped $(header.name)"
      metadata = readmetadata!(it, header.nmetadata)
      @debug metadata
      push!(nodes, Node(header.name, metadata))
      
      # record that the parent has had a child finalized
      if length(stack) > 0
        lastheader = pop!(stack)
        push!(stack, NodeHeader(lastheader.name, lastheader.nchildren - 1, lastheader.nmetadata))
      end
    end

    read_result = readheader!(it, nextname)
    @debug read_result
    if isnothing(read_result)
      isempty(stack) && break
      continue
    end

    push!(stack,read_result)
    nextname += 1
    # isempty(stack) && break
  end

  @debug nodes
  return nodes
end

function solveday(::Val{8}, ::Val{2018})
  function f(it)
    nodes = readnodes(it)
    part1 = [sum(n.metadata) for n in nodes] |> sum

    return (part1, nothing)
  end
  
end

end # module

using .Day8
