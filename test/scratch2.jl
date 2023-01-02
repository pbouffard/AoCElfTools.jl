using Graphs
g = SimpleDiGraph(26, 50)
v = 6
ns = outneighbors(g, v)
@debug ns
v2 = deepcopy(ns[1])
removed = rem_edge!(g, Edge(v, v2))
@debug ns
