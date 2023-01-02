module Day8

import ...parseday
import ...solveday

using AoCElfTools
using MetaGraphs

"""
--- Day 8: Memory Maneuver ---

"""

struct Node
  # children::Vector{Node}
  name::Int
  metadata::Vector{Int}
  value::Int
end

struct NodeHeader
  name::Int
  nchildren::Int
  # nsibling::Int
  nmetadata::Int
  childvalues::Vector{Int}
  # depth::Int
end


"Return parsing function for Day 7"
function parseday(::Val{8}, ::Val{2018})
  function p(io)
    return eachint(io)
  end
end

function readheader!(it, name::Int)::Union{NodeHeader, Nothing}
  els = Iterators.take(it, 2) |> collect
  length(els) < 2 && return nothing
  return NodeHeader(name, els[1], els[2], [])
end

function readmetadata!(it, N)::Vector{Int}
  return collect(Iterators.take(it, N))
end

endofints(it) = ismissing(Base.isdone(it)) || Base.isdone(it)

function readnodes(it)
  nodes = Vector{Node}()
  stack = Vector{NodeHeader}()
  # (nchildren, nme tadata) = Iterators.take(it, 2)...
  nextname = 1
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
      if isempty(header.childvalues)
        value = sum(metadata)
      else
        @debug header.childvalues
        cvused = [i for i in metadata if i <= length(header.childvalues)]
        @debug cvused
        @debug header.childvalues[cvused]
        value = sum(header.childvalues[cvused])
      end

      # @debug last(stack).nchildren
      node = Node(header.name, metadata, value)
      @debug "pushing $node"
      push!(nodes, node)
      
      # record that the parent has had a child finalized
      if length(stack) > 0
        # maybe would be better just to make NodeHeader mutable?
        lastheader = pop!(stack)
        push!(lastheader.childvalues, value)
        push!(stack, NodeHeader(lastheader.name, lastheader.nchildren - 1, lastheader.nmetadata, lastheader.childvalues))
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

function readgraph(it)
  mg = MetaDiGraph()
  set_indexing_prop!(mg, :name)
end

function solveday(::Val{8}, ::Val{2018})
  function f(it)
    nodes = readnodes(it)
    # for node in nodes
    #   println(node)
    # end
    part1 = [sum(n.metadata) for n in nodes] |> sum
    part2 = last(nodes).value
    return (part1, part2)
  end
  
end

end # module

using .Day8
