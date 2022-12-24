module Day7

import ...parseday
import ...solveday

using MetaGraphs
using Graphs
using GraphPlot
using ProgressMeter

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
  next = []
  for step in 'A':'Z'
    try
      v = g[step, :name]
      @debug step, v, indegree(g, v)
      if indegree(g, v) == 0 && !get_prop(g, v, :processing)
        push!(next, v)
      end
    catch e
      # handle case if vertex wasn't found
      @debug "caught on $step"
    end
  end
  return next
end


function step!(g)
  step = next_ready(g)[1]
  vname = get_prop(g, step, :name)
  rem_vertex!(g, step)
  return vname
end

"Process as per part 1"
function process!(g)
  steps = []
  while nv(g) > 0
    @debug steps
    try
      step = step!(g)
      push!(steps, step)
      @debug steps
    catch e
      @debug e
      break
    end
  end
  @debug g
  return join(steps, "")
end

processingtime(c::Char, extratime) =Int(c - 64 + extratime)

verttostep(g, v) = get_prop(g, v, :name)
steptovert(g, step) = g[step, :name]

"Run one processing step, "
function step!(g, workers, extratime)
  completed = Vector{Char}()
  ready = Vector{Int}()
  work_left = 0
  # process
  @debug workers
  for i in 1:length(workers)
    worker = Ref(workers, i)
    @debug "Processing worker $(worker[])..."
    step, worker_time_left = worker[]
    @debug step, worker_time_left
    if step == '\0'
      continue
    end
    if worker_time_left == 1
      @debug "finished"
      push!(completed, step)
      rem_vertex!(g, steptovert(g, step))
      worker[] = ['\0', 0]
    else
      worker[] = [step, worker_time_left - 1]
    end
  end

  next_steps = next_ready(g)
  append!(ready, next_steps)
  sort!(ready; rev=true)
  @debug ready

  for i in 1:length(workers)
    worker = Ref(workers, i)
    if length(ready) == 0
      break
    else
      if last(worker[]) == 0
        vnew = pop!(ready)
        set_prop!(g, vnew, :processing, true)
        newstep = get_prop(g, vnew, :name) #verttostep(g, vnew)
        @debug "Assigning $vnew ($newstep) to worker $worker ($(worker[]))"
        worker[] = [newstep, processingtime(newstep, extratime)]
        @debug worker[]
        @debug workers
      end
    end
  end

  return completed
end

"Process as per part 2, with given number of workers"
function process!(g, nworkers; extratime=60)
  steps = Vector{Char}()
  workers = fill(['\0', 0], nworkers)
  N = nv(g)
  t = -1
  prog = Progress(N)
  while (n = length(steps)) < N
  # while length(steps) < N
    update!(prog, n)
    t += 1
    @debug "-----------------"
    @debug t, steps
    completed = step!(g, workers, extratime)
    append!(steps, sort(completed))
    @debug steps
  end
  @debug g
  return t, join(steps, "")
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
      @assert add_vertex!(g, :name, c)
      set_prop!(g, nv(g), :processing, false)
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
    @debug g
    return g
  end
end

function solveday(::Val{7}, ::Val{2018})
  function f(io)
    g = parseday(Val(7), Val(2018))(io)
    g2 = deepcopy(g)
    part1 = process!(g)
    (part2, steps) = process!(g2, 5)
    @debug steps
    result = (part1, part2)
    @show result
    return result
  end
end

end # module