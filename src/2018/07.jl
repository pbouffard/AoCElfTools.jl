module Day7

import ...parseday
import ...solveday

using MetaGraphs
using Graphs
using GraphPlot

"Remove any vertices with no incoming or outgoing edges"
function cull_graph(g)
  used_verts = filter(i -> indegree(g, i) != 0 || outdegree(g, i) != 0, 1:nv(g))
  g2 = induced_subgraph(g, used_verts)[1]
  set_indexing_prop!(g2, :name) # why isn't this preserved?
  @debug g2.indices
  return g2
end


"Since the vertices remain in alphabetical order whichever is the first with no incoming edges is the next step to be performed"
function next_ready(g)
  for step in 'A':'Z'
    try
      v = g[step, :name]
      @debug step, v, indegree(g, v)
      if indegree(g, v) == 0
        return v
      end
    catch e
      # handle case if vertex wasn't found
      @debug "caught on $step"
    end
  end
  # There now should be only 1 vertex remaining:
  @assert nv(g) == 1
  return 1
end


function step!(g)
  step = next_ready(g)
  vname = get_prop(g, step, :name)
  rem_vertex!(g, step)
  return vname
end

function process!(g)
  steps = []
  while nv(g) > 0
    @debug steps
    try
      step = step!(g)
      push!(steps, step)
      @info steps
    catch e
      @info e
      break
    end
  end
  @show g
  return join(steps, "")
end

function dependants(g, step_name)

end

vertex_names(g) = [props(g, i)[:name] for i in 1:nv(g)]


"Use GraphPlot to display the digraph with labeled vertices"
function gplot(g)
  labels = vertex_names(g)
  GraphPlot.gplot(g; nodelabel=labels)
end

"Return parsing function for Day 7"
function parseday(::Val{7}, ::Val{2018})
  "Construct a MetaDiGraph from the provided input"
  function p(io)
    g = MetaDiGraph()
    for c in 'A':'Z'
      add_vertex!(g, :name, c)
    end
    set_indexing_prop!(g, :name)

    pattern = r"Step ([A-Z]) must be finished before step ([A-Z]) can begin."
    for line in eachline(io)
      m = match(pattern, line)
      sstr, dstr = m.captures
      si, di = (s -> Char(only(s)) - 'A' + 1).(m.captures)
      add_edge!(g, (si, di))
    end

    g = cull_graph(g)
    @show g
    return g
  end
end

function solveday(::Val{7}, ::Val{2018})
  function f(io)
    g = parseday(Val(7), Val(2018))(io)
    g2 = deepcopy(g)
    part1 = process!(g)
    part2 = nothing
    return (part1, part2)
  end
end

end # module